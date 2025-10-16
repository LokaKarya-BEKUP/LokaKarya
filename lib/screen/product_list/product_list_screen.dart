import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/data/model/store.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/widgets/product_card.dart';
import 'package:lokakarya/services/product_service.dart';
import 'package:lokakarya/services/store_service.dart';

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
        builder: (context, productSnapshot) {
          if (productSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productSnapshot.hasError) {
            return Center(child: Text("Error: ${productSnapshot.error}"));
          }

          final products = productSnapshot.data ?? [];
          if (products.isEmpty) {
            return const Center(child: Text("Belum ada produk tersedia."));
          }

          // 🔹 Ambil juga data store dari Firestore
          return StreamBuilder<List<Store>>(
            stream: StoreService().getStoresStream(),
            builder: (context, storeSnapshot) {
              if (storeSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (storeSnapshot.hasError) {
                return Center(child: Text("Error: ${storeSnapshot.error}"));
              }

              final stores = storeSnapshot.data ?? [];

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
                    final city = product.getStoreCity(
                      stores,
                    ); // ✅ panggil helper kamu langsung

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
          );
        },
      ),
    );
  }
}
