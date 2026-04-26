import 'package:fpdart/fpdart.dart';
import 'package:wealthflow/core/error/failure.dart';
import 'package:wealthflow/core/usecase/usecase.dart';
import 'package:wealthflow/features/auth/domain/entities/auth_entity.dart';
import 'package:wealthflow/features/auth/domain/entities/register_entity.dart';
import 'package:wealthflow/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase implements UseCase<AuthEntity, RegisterEntity> {
  final AuthRepository _repository;

  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, AuthEntity>> call({required RegisterEntity params}) async {
    return await _repository.register(params);
  }
}
