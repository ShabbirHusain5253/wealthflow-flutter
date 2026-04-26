part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, loaded, error }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final String selectedPeriod;
  final List<FlSpot> chartData;
  final double netWorth;
  final double netWorthChange;
  final double netWorthChangePercentage;
  final double assets;
  final double liabilities;
  final DateTime? lastUpdated;
  final List<AssetEntity> assetList;
  final DashboardStatus assetStatus;

  const DashboardState({
    required this.status,
    required this.selectedPeriod,
    required this.chartData,
    required this.netWorth,
    required this.netWorthChange,
    required this.netWorthChangePercentage,
    required this.assets,
    required this.liabilities,
    required this.assetList,
    required this.assetStatus,
    this.lastUpdated,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      status: DashboardStatus.initial,
      selectedPeriod: '1W',
      chartData: [],
      netWorth: 12500000.00,
      netWorthChange: 234567.89,
      netWorthChangePercentage: 6.89,
      assets: 50000000.00,
      liabilities: 0.00,
      assetList: [],
      assetStatus: DashboardStatus.initial,
    );
  }

  DashboardState copyWith({
    DashboardStatus? status,
    String? selectedPeriod,
    List<FlSpot>? chartData,
    double? netWorth,
    double? netWorthChange,
    double? netWorthChangePercentage,
    double? assets,
    double? liabilities,
    DateTime? lastUpdated,
    List<AssetEntity>? assetList,
    DashboardStatus? assetStatus,
  }) {
    return DashboardState(
      status: status ?? this.status,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      chartData: chartData ?? this.chartData,
      netWorth: netWorth ?? this.netWorth,
      netWorthChange: netWorthChange ?? this.netWorthChange,
      netWorthChangePercentage:
          netWorthChangePercentage ?? this.netWorthChangePercentage,
      assets: assets ?? this.assets,
      liabilities: liabilities ?? this.liabilities,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      assetList: assetList ?? this.assetList,
      assetStatus: assetStatus ?? this.assetStatus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedPeriod,
        chartData,
        netWorth,
        netWorthChange,
        netWorthChangePercentage,
        assets,
        liabilities,
        lastUpdated,
        assetList,
        assetStatus,
      ];
}
