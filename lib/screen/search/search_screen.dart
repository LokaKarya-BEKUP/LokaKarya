import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/store.dart';
import 'package:lokakarya/provider/main/search_provider.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'package:lokakarya/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:lokakarya/data/model/product.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pencarian')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            /// Search Input
            TextField(
              decoration: InputDecoration(
                hintText: "Cari produk...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                // GANTI DARI 'surfaceVariant' KE 'surfaceContainerHighest'
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
              onChanged: (query) {
                context.read<SearchProvider>().filterProducts(query);
              },
            ),
            const SizedBox(height: 16),

            /// Search Results
            Consumer<SearchProvider>(
              builder: (context, provider, child) {
                final filteredProducts = provider.filteredProducts;
                if (filteredProducts.isEmpty &&
                    provider.searchQuery.isNotEmpty) {
                  return const Expanded(
                    child: Center(child: Text("Produk tidak ditemukan.")),
                  );
                } else if (provider.searchQuery.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text("Silakan ketik untuk mencari produk."),
                    ),
                  );
                }

                return Expanded(
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 230,
                        ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
