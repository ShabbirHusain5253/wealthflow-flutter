import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthflow/core/di/init_dependencies.dart';
import 'package:wealthflow/core/storage/app_storage.dart';
import 'package:wealthflow/features/auth/data/models/auth_model.dart';
import 'package:wealthflow/features/auth/domain/entities/register_entity.dart';
import 'package:wealthflow/features/auth/domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthCheckRequested>((event, emit) async {
      final storage = sl<AppStorage>();
      final token = storage.getToken();
      final userData = storage.getUser();
      
      if (token != null && token.isNotEmpty) {
        UserModel? user;
        if (userData != null) {
          try {
            user = UserModel.fromJson(jsonDecode(userData));
          } catch (_) {}
        }
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    });

    on<EmailChanged>((event, emit) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      emit(state.copyWith(
        email: event.email,
        isEmailValid: emailRegex.hasMatch(event.email),
        errorMessage: null,
      ));
    });

    on<PasswordChanged>((event, emit) {
      final password = event.password;
      final hasMinLength = password.length >= 8 && password.length <= 16;
      final hasNumber = password.contains(RegExp(r'[0-9]'));
      final hasSpecialChar =
          password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
      final hasUppercase = password.contains(RegExp(r'[A-Z]'));
      final hasLowercase = password.contains(RegExp(r'[a-z]'));

      final isValid = hasMinLength &&
          hasNumber &&
          hasSpecialChar &&
          hasUppercase &&
          hasLowercase;

      emit(state.copyWith(
        password: password,
        isPasswordValid: isValid,
        errorMessage: null,
      ));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });

    on<EmailSubmitted>((event, emit) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    });

    on<PasswordSubmitted>((event, emit) {
      emit(state.copyWith(
        email: event.email,
        password: event.password,
      ));
    });

    on<LogoutRequested>((event, emit) async {
      final storage = sl<AppStorage>();
      await storage.clear();
      emit(const AuthState(status: AuthStatus.unauthenticated));
    });

    on<ResetAuthRequested>((event, emit) {
      emit(const AuthState());
    });

    on<MockAuthRequested>((event, emit) {
      emit(state.copyWith(status: AuthStatus.authenticated, errorMessage: null));
    });

    on<RegisterRequested>(register);
  }

  Future<void> register(
      RegisterRequested event, Emitter<AuthState> emit) async {
    final usecase = sl.get<RegisterUsecase>();
    final entity = RegisterEntity(email: state.email, password: state.password);

    emit(state.copyWith(status: AuthStatus.loading));

    final result = await usecase.call(params: entity);
    await result.fold(
      (failure) async {
        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        ));
      },
      (response) async {
        final storage = sl<AppStorage>();
        if (response.token != null) {
          storage.saveToken(response.token!);
        }
        if (response.user != null) {
          storage.saveUser(jsonEncode((response.user as UserModel).toJson()));
        }
        
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: response.user,
          errorMessage: null,
        ));
      },
    );
  }
}
