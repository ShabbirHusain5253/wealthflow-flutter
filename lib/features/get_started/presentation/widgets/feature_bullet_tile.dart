import 'package:flutter/material.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/core/utils/common_assets_viewer.dart';

class FeatureBulletTile extends StatelessWidget {
  final String iconPath;
  final String text;
  final Animation<double> animation;

  const FeatureBulletTile({
    super.key,
    required this.iconPath,
    required this.text,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
          child: Row(
            children: [
              CommonAssetsViewer(svgPath: iconPath, fit: BoxFit.contain),
              SizedBox(width: Responsive.w(16)),
              Expanded(
                child: Text(
                  text,
                  style: TextStyleUtil.bodyLarge(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
