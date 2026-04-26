part of 'onboarding_dashboard_bloc.dart';

enum LoadingStatus { idle, loading, complete }

class OnboardingDashboardState extends Equatable {
  final String title;
  final String subtitle;
  final LoadingStatus step1Status;
  final LoadingStatus step2Status;
  final bool step2Visible;
  final bool isComplete;

  const OnboardingDashboardState({
    required this.title,
    required this.subtitle,
    required this.step1Status,
    required this.step2Status,
    required this.step2Visible,
    this.isComplete = false,
  });

  factory OnboardingDashboardState.initial() {
    return const OnboardingDashboardState(
      title: "We are building your dashboard",
      subtitle: "It will only take a moment, John.",
      step1Status: LoadingStatus.loading,
      step2Status: LoadingStatus.idle,
      step2Visible: false,
    );
  }

  OnboardingDashboardState copyWith({
    String? title,
    String? subtitle,
    LoadingStatus? step1Status,
    LoadingStatus? step2Status,
    bool? step2Visible,
    bool? isComplete,
  }) {
    return OnboardingDashboardState(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      step1Status: step1Status ?? this.step1Status,
      step2Status: step2Status ?? this.step2Status,
      step2Visible: step2Visible ?? this.step2Visible,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object> get props => [
        title,
        subtitle,
        step1Status,
        step2Status,
        step2Visible,
        isComplete,
      ];
}
