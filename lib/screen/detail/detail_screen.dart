import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/data/model/store.dart';
import 'package:lokakarya/utils/formatted_price.dart';
import 'package:provider/provider.dart';
import 'package:lokakarya/provider/main/favorite_provider.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, provider, child) {
              final isFavorited = provider.isFavorite(product);
              return IconButton(
                onPressed: () {
                  if (isFavorited) {
                    provider.removeFavorite(product);
                  } else {
                    provider.addFavorite(product);
                  }
                },
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_outline,
                  color: isFavorited ? Colors.red : colorScheme.onSurface,
                  size: 32,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            Image.network(
              product.imageUrl ?? "",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            /// Product Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(
                    formatRupiah(product.price),
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Category & City
                  Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 20,
                        color: colorScheme.onSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product.getCategoryName(dummyCategories),
                        style: textTheme.labelLarge,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: colorScheme.onSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product.getStoreCity(dummyStores),
                        style: textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  /// Description
                  Text(
                    "Deskripsi Produk",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? "Tidak ada deskripsi tersedia.",
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
