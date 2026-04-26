import 'package:flutter/material.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

import 'package:wealthflow/core/utils/common_assets_viewer.dart';
import 'package:wealthflow/core/gen/assets.gen.dart';

class ServicesVaultSection extends StatelessWidget {
  const ServicesVaultSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InfoCard(
            title: 'Services',
            description:
                'Speak with an expert to receive help in achieving your goals',
            svgPath: Assets.svgs.dashboard.phone.path,
          ),
        ),
        SizedBox(width: Responsive.w(16)),
        Expanded(
          child: InfoCard(
            title: 'Vault',
            description: 'Store your documents securely, only you can access them',
            svgPath: Assets.svgs.dashboard.vault.path,
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String svgPath;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      height: Responsive.h(180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E7EC)),
      ),
      child: Column(
        children: [
          CommonAssetsViewer(
            svgPath: svgPath,
            width: 48,
            height: 48,
          ),
          SizedBox(height: Responsive.h(12)),
          Text(
            title,
            style: TextStyleUtil.sentientStyle(
              fontSize: Responsive.sp(16),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D2939),
            ),
          ),
          SizedBox(height: Responsive.h(4)),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyleUtil.bodySmall(
              color: const Color(0xFF667085),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
