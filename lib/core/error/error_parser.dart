import 'dart:convert';
import 'package:dio/dio.dart';

class ErrorParser {
  /// Extracts a human-readable error message from a [DioException].
  String errorMessage(DioException e) {
    // 1. Check if there's a response from the server
    if (e.response != null && e.response?.data != null) {
      final dynamic responseData = e.response!.data;

      try {
        Map<String, dynamic>? data;
        
        if (responseData is Map<String, dynamic>) {
          data = responseData;
        } else if (responseData is String) {
          data = jsonDecode(responseData) as Map<String, dynamic>;
        }

        if (data != null && data.containsKey('message')) {
          return data['message'].toString();
        }
      } catch (_) {
        // Fallback if parsing fails
      }
    }

    // 2. Check for Dio-specific errors (timeouts, etc.)
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection timed out. Please check your internet.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        return 'Server returned an invalid response.';
      default:
        return e.message ?? 'An unexpected error occurred.';
    }
  }
}
