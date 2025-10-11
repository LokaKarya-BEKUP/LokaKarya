import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/data/model/store.dart';
import 'package:lokakarya/provider/main/index_nav_provider.dart';
import 'package:lokakarya/screen/home/widgets/category_section.dart';
import 'package:lokakarya/screen/home/widgets/header_section.dart';
import 'package:lokakarya/screen/home/widgets/product_section.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:provider/provider.dart';
import 'package:lokakarya/provider/main/profile_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Header Section
              Consumer<ProfileProvider>(
                builder: (context, provider, child) {
                  return HeaderSection(
                    name: provider.name, // Gunakan nama dari provider
                    onSearchTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.searchRoute.name,
                      );
                    },
                    onProfileTap: () {
                      context.read<IndexNavProvider>().setIndexBottomNavBar = 2;
                    },
                    onNotificationTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Fitur notifikasi akan ditambahkan nanti!",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              /// Body Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Category Section
                    CategorySection(categories: dummyCategories),
                    const SizedBox(height: 24),

                    /// All Product Section
                    ProductSection(
                      products: dummyProductList,
                      stores: dummyStores,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
