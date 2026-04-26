import 'package:flutter/material.dart';
import 'package:wealthflow/config/theme/textstyles/text_style_util.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color primaryDarkColor = Color(0xFF1565C0);
  static const Color secondaryColor = Color(0xFF43A047);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          surface: surfaceColor,
          onSurface: primaryText,
        ),
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: TextStyleUtil.inter,
        textTheme: TextTheme(
          displayLarge: TextStyleUtil.h1(),
          displayMedium: TextStyleUtil.h2(),
          displaySmall: TextStyleUtil.h3(),
          headlineMedium: TextStyleUtil.h4(),
          titleLarge: TextStyleUtil.sentientStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyleUtil.bodyLarge(),
          bodyMedium: TextStyleUtil.bodyMedium(),
          labelLarge: TextStyleUtil.labelLarge(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: TextStyleUtil.labelLarge(),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          hintStyle: TextStyleUtil.bodyMedium(color: Colors.black),
        ),
        cardTheme: CardTheme(
          color: surfaceColor,
          elevation: 2,
          shadowColor: const Color(0xFFE0E0E0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.zero,
        ));
  }
}
