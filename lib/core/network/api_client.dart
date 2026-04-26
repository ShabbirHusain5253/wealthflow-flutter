import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/storage_constants.dart';

import '../constants/api_constants.dart';
import '../error/exceptions.dart';

class ApiClient {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;
  VoidCallback? onUnauthorized;

  ApiClient(this._dio, this._sharedPreferences) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _sharedPreferences.getString(StorageConstants.token);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(_mapDioExceptionToCustomException(e));
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );
    }
  }

  Dio get dio => _dio;

  DioException _mapDioExceptionToCustomException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      return e.copyWith(error: const NetworkException('Connection timeout or no internet'));
    }

    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      final message = data is Map<String, dynamic> ? data['message'] : e.message;

      if (statusCode == 401 || statusCode == 403) {
        onUnauthorized?.call();
        return e.copyWith(error: AuthException(message ?? 'Authentication failed'));
      } else if (statusCode != null && statusCode >= 500) {
        return e.copyWith(error: ServerException(message ?? 'Internal Server Error'));
      } else {
        return e.copyWith(error: ServerException(message ?? 'Unexpected Error Occurred'));
      }
    }

    return e.copyWith(error: const ServerException('Unexpected Error Occurred'));
  }
}
