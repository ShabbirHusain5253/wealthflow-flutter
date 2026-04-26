import 'package:fpdart/fpdart.dart';
import 'package:wealthflow/core/error/failure.dart';
import 'package:wealthflow/core/usecase/usecase.dart';
import 'package:wealthflow/features/dashboard/domain/entities/net_worth_entity.dart';
import 'package:wealthflow/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetNetWorthUseCase implements UseCase<NetWorthEntity, String> {
  final DashboardRepository _repository;

  GetNetWorthUseCase(this._repository);

  @override
  Future<Either<Failure, NetWorthEntity>> call({required String params}) {
    return _repository.getNetWorth(params);
  }
}
