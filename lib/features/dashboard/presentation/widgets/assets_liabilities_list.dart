import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';
import 'package:intl/intl.dart';
import 'package:wealthflow/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AssetsLiabilitiesList extends StatelessWidget {
  const AssetsLiabilitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AssetsCard(),
        SizedBox(height: Responsive.h(16)),
        const LiabilitiesCard(),
      ],
    );
  }
}

class AssetsCard extends StatelessWidget {
  const AssetsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Assets',
                style: TextStyleUtil.sentientStyle(
                  fontSize: Responsive.sp(20),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1D2939),
                ),
              ),
              const Icon(Icons.add_circle_outline, color: Color(0xFF1D2939)),
            ],
          ),
          SizedBox(height: Responsive.h(16)),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state.assetStatus == DashboardStatus.loading) {
                return _buildShimmer();
              }
              if (state.assetList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'No assets found',
                      style: TextStyleUtil.bodySmall(color: const Color(0xFF667085)),
                    ),
                  ),
                );
              }

              // Displaying with limited height if more than 4 items
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: state.assetList.length > 4 ? Responsive.h(320) : double.infinity,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: state.assetList.length > 4 
                      ? const AlwaysScrollableScrollPhysics() 
                      : const NeverScrollableScrollPhysics(),
                  itemCount: state.assetList.length,
                  separatorBuilder: (context, index) => const Divider(height: 32, color: Color(0xFFF2F4F7)),
                  itemBuilder: (context, index) {
                    final asset = state.assetList[index];
                    return AssetCategoryItem(
                      title: asset.name,
                      amount: asset.amount,
                      svgPath: _getIconForAsset(asset.id),
                      hasAddButton: asset.amount == 0,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Column(
      children: List.generate(
          4,
          (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Shimmer.fromColors(
                  baseColor: const Color(0xFFF2F4F7),
                  highlightColor: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 150,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }

  String _getIconForAsset(String id) {
    final icons = [
      Assets.svgs.dashboard.cashAccounts.path,
      Assets.svgs.dashboard.investment.path,
      Assets.svgs.dashboard.pension.path,
      Assets.svgs.dashboard.properties.path,
    ];
    // Simple deterministic hash-like seeding
    final index = id.codeUnits.reduce((a, b) => a + b) % icons.length;
    return icons[index];
  }
}

class AssetCategoryItem extends StatelessWidget {
  final String title;
  final double amount;
  final String svgPath;
  final bool hasAddButton;

  const AssetCategoryItem({
    super.key,
    required this.title,
    required this.amount,
    required this.svgPath,
    this.hasAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: 'USD ', decimalDigits: 2);

    return Row(
      children: [
        CommonAssetsViewer(
          svgPath: svgPath,
          width: 48,
          height: 48,
        ),
        SizedBox(width: Responsive.w(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyleUtil.bodyMedium(
                  color: const Color(0xFF667085),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                currencyFormat.format(amount),
                style: TextStyleUtil.bodyLarge(
                  color: const Color(0xFF1D2939),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (hasAddButton)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF083332),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Add',
              style: TextStyleUtil.bodySmall(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          const Icon(Icons.chevron_right, color: Color(0xFF667085)),
      ],
    );
  }
}

class LiabilitiesCard extends StatelessWidget {
  const LiabilitiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Liabilities',
                style: TextStyleUtil.sentientStyle(
                  fontSize: Responsive.sp(20),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1D2939),
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF1D2939)),
            ],
          ),
          SizedBox(height: Responsive.h(8)),
          Text(
            'You currently have no liabilities added to your profile.',
            style: TextStyleUtil.bodySmall(
              color: const Color(0xFF667085),
            ),
          ),
        ],
      ),
    );
  }
}
