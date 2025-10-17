import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/firebase_options.dart';
import 'package:lokakarya/provider/auth/signin/signin_provider.dart';
import 'package:lokakarya/provider/auth/signup/signup_provider.dart';
import 'package:lokakarya/provider/main/index_nav_provider.dart';
import 'package:lokakarya/provider/main/favorite_provider.dart';
import 'package:lokakarya/provider/main/search_provider.dart';
import 'package:lokakarya/provider/main/profile_provider.dart';
import 'package:lokakarya/provider/main/theme_provider.dart';
import 'package:lokakarya/screen/auth/signin/signin_screen.dart';
import 'package:lokakarya/screen/auth/signup/signup_screen.dart';
import 'package:lokakarya/screen/detail/detail_screen.dart';
import 'package:lokakarya/screen/favorite/favorite_screen.dart';
import 'package:lokakarya/screen/main/main_screen.dart';
import 'package:lokakarya/screen/splash/splash_screen.dart';
import 'package:lokakarya/screen/search/search_screen.dart';
import 'package:lokakarya/screen/product_list/product_list_screen.dart';
import 'package:lokakarya/services/auth_preferences_service.dart';
import 'package:lokakarya/services/firebase_auth_service.dart';
import 'package:lokakarya/services/firestore_user_service.dart';
import 'package:lokakarya/services/theme_preferences_service.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/style/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  /// Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ThemePreferencesService(prefs)),
        Provider(create: (context) => AuthPreferencesService(prefs)),
        Provider(create: (context) => FirebaseAuthService(firebaseAuth)),
        Provider(create: (context) => FirestoreUserService(firebaseFirestore)),
        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(context.read<ThemePreferencesService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInProvider(
            context.read<FirebaseAuthService>(),
            context.read<FirestoreUserService>(),
            context.read<AuthPreferencesService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(
            context.read<FirebaseAuthService>(),
            context.read<FirestoreUserService>(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(
            context.read<FirebaseAuthService>(),
            context.read<FirestoreUserService>(),
            context.read<AuthPreferencesService>(),
          ),
        ),
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
      themeMode: context.watch<ThemeProvider>().themeMode,
      initialRoute: NavigationRoute.splashRoute.name,
      routes: {
        NavigationRoute.splashRoute.name: (context) => const SplashScreen(),
        NavigationRoute.signInRoute.name: (context) => const SignInScreen(),
        NavigationRoute.signUpRoute.name: (context) => SignUpScreen(),
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          product: ModalRoute.of(context)?.settings.arguments as Product,
        ),
        NavigationRoute.searchRoute.name: (context) => const SearchScreen(),
        NavigationRoute.productListRoute.name: (context) => ProductListScreen(
          arguments: ModalRoute.of(context)?.settings.arguments,
        ),
        NavigationRoute.favoriteRoute.name: (context) => const FavoriteScreen(),
      },
    );
  }
}
