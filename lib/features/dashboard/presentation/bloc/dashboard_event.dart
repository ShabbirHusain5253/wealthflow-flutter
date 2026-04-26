part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class FetchDashboardData extends DashboardEvent {}

class ChangeChartPeriod extends DashboardEvent {
  final String period;
  const ChangeChartPeriod(this.period);

  @override
  List<Object?> get props => [period];
}

class FetchAssets extends DashboardEvent {}
