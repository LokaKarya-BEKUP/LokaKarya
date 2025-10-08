import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/data/model/product_list.dart';
import 'package:lokakarya/provider/main/index_nav_provider.dart';
import 'package:lokakarya/screen/home/widgets/category_section.dart';
import 'package:lokakarya/screen/home/widgets/header_section.dart';
import 'package:lokakarya/screen/home/widgets/product_section.dart';
import 'package:provider/provider.dart';

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
              HeaderSection(name: "John", onSearchTap: () {}),

              /// Body Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Category Section
                    CategorySection(
                      categories: dummyCategories,
                      onSeeAll: () {
                        context.read<IndexNavProvider>().setIndexBottomNavBar = 1;
                      },
                    ),
                    const SizedBox(height: 24),

                    /// All Product Section
                    ProductSection(products: dummyProductList),
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
