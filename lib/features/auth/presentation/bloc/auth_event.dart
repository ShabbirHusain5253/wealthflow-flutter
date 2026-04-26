import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class EmailChanged extends AuthEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends AuthEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class TogglePasswordVisibility extends AuthEvent {
  const TogglePasswordVisibility();
}

class EmailSubmitted extends AuthEvent {
  final String email;
  const EmailSubmitted(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordSubmitted extends AuthEvent {
  final String email;
  final String password;
  const PasswordSubmitted(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {}

class MockAuthRequested extends AuthEvent {
  const MockAuthRequested();
}

class ResetAuthRequested extends AuthEvent {
  const ResetAuthRequested();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
