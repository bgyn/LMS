import 'package:flutter/material.dart';
import 'package:lms/core/extension/estension.dart';

class ColorPalette {
  const ColorPalette();
  static const Color primaryColor = Color(0xFF003096);
  static const Color errorColor = Color(0xFFDC143C);
}

ThemeData getAppTheme(BuildContext context) {
  return ThemeData(
      useMaterial3: true,
      fontFamily: "PlusJakartaSans",
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      primaryColor: ColorPalette.primaryColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w700, // Bold
          fontSize: 0.05.toRes(context), // 5% of the smaller screen dimension
        ),
        displayMedium: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: 0.045.toRes(context), // 4.5%
        ),
        displaySmall: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w500, // Medium
          fontSize: 0.04.toRes(context), // 4%
        ),
        headlineMedium: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w400, // Regular
          fontSize: 0.035.toRes(context), // 3.5%
        ),
        headlineSmall: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w300, // Light
          fontSize: 0.03.toRes(context), // 3%
        ),
        titleLarge: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w700, // Bold
          fontSize: 0.03.toRes(context), // 3%
        ),
        titleMedium: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w500, // Medium
          fontSize: 0.025.toRes(context), // 2.5%
        ),
        titleSmall: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w400, // Regular
          fontSize: 0.02.toRes(context), // 2%
        ),
        bodyLarge: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w400, // Regular
          fontSize: 0.025.toRes(context), // 2.5%
        ),
        bodyMedium: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w300, // Light
          fontSize: 0.02.toRes(context), // 2%
        ),
        bodySmall: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w200, // ExtraLight
          fontSize: 0.015.toRes(context), // 1.5%
        ),
        labelLarge: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: 0.02.toRes(context), // 2%
        ),
        labelMedium: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w400, // Regular
          fontSize: 0.018.toRes(context), // 1.8%
        ),
        labelSmall: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w300, // Light
          fontSize: 0.015.toRes(context), // 1.5%
        ),
      ));
}
