import 'package:wealthflow/features/dashboard/domain/entities/asset_entity.dart';

class AssetModel extends AssetEntity {
  AssetModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.updatedAt,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      amount: (json['amount'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static List<AssetModel> fromJsonList(Map<String, dynamic> json) {
    final data = json['data'] as List;
    return data.map((e) => AssetModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
