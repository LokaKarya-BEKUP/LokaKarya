import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lokakarya/data/model/user.dart';
import 'package:lokakarya/services/firebase_auth_service.dart';
import 'package:lokakarya/services/firestore_user_service.dart';
import 'package:lokakarya/static/firebase_auth_status.dart';

class SignUpProvider extends ChangeNotifier {
  final FirebaseAuthService _authService;
  final FirestoreUserService _userService;

  SignUpProvider(this._authService, this._userService);

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  String? _message;
  String? get message => _message;

  UserModel? _user;
  UserModel? get user => _user;

  FirebaseAuthStatus _authStatus = FirebaseAuthStatus.unauthenticated;
  FirebaseAuthStatus get authStatus => _authStatus;

  /// Toggle Password Visibility
  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  /// Fungsi Register Akun
  Future createAccount(String name, String email, String password) async {
    try {
      _authStatus = FirebaseAuthStatus.creatingAccount;
      _message = null;
      notifyListeners();

      /// Proses register akun di Firebase Auth
      final result = await _authService.createUser(email, password);
      final firebaseUser = result.user;

      /// Validasi hasil
      if (firebaseUser == null) {
        _message = "Pendaftaran gagal. Silahkan coba lagi.";
        _authStatus = FirebaseAuthStatus.error;
        notifyListeners();
        return;
      }

      /// Perbarui displayName
      await firebaseUser.updateDisplayName(name);

      /// Buat model User
      _user = UserModel(
        id: firebaseUser.uid,
        name: name,
        email: firebaseUser.email,
        createdAt: Timestamp.now(),
      );

      /// Simpan data ke Firestore (jika belum ada)
      final userExists = await _userService.checkUserExists(_user!.id!);
      if (!userExists) {
        await _userService.createUser(_user!);
      }

      /// Update status
      _authStatus = FirebaseAuthStatus.accountCreated;
      _message = "Berhasil mendaftarkan akun";
    } catch (e) {
      _message = e.toString().replaceFirst("Exception: ", "");
      _authStatus = FirebaseAuthStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
