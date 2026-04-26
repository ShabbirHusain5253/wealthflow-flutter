import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  /// Orchestrates the splash animation sequence.
  /// This separates the timing logic from the UI layer.
  Future<void> init() async {
    // Phase 0: Initial wait before starting
    await Future.delayed(const Duration(milliseconds: 800));
    if (isClosed) return;
    emit(const SplashState(status: SplashStatus.animatingLogo));

    // Phase 1: Wait for logo slide to complete
    await Future.delayed(const Duration(milliseconds: 900));
    if (isClosed) return;
    emit(const SplashState(status: SplashStatus.animatingBranding));

    // Phase 2: Wait for branding reveal to complete
    await Future.delayed(const Duration(milliseconds: 700));
    if (isClosed) return;
    emit(const SplashState(status: SplashStatus.completed));
    
    // Note: In a real-world app, you might trigger an AuthCheck here:
    // _authBloc.add(AuthCheckRequested());
  }
}
