import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lokakarya/services/auth_preferences_service.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final authPrefs = context.read<AuthPreferencesService>();
    final firebaseUser = FirebaseAuth.instance.currentUser;

    /// TODO: Ganti 'isLoggedIn' dengan pengecekan login session, misal dari Shared Prefs
    await Future.delayed(const Duration(milliseconds: 800));

    final isLoggedIn = await authPrefs.getLoginStatus();

    if (!mounted) return;

    if (isLoggedIn && firebaseUser != null) {
      Navigator.pushReplacementNamed(context, NavigationRoute.mainRoute.name);
    } else {
      Navigator.pushReplacementNamed(context, NavigationRoute.signInRoute.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
