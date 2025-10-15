import 'package:flutter/foundation.dart';
import 'package:lokakarya/data/model/user.dart';
import 'package:lokakarya/services/auth_preferences_service.dart';
import 'package:lokakarya/services/firebase_auth_service.dart';
import 'package:lokakarya/services/firestore_user_service.dart';

import '../../../static/firebase_auth_status.dart';

class SignInProvider extends ChangeNotifier {
  final FirebaseAuthService _authService;
  final FirestoreUserService _userService;
  final AuthPreferencesService _preferencesService;

  SignInProvider(
    this._authService,
    this._userService,
    this._preferencesService,
  );

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  UserModel? _user;
  UserModel? get user => _user;

  String? _message;
  String? get message => _message;

  FirebaseAuthStatus _authStatus = FirebaseAuthStatus.unauthenticated;
  FirebaseAuthStatus get authStatus => _authStatus;

  /// Toggle Password Visibility
  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  /// Sign In process
  Future signInUser(String email, String password) async {
    try {
      _authStatus = FirebaseAuthStatus.authenticating;
      _message = null;
      notifyListeners();

      /// Proses login dengan Firebase Auth
      final result = await _authService.signInUser(email, password);
      final firebaseUser = result.user;

      /// Ambil data User dari Firestore
      _user = await _userService.getUserById(firebaseUser!.uid);

      /// Simpan status login ke Shared Preferences
      await _preferencesService.setLoginStatus(true, userId: _user!.id);

      _authStatus = FirebaseAuthStatus.authenticated;
      _message = "Login berhasil.";
    } catch (e) {
      _message = e.toString().replaceFirst("Exception: ", "");
      _authStatus = FirebaseAuthStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /// Sign Out Process
  Future signOutUser() async {
    try {
      _authStatus = FirebaseAuthStatus.signingOut;
      _message = null;
      notifyListeners();

      await _authService.signOut();

      /// Hapus status login
      await _preferencesService.clearLoginStatus();

      _authStatus = FirebaseAuthStatus.unauthenticated;
      _message = "Logout berhasil.";
    } catch (e) {
      _message = e.toString().replaceFirst("Exception: ", "");
      _authStatus = FirebaseAuthStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
