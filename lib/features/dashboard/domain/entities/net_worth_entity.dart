class NetWorthEntity {
  final List<NetWorthTimelineEntity> timeline;
  final DateTime lastUpdated;
  final double percentageChange;
  final double absoluteChange;

  NetWorthEntity({
    required this.timeline,
    required this.lastUpdated,
    required this.percentageChange,
    required this.absoluteChange,
  });

  double get currentNetWorth => timeline.isNotEmpty ? timeline.last.netWorth : 0.0;
}

class NetWorthTimelineEntity {
  final String id;
  final double netWorth;
  final DateTime date;

  NetWorthTimelineEntity({
    required this.id,
    required this.netWorth,
    required this.date,
  });
}
