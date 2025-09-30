import 'package:flutter/foundation.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  /// Toggle Password Visibility
  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }
}
