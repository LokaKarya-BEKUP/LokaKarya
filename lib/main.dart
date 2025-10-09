import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/provider/auth/signin/signin_provider.dart';
import 'package:lokakarya/provider/auth/signup/signup_provider.dart';
import 'package:lokakarya/provider/main/index_nav_provider.dart';
import 'package:lokakarya/screen/auth/signin/signin_screen.dart';
import 'package:lokakarya/screen/auth/signup/signup_screen.dart';
import 'package:lokakarya/screen/detail/detail_screen.dart';
import 'package:lokakarya/screen/main/main_screen.dart';
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
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
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
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          product: ModalRoute.of(context)?.settings.arguments as Product,
        )
      },
    );
  }
}
