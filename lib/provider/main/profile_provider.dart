// lib/provider/main/profile_provider.dart
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = "John Doe"; // Nama pengguna saat ini
  String get name => _name;

  void updateName(String newName) {
    if (newName.isNotEmpty) {
      _name = newName;
      notifyListeners();
    }
  }
}
