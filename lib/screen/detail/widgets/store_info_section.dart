import 'package:flutter/material.dart';

import '../../../data/model/store.dart';

class StoreInfoSection extends StatelessWidget {
  final Store? store;

  const StoreInfoSection({super.key, this.store});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    /// Jika Data toko tidak ditemukan, tampilkan text
    if (store == null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Data UMKM tidak ditemukan", style: textTheme.bodyLarge),
      );
    }

    /// Jika data toko ditemukan
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          /// Store Image
          CircleAvatar(
            radius: 32,
            backgroundColor: colorScheme.onSurface,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/images/store_default.png",
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          /// Store Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Store Name
                Text(
                  store!.name,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                /// Store City
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${store!.city}, Indonesia",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
