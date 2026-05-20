import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static const double spacingXs = 8;
  static const double spacingSm = 12;
  static const double spacingMd = 16;
  static const double spacingLg = 24;

  static ThemeData light() {
    final ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      outline: AppColors.buttonDisabledBg,
      outlineVariant: AppColors.dialogPrimaryBorder,
      // Add other required fields as needed for your app
    );

    return ThemeData(
      fontFamily: 'Gilroy400',
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      // textTheme: const TextTheme(
      //   headlineMedium: AppTextStyles.h1,
      //   titleMedium: AppTextStyles.h2,
      //   bodyMedium: AppTextStyles.body,
      //   bodySmall: AppTextStyles.caption,
      // ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        rangeSelectionBackgroundColor: colorScheme.primary.withValues(
          alpha: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: Color(0xFF23262F),
      onSurface: AppColors.buttonPrimaryText,
      outline: AppColors.buttonDisabledBg,
      outlineVariant: AppColors.dialogPrimaryBorder,
      // Add other required fields as needed for your app
    );

    return ThemeData(
      fontFamily: 'Gilroy',
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      // textTheme: const TextTheme(
      //   headlineMedium: AppTextStyles.h1,
      //   titleMedium: AppTextStyles.h2,
      //   bodyMedium: AppTextStyles.body,
      //   bodySmall: AppTextStyles.caption,
      // ),
      datePickerTheme: DatePickerThemeData(
        rangeSelectionBackgroundColor: colorScheme.primary.withValues(
          alpha: 0.5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
    );
  }
}
