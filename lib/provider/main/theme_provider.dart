import 'package:flutter/material.dart';
import 'package:lokakarya/services/theme_preferences_service.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemePreferencesService themePreferencesService;

  ThemeProvider(this.themePreferencesService) {
    _loadTheme();
  }

  /// Get status tema saat ini
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  /// Mengatur tema yang digunakan aplikasi
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// Memuat tema dari Shared Preferences
  void _loadTheme() {
    _isDarkMode = themePreferencesService.getDarkMode();
    notifyListeners();
  }

  /// Mengubah tema dan menyimpan ke Shared Preferences
  void toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    await themePreferencesService.saveDarkMode(isDark);
    notifyListeners();
  }
}