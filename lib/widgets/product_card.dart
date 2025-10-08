import 'package:flutter/material.dart';
import 'package:lokakarya/utils/formatted_price.dart';

import '../style/colors/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final String unit;
  final String city;
  final String imageUrl;
  final Function() onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.unit,
    required this.city,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: isDark
              ? Border.all(color: colorScheme.primary, width: 1)
              : null,
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: AppColors.neutral90,
                    child: const Icon(Icons.image_not_supported, size: 40),
                  );
                },
              ),
            ),

            /// Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Product Name
                    Text(
                      name,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    /// Product Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// Price
                        Text(
                          formatRupiah(price),
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),

                        /// Unit (kg, pcs, box, pack, dll)
                        Text("/$unit", style: textTheme.titleSmall),
                      ],
                    ),
                    const SizedBox(height: 8),

                    /// City
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// Icon
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: colorScheme.onSurface,
                        ),
                        const SizedBox(width: 8),

                        /// City Name
                        Expanded(
                          child: Text(
                            city,
                            style: textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
