import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// App theme configurations matching authentic Telegram UI specs.
class AppTheme {
  AppTheme._();

  /// Light theme definition (Telegram Classic Blue).
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      primary: AppColors.primaryBlue,
      surface: AppColors.lightSurface,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
      elevation: 3,
      shape: CircleBorder(),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE7ECEF),
      thickness: 0.7,
      space: 0,
    ),
  );

  /// Dark theme definition (Telegram Dark mode).
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      primary: AppColors.accentBlue,
      surface: AppColors.darkSurface,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF5288C1),
      foregroundColor: Colors.white,
      elevation: 3,
      shape: CircleBorder(),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF131D26),
      thickness: 0.7,
      space: 0,
    ),
  );
}
