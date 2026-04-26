import 'package:fpdart/fpdart.dart';
import 'package:wealthflow/core/error/failure.dart';
import 'package:wealthflow/core/usecase/usecase.dart';
import 'package:wealthflow/features/dashboard/domain/entities/asset_entity.dart';
import 'package:wealthflow/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetAssetsUseCase implements UseCase<List<AssetEntity>, NoParams> {
  final DashboardRepository _repository;

  GetAssetsUseCase(this._repository);

  @override
  Future<Either<Failure, List<AssetEntity>>> call({required NoParams params}) {
    return _repository.getAssets();
  }
}
