import 'package:flutter/material.dart';

class TextStyleUtil {
  TextStyleUtil._();

  static const String sentient = 'Sentient';
  static const String inter = 'Inter';

  static TextStyle sentientStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = const Color(0xFF212121),
    FontStyle fontStyle = FontStyle.normal,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: sentient,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  static TextStyle interStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = const Color(0xFF212121),
    FontStyle fontStyle = FontStyle.normal,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: inter,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  static TextStyle h1({Color? color, double? height}) => sentientStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: color ?? const Color(0xFF212121),
        height: height,
      );

  static TextStyle h2({Color? color, double? height}) => sentientStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: color ?? const Color(0xFF212121),
        height: height,
      );

  static TextStyle h3({Color? color, double? height}) => sentientStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color ?? const Color(0xFF212121),
        height: height,
      );

  static TextStyle h4({Color? color, double? height}) => sentientStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color ?? const Color(0xFF212121),
        height: height,
      );

  static TextStyle bodyLarge({Color? color, FontWeight? fontWeight, double? height}) => interStyle(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF212121),
        height: height,
      );

  static TextStyle bodyMedium({Color? color, FontWeight? fontWeight, double? height}) => interStyle(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF212121),
        height: height,
      );

  static TextStyle bodySmall({Color? color, FontWeight? fontWeight, double? height}) => interStyle(
        fontSize: 12,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF757575),
        height: height,
      );

  static TextStyle labelLarge({Color? color, double? height}) => interStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color ?? Colors.white,
        height: height,
      );
}
