// lib/provider/main/profile_provider.dart
import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/user.dart';
import 'package:lokakarya/services/auth_preferences_service.dart';
import 'package:lokakarya/services/firebase_auth_service.dart';
import 'package:lokakarya/services/firestore_user_service.dart';
import 'package:lokakarya/utils/error_handler.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuthService _authService;
  final FirestoreUserService _userService;
  final AuthPreferencesService _preferencesService;

  ProfileProvider(
    this._authService,
    this._userService,
    this._preferencesService,
  ) {
    // Stream perubahan user login/logout
    _authService.authStateChanges.listen((firebaseUser) async {
      // Jika logout secara manual, jangan trigger rebuild
      if (_isSigningOut) return;

      if (firebaseUser != null) {
        // Jika user login, ambil data dari Firestore
        await loadUserProfile(firebaseUser.uid);
      } else {
        // Jika user logout, hapus data lokal
        _user = null;
        notifyListeners();
      }
    });

    // Cek apakah user sudah login
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      loadUserProfile(currentUser.uid);
    }
  }

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isSigningOut = false;

  /// Ambil data profil user yang sedang Login
  Future<void> loadUserProfile(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userData = await _userService.getUserById(userId);
      if (userData != null) {
        _user = userData;
      } else {
        _errorMessage = "Data user tidak ditemukan";
      }
    } on Exception catch (e) {
      _errorMessage = getErrorMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update nama user
  Future<void> updateUserName(String newName) async {
    if (_user == null || newName.isEmpty) return;

    try {
      await _userService.updateUserName(_user!.id, newName);
      _user = _user!.copyWith(name: newName);
    } on Exception catch (e) {
      _errorMessage = getErrorMessage(e);
    } finally {
      notifyListeners();
    }
  }

  /// Logout user
  Future<void> signOut(BuildContext context) async {
    try {
      _isSigningOut = true;
      _errorMessage = null;

      // Sign Out dari Firebase dan hapus login status
      await _authService.signOut();
      await _preferencesService.clearLoginStatus();

      _user = null;

      // Setelah navigasi selesai, reset flag & notify
      await Future.delayed(const Duration(milliseconds: 300));
      _isSigningOut = false;
    } on Exception catch (e) {
      _errorMessage = getErrorMessage(e);
      _isSigningOut = false;
      notifyListeners();
    }
  }
}
