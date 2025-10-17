import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferencesService {
  final SharedPreferences _authPreferences;

  AuthPreferencesService(this._authPreferences);

  static const String _keyIsLoggedIn = 'isLoggedIn';

  /// Simpan status Login dan User ID
  Future<void> setLoginStatus(bool isLoggedIn) async {
    await _authPreferences.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  /// Ambil status login
  Future<bool> getLoginStatus() async {
    return _authPreferences.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Hapus status login
  Future<void> clearLoginStatus() async {
    await _authPreferences.remove(_keyIsLoggedIn);
  }
}
