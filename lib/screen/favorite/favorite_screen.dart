import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/data/model/store.dart';
import 'package:lokakarya/provider/main/favorite_provider.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:lokakarya/services/store_service.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = context.watch<FavoriteProvider>().favoriteProducts;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Produk Favorit")),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Text(
                "Tidak ada produk favorit.",
                style: textTheme.bodyLarge,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: favoriteProducts.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 230,
                ),
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];

                  // RETURN FutureBuilder — jangan lupa return!
                  return FutureBuilder<Store?>(
                    future: StoreService().getStoreById(product.storeId),
                    builder: (context, snapshot) {
                      final store = snapshot.data;
                      final city = store?.city ?? "-";

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
                  );
                },
              ),
            ),
    );
  }
}