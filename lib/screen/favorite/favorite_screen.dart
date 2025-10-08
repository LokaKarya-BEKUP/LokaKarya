import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Halaman Favorit",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
