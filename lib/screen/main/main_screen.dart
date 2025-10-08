import 'package:flutter/material.dart';
import 'package:lokakarya/provider/main/index_nav_provider.dart';
import 'package:lokakarya/screen/category/category_screen.dart';
import 'package:lokakarya/screen/favorite/favorite_screen.dart';
import 'package:lokakarya/screen/home/home_screen.dart';
import 'package:lokakarya/screen/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watchProvider = context.watch<IndexNavProvider>();
    final readProvider = context.read<IndexNavProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    final pages = const [
      HomeScreen(),
      CategoryScreen(),
      FavoriteScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: pages[watchProvider.indexBottomNavBar],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: watchProvider.indexBottomNavBar,
          onDestinationSelected: (index) =>
              readProvider.setIndexBottomNavBar = index,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 70,
          backgroundColor: colorScheme.surface,
          indicatorColor: colorScheme.primaryContainer,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            /// Active Label color
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).textTheme.labelMedium!.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              );
            } else {
              /// Non Active Label color
              return Theme.of(context).textTheme.labelMedium!.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              );
            }
          }),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Beranda",
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined),
              selectedIcon: Icon(Icons.category),
              label: "Kategori",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: "Favorit",
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}
