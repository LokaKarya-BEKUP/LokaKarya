import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/widgets/product_card.dart';
import 'package:lokakarya/services/product_service.dart';

class ProductListScreen extends StatelessWidget {
  final Object? arguments;

  const ProductListScreen({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    String title = "Semua Produk";
    Stream<List<Product>> productStream = ProductService().getProductsStream();

    if (arguments != null && arguments is CategoryModel) {
      final category = arguments as CategoryModel;
      title = category.name;
      productStream = ProductService().getProductsByCategory(category.id);
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: StreamBuilder<List<Product>>(
        stream: productStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const Center(child: Text("Belum ada produk tersedia."));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 230,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                final city = '-';

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
          );
        },
      ),
    );
  }
}