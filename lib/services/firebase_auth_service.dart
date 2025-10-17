import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService(FirebaseAuth? auth)
    : _auth = auth ??= FirebaseAuth.instance;

  /// Stream perubahan autentikasi (login/logout)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Ambil data user yang sedang login
  User? get currentUser => _auth.currentUser;

  /// Register User
  Future<UserCredential> createUser(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      final errorMessage = switch (e.code) {
        "email-already-in-use" => "Email sudah digunakan. Silakan gunakan email lain.",
        "invalid-email" => "Alamat email tidak valid.",
        "operation-not-allowed" => "Server error, Silakan coba lagi nanti.",
        "weak-password" => "Kata sandi terlalu lemah. Gunakan kombinasi huruf, angka, dan simbol.",
        "network-request-failed" => "Tidak ada koneksi internet. Silakan cek jaringan Anda.",
        _ => "Pendaftaran gagal. Silakan coba lagi.",
      };
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Login User
  Future<UserCredential> signInUser(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      final errorMessage = switch (e.code) {
        "invalid-email" => "Alamat email tidak valid.",
        "user-disabled" => "Akun Anda telah dinonaktifkan. Hubungi administrator.",
        "user-not-found" => "Akun dengan email tersebut tidak ditemukan.",
        "invalid-credential" => "Email atau kata sandi yang Anda masukkan salah.",
        "network-request-failed" => "Tidak ada koneksi internet. Silakan cek jaringan Anda.",
        _ => "Gagal masuk. Silakan coba lagi.",
      };
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Logout User
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Gagal keluar dari aplikasi. Silahkan coba lagi.");
    }
  }

  /// Cek user yang telah Login
  Future<User?> userChanges() => _auth.userChanges().first;
}
