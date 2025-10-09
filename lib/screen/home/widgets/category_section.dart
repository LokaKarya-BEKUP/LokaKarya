import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/category.dart';

import 'category_card.dart';

class CategorySection extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function()? onSeeAll;

  const CategorySection({
    super.key,
    required this.categories,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kategori",
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: onSeeAll,
              child: Text(
                "Lihat Semua",
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        /// List Category
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryCard(
                name: category.name,
                imagePath: category.imageUrl,
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
