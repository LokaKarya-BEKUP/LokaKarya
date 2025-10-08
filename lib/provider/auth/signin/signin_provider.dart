import 'package:flutter/foundation.dart';
import 'package:lokakarya/data/model/user.dart';
import 'package:lokakarya/static/signin_result_state.dart';

class SignInProvider extends ChangeNotifier {
  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  User? _user;
  User? get user => _user;

  SignInResultState _resultState = SignInNoneState();
  SignInResultState get resultState => _resultState;

  /// Toggle Password Visibility
  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  /// Sign In Process (Placeholder)
  Future<void> signIn(String email, String password) async {
    _resultState = SignInLoadingState();
    notifyListeners();

    try {
      /// Validate email
      final user = dummyUser.firstWhere(
        (u) => u.email == email,
        orElse: () => throw Exception("Akun tidak ditemukan."),
      );

      final dummyPassword = "123456";

      /// Validate password
      if (password == dummyPassword) {
        _resultState = SignInSuccessState(user);
      } else {
        _resultState = SignInErrorState("Password tidak sesuai.");
      }
    } on Exception catch (e) {
      _resultState = SignInErrorState(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      notifyListeners();
    }
  }
}
