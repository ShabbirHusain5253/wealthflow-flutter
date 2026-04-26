import 'package:equatable/equatable.dart';
import 'package:wealthflow/features/auth/domain/entities/auth_entity.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isEmailValid;
  final bool isPasswordValid;
  final String? errorMessage;
  final UserEntity? user;

  const AuthState({
    this.status = AuthStatus.initial,
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.errorMessage,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isEmailValid,
    bool? isPasswordValid,
    String? errorMessage,
    UserEntity? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        isPasswordVisible,
        isEmailValid,
        isPasswordValid,
        errorMessage,
        user,
      ];
}
