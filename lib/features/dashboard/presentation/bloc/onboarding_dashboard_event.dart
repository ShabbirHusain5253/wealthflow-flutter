part of 'onboarding_dashboard_bloc.dart';

abstract class OnboardingDashboardEvent extends Equatable {
  const OnboardingDashboardEvent();

  @override
  List<Object> get props => [];
}

class StartOnboarding extends OnboardingDashboardEvent {}

class ProceedToStep2 extends OnboardingDashboardEvent {}

class ShowAllSet extends OnboardingDashboardEvent {}

class CompleteOnboarding extends OnboardingDashboardEvent {}
