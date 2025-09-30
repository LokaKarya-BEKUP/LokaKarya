import 'package:flutter/material.dart';
import 'package:lokakarya/provider/auth/signin/signin_provider.dart';
import 'package:lokakarya/provider/auth/signup/signup_provider.dart';
import 'package:lokakarya/screen/auth/signin/signin_screen.dart';
import 'package:lokakarya/screen/auth/signup/signup_screen.dart';
import 'package:lokakarya/screen/home/home_screen.dart';
import 'package:lokakarya/screen/splash/splash_screen.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/style/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LokaKarya',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.splashRoute.name,
      routes: {
        NavigationRoute.splashRoute.name: (context) => const SplashScreen(),
        NavigationRoute.signInRoute.name: (context) => SignInScreen(),
        NavigationRoute.signUpRoute.name: (context) => SignUpScreen(),
        NavigationRoute.homeRoute.name: (context) => HomeScreen(),
      },
    );
  }
}
