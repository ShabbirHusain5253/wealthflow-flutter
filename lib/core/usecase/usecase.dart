import 'package:fpdart/fpdart.dart';
import 'package:wealthflow/core/error/failure.dart';

abstract class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call({required Params params});
}

class NoParams {}
