import 'package:flutter/material.dart';
import 'package:wealthflow/core/utils/responsive.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isOutlined;
  final bool isLoading;

  const CommonButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;
    
    if (isOutlined) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height ?? Responsive.h(56),
        child: OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: (textColor ?? Colors.white).withOpacity(isDisabled ? 0.5 : 1.0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Responsive.w(8)),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: Responsive.w(20),
                  height: Responsive.w(20),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: textColor ?? Colors.white,
                  ),
                )
              : Text(
                  text,
                  style: TextStyleUtil.labelLarge(
                    color: (textColor ?? Colors.white).withOpacity(isDisabled ? 0.5 : 1.0),
                  ),
                ),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? Responsive.h(56),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF004D40), // Dark teal from SS
          disabledBackgroundColor: (backgroundColor ?? const Color(0xFF004D40)).withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Responsive.w(8)),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: Responsive.w(20),
                height: Responsive.w(20),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyleUtil.labelLarge(color: textColor ?? Colors.white),
              ),
      ),
    );
  }
}
