import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/product_list.dart';
import 'package:lokakarya/static/navigation_route.dart';

import '../../../widgets/product_card.dart';

class ProductSection extends StatelessWidget {
  final List<ProductList> products;

  const ProductSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Text(
          "Semua Produk",
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        /// List product
        GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 230,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
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
              city: product.city,
              imageUrl: product.imageUrl ?? "",
            );
          },
        ),
      ],
    );
  }
}
