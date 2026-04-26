import 'package:wealthflow/features/dashboard/domain/entities/net_worth_entity.dart';

class NetWorthModel extends NetWorthEntity {
  NetWorthModel({
    required super.timeline,
    required super.lastUpdated,
    required super.percentageChange,
    required super.absoluteChange,
  });

  factory NetWorthModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return NetWorthModel(
      timeline: (data['timeline'] as List)
          .map((item) => NetWorthTimelineModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      lastUpdated: DateTime.parse(data['lastUpdated']),
      percentageChange: (data['percentageChange'] as num).toDouble(),
      absoluteChange: (data['absoluteChange'] as num).toDouble(),
    );
  }
}

class NetWorthTimelineModel extends NetWorthTimelineEntity {
  NetWorthTimelineModel({
    required super.id,
    required super.netWorth,
    required super.date,
  });

  factory NetWorthTimelineModel.fromJson(Map<String, dynamic> json) {
    return NetWorthTimelineModel(
      id: json['id'] ?? '',
      netWorth: (json['netWorth'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
