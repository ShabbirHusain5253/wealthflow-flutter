import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

class AssetsLiabilitiesSummary extends StatelessWidget {
  final double assets;
  final double liabilities;

  const AssetsLiabilitiesSummary({
    super.key,
    required this.assets,
    required this.liabilities,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: 'USD ', decimalDigits: 2);

    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Assets',
                style: TextStyleUtil.bodyMedium(
                  color: const Color(0xFF1D2939),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Liabilities',
                style: TextStyleUtil.bodyMedium(
                  color: const Color(0xFF1D2939),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.h(8)),
          Stack(
            children: [
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE4E7EC),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                height: 4,
                width: Responsive.screenWidth * 0.7, // Mocking asset ratio
                decoration: BoxDecoration(
                  color: const Color(0xFF12B76A),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.h(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currencyFormat.format(assets),
                style: TextStyleUtil.bodyLarge(
                  color: const Color(0xFF1D2939),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                currencyFormat.format(liabilities),
                style: TextStyleUtil.bodyLarge(
                  color: const Color(0xFF1D2939),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
