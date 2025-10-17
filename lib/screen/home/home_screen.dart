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
import 'package:lokakarya/services/category_service.dart';
import 'package:lokakarya/services/product_service.dart';
import 'package:lokakarya/services/store_service.dart';

import '../../utils/app_snackbar.dart';

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
                    name: provider.isLoading
                        ? "..."
                        : provider.user?.name ?? "Nama Pengguna",
                    onSearchTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.searchRoute.name,
                      );
                    },
                    onProfileTap: () {
                      context.read<IndexNavProvider>().setIndexBottomNavBar = 2;
                    },
                    onNotificationTap: () => showComingSoonSnackBar(context, featureName: "Notifikasi"),
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
                    StreamBuilder<List<CategoryModel>>(
                      stream: CategoryService().getCategoriesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Text('Terjadi kesalahan: ${snapshot.error}');
                        }

                        final categories = snapshot.data ?? [];

                        if (categories.isEmpty) {
                          return const Text('Belum ada kategori');
                        }

                        return CategorySection(categories: categories);
                      },
                    ),

                    /// All Product Section
                    StreamBuilder<List<Product>>(
                      stream: ProductService().getProductsStream(),
                      builder: (context, productSnapshot) {
                        if (productSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (productSnapshot.hasError) {
                          return Text(
                            'Terjadi kesalahan: ${productSnapshot.error}',
                          );
                        }

                        final products = productSnapshot.data ?? [];

                        return StreamBuilder<List<Store>>(
                          stream: StoreService().getStoresStream(),
                          builder: (context, storeSnapshot) {
                            if (storeSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (storeSnapshot.hasError) {
                              return Text(
                                'Terjadi kesalahan: ${storeSnapshot.error}',
                              );
                            }

                            final stores = storeSnapshot.data ?? [];

                            return ProductSection(
                              products: products,
                              stores: stores,
                            );
                          },
                        );
                      },
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
