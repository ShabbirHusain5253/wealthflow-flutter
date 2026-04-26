import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

extension EitherX<L, R> on Either<L, R> {
  R getOrElse(R Function() dflt) {
    return fold((_) => dflt(), (r) => r);
  }

  R? get asRight => fold((_) => null, (r) => r);
  L? get asLeft => fold((l) => l, (_) => null);
}

extension EitherFailureX<T> on Either<Failure, T> {
  T unwrapOrThrow() {
    return fold(
      (failure) => throw Exception('Unwrapped Either with Failure: ${failure.message}'),
      (value) => value,
    );
  }
}
