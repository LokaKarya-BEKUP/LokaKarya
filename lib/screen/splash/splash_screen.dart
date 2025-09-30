import 'package:flutter/material.dart';
import 'package:lokakarya/static/navigation_route.dart';

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
    /// TODO: Ganti 'isLoggedIn' dengan pengecekan login session, misal dari Shared Prefs
    bool isLoggedIn = false;

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, NavigationRoute.homeRoute.name);
    } else {
      Navigator.pushReplacementNamed(context, NavigationRoute.signInRoute.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox.shrink());
  }
}
