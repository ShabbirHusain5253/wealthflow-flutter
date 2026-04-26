import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_dashboard_event.dart';
part 'onboarding_dashboard_state.dart';

class OnboardingDashboardBloc
    extends Bloc<OnboardingDashboardEvent, OnboardingDashboardState> {
  OnboardingDashboardBloc() : super(OnboardingDashboardState.initial()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<ProceedToStep2>(_onProceedToStep2);
    on<ShowAllSet>(_onShowAllSet);
    on<CompleteOnboarding>(_onCompleteOnboarding);
  }

  Future<void> _onStartOnboarding(
    StartOnboarding event,
    Emitter<OnboardingDashboardState> emit,
  ) async {
    // Phase 1 is already emitted by initial state
    await Future.delayed(const Duration(seconds: 2));
    add(ProceedToStep2());
  }

  Future<void> _onProceedToStep2(
    ProceedToStep2 event,
    Emitter<OnboardingDashboardState> emit,
  ) async {
    emit(state.copyWith(
      subtitle: "You’re nearly there...",
      step1Status: LoadingStatus.complete,
      step2Visible: true,
      step2Status: LoadingStatus.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    add(ShowAllSet());
  }

  Future<void> _onShowAllSet(
    ShowAllSet event,
    Emitter<OnboardingDashboardState> emit,
  ) async {
    emit(state.copyWith(
      subtitle: "All set!",
    ));
    await Future.delayed(const Duration(seconds: 1));
    add(CompleteOnboarding());
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingDashboardState> emit,
  ) async {
    emit(state.copyWith(
      title: "Your personalized dashboard is ready!",
      step2Status: LoadingStatus.complete,
    ));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isComplete: true));
  }
}
