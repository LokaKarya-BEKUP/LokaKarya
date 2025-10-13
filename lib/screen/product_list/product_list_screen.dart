import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/data/model/store.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  final Object? arguments;

  const ProductListScreen({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    String title = "Semua Produk";
    List<Product> displayedProducts = dummyProductList;

    if (arguments != null && arguments is CategoryModel) {
      final category = arguments as CategoryModel;
      title = category.name;
      displayedProducts = dummyProductList
          .where((p) => p.categoryId == category.id)
          .toList();
    }

    // TODO: Tambahkan logika untuk hasil pencarian di sini

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: displayedProducts.isEmpty
          ? const Center(child: Text("Belum ada produk tersedia."))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: displayedProducts.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 230,
                ),
                itemBuilder: (context, index) {
                  final product = displayedProducts[index];
                  final city = product.getStoreCity(dummyStores);

                  return ProductCard(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: product,
                      );
                    },
                    name: product.name,
                    price: product.price,
                    unit: product.unit,
                    city: city,
                    imageUrl: product.imageUrl ?? "",
                  );
                },
              ),
            ),
    );
  }
}
