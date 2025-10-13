import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferencesService {
  final SharedPreferences _themePreferences;

  ThemePreferencesService(this._themePreferences);

  static const String _keyDarkMode = "DARK_MODE";

  /// Menyimpan status Dark Mode
  Future<bool> saveDarkMode(bool isDark) async {
    return await _themePreferences.setBool(_keyDarkMode, isDark);
  }

  /// Mengambil status Dark Mode dari Shared Prefs
  bool getDarkMode() {
    return _themePreferences.getBool(_keyDarkMode) ?? false;
  }
}