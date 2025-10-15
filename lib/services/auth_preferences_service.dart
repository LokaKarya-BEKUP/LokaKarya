import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferencesService {
  final SharedPreferences _authPreferences;

  AuthPreferencesService(this._authPreferences);

  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserId = 'userId';

  /// Simpan status Login dan User ID
  Future<void> setLoginStatus(bool isLoggedIn, {String? userId}) async {
    await _authPreferences.setBool(_keyIsLoggedIn, isLoggedIn);
    if (userId != null) {
      await _authPreferences.setString(_keyUserId, userId);
    }
  }

  /// Ambil status login
  Future<bool> getLoginStatus() async {
    return _authPreferences.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Ambil user ID
  Future<String?> getUserId() async {
    return _authPreferences.getString(_keyUserId);
  }

  /// Hapus status login
  Future<void> clearLoginStatus() async {
    await _authPreferences.remove(_keyIsLoggedIn);
    await _authPreferences.remove(_keyUserId);
  }
}
