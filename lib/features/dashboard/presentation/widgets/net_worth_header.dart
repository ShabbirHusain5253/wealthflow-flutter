import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';

class NetWorthHeader extends StatelessWidget {
  final double amount;
  final double change;
  final double percentage;
  final DateTime? lastUpdated;

  const NetWorthHeader({
    super.key,
    required this.amount,
    required this.change,
    required this.percentage,
    this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(symbol: 'USD ', decimalDigits: 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Net Worth',
              style: TextStyleUtil.bodyMedium(
                color: const Color(0xFF667085),
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonAssetsViewer(
                  svgPath: Assets.svgs.dashboard.notification.path,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: Responsive.w(12)),
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: CommonAssetsViewer(
                    svgPath: Assets.svgs.dashboard.menu.path,
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          currencyFormat.format(amount),
          style: TextStyleUtil.sentientStyle(
            fontSize: Responsive.sp(32),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D2939),
          ),
        ),
        SizedBox(height: Responsive.h(4)),
        Row(
          children: [
            CommonAssetsViewer(
              svgPath: Assets.svgs.dashboard.arrowUp.path,
              width: 12,
              height: 12,
              svgColor: const Color(0xFF12B76A),
            ),
            const SizedBox(width: 4),
            Text(
              'USD ${NumberFormat('#,##0.00').format(change)} (${percentage.toStringAsFixed(2)}%)',
              style: TextStyleUtil.bodyMedium(
                color: const Color(0xFF12B76A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.h(4)),
        Text(
          lastUpdated != null
              ? 'Last updated ${DateFormat('MMM d, HH:mm').format(lastUpdated!)}'
              : 'Last updated 9 hours ago',
          style: TextStyleUtil.bodySmall(
            color: const Color(0xFF667085),
          ),
        ),
      ],
    );
  }
}
