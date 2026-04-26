import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';
import 'package:wealthflow/features/dashboard/presentation/bloc/onboarding_dashboard_bloc.dart';
import 'rotating_loader.dart';

class LoadingStepWidget extends StatelessWidget {
  final String text;
  final LoadingStatus status;
  final bool isVisible;

  const LoadingStepWidget({
    super.key,
    required this.text,
    required this.status,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isVisible ? (status == LoadingStatus.idle ? 0.4 : 1.0) : 0.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        margin: EdgeInsets.only(top: isVisible ? 16 : 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyleUtil.interStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: status == LoadingStatus.idle
                    ? Colors.white.withOpacity(0.4)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    switch (status) {
      case LoadingStatus.loading:
        return const RotatingLoader(size: 22);
      case LoadingStatus.complete:
        return SvgPicture.asset(
          'assets/svgs/check_box.svg',
          width: 22,
          height: 22,
        );
      case LoadingStatus.idle:
      default:
        return Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1.5,
            ),
          ),
        );
    }
  }
}
