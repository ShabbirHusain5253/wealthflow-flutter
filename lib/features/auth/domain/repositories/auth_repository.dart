import 'package:fpdart/fpdart.dart';
import 'package:wealthflow/core/error/failure.dart';
import 'package:wealthflow/features/auth/domain/entities/auth_entity.dart';
import 'package:wealthflow/features/auth/domain/entities/register_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> register(RegisterEntity entity);
}
