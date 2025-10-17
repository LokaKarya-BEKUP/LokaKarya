import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/product.dart';
import 'package:lokakarya/data/model/store.dart';
import 'package:lokakarya/provider/main/favorite_provider.dart';
import 'package:lokakarya/screen/detail/widgets/contact_seller_section.dart';
import 'package:lokakarya/screen/detail/widgets/product_info_section.dart';
import 'package:lokakarya/screen/detail/widgets/store_info_section.dart';
import 'package:provider/provider.dart';
import 'package:lokakarya/services/store_service.dart';

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

            /// Product Info
            ProductInfoSection(product: product),
            Divider(color: colorScheme.outline, thickness: 1.5),

            /// Store Info
            FutureBuilder<Store?>(
              future: StoreService().getStoreById(product.storeId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Gagal memuat data toko: ${snapshot.error}");
                }
                return StoreInfoSection(store: snapshot.data);
              },
            ),
            Divider(color: colorScheme.outline, thickness: 1.5),

            /// Product Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deskripsi Produk",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? "Tidak ada deskripsi tersedia.",
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Divider(color: colorScheme.outline, thickness: 1.5),

            /// Contact Seller
            FutureBuilder<Store?>(
              future: StoreService().getStoreById(product.storeId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Gagal memuat data toko: ${snapshot.error}'),
                  );
                }

                final store = snapshot.data;
                return ContactSellerSection(store: store, productName: product.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
