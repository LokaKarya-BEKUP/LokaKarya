import 'package:flutter/material.dart';
import 'package:lokakarya/style/colors/app_colors.dart';
import 'package:lokakarya/style/typography/app_text_styles.dart';

class AppTheme {
  /// Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme(_lightColorScheme),
      elevatedButtonTheme: elevatedButtonTheme(_lightColorScheme),
      inputDecorationTheme: inputDecorationTheme(_lightColorScheme),
    );
  }

  /// Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme(_darkColorScheme),
      elevatedButtonTheme: elevatedButtonTheme(_darkColorScheme),
      inputDecorationTheme: inputDecorationTheme(_darkColorScheme),
    );
  }

  /// Light Mode Color Palette
  static final ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary50,
    onPrimary: Colors.white,
    secondary: AppColors.primary50,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    error: AppColors.error50,
    onError: Colors.white,
    outline: AppColors.neutral70,
  );

  /// Dark Mode Color Palette
  static final ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primary70,
    onPrimary: Colors.white,
    secondary: AppColors.primary70,
    onSecondary: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
    error: AppColors.error50,
    onError: Colors.white,
    outline: AppColors.neutral10,
  );

  /// Text Styles
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    );
  }

  /// AppBar Style
  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: _textTheme.titleLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
    );
  }

  /// ElevatedButton Style
  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 2,
        textStyle: AppTextStyles.labelLarge.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// InputDecoration Style
  static InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      /// Default Border Style
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),

      /// Enabled Border Style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(5),
      ),

      /// Focused Border Style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),

      /// Error Border Style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
        borderRadius: BorderRadius.circular(5),
      ),

      /// Label Style
      labelStyle: const TextStyle(fontSize: 14),
    );
  }
}
