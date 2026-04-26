import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wealthflow/core/error/error_parser.dart';
import 'package:wealthflow/core/error/failure.dart';
import 'package:wealthflow/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:wealthflow/features/dashboard/domain/entities/asset_entity.dart';
import 'package:wealthflow/features/dashboard/domain/entities/net_worth_entity.dart';
import 'package:wealthflow/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, NetWorthEntity>> getNetWorth(String filter) async {
    try {
      final response = await _remoteDataSource.getNetWorth(filter);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(ErrorParser().errorMessage(e)));
    } catch (e) {
      return const Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, List<AssetEntity>>> getAssets() async {
    try {
      final response = await _remoteDataSource.getAssets();
      return Right(response.assets);
    } on DioException catch (e) {
      return Left(ServerFailure(ErrorParser().errorMessage(e)));
    } catch (e) {
      return const Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }
}
