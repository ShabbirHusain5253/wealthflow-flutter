import 'asset_model.dart';

class AssetsResponse {
  final bool success;
  final String message;
  final List<AssetModel> assets;

  AssetsResponse({
    required this.success,
    required this.message,
    required this.assets,
  });

  factory AssetsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List?;
    return AssetsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      assets: data != null
          ? data.map((e) => AssetModel.fromJson(e as Map<String, dynamic>)).toList()
          : [],
    );
  }
}
