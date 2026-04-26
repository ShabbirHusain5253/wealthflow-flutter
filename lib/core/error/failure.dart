import 'package:equatable/equatable.dart';

/// Base class for all business failures.
abstract class Failure extends Equatable {
  final String message;

  const Failure([this.message = 'An unexpected error occurred.']);

  @override
  List<Object?> get props => [message];
}

/// Failure representing server-side errors.
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

/// Failure representing network connectivity issues.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

/// Failure representing authentication errors.
class AuthFailure extends Failure {
  const AuthFailure([super.message]);
}

/// Failure representing cache-related errors.
class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}
