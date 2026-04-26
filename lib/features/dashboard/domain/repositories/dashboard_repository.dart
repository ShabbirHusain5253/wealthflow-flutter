import 'package:fpdart/fpdart.dart';
import 'package:wealthflow/core/error/failure.dart';
import 'package:wealthflow/features/dashboard/domain/entities/asset_entity.dart';
import 'package:wealthflow/features/dashboard/domain/entities/net_worth_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, NetWorthEntity>> getNetWorth(String filter);
  Future<Either<Failure, List<AssetEntity>>> getAssets();
}
