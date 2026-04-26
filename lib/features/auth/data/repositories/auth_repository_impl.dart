import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:wealthflow/core/error/error_parser.dart';
import 'package:wealthflow/core/error/failure.dart';
import 'package:wealthflow/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:wealthflow/features/auth/data/models/auth_model.dart';
import 'package:wealthflow/features/auth/data/models/register_model.dart';
import 'package:wealthflow/features/auth/domain/entities/register_entity.dart';
import 'package:wealthflow/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AuthModel>> register(RegisterEntity entity) async {
    try {
      final registerModel = RegisterModel.fromEntity(entity);
      final httpResponse = await _remoteDataSource.register(registerModel);

      if ((httpResponse.response.statusCode == 200 || httpResponse.response.statusCode == 201) && httpResponse.data.success) {
        return Right(httpResponse.data);
      } else {
        return Left(ServerFailure(httpResponse.data.message));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(ErrorParser().errorMessage(e)));
    } catch (e) {
      return const Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }
}
