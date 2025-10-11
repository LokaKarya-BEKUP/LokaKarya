import 'package:flutter/material.dart';
import 'package:lokakarya/data/model/category.dart';
import 'package:lokakarya/static/navigation_route.dart';
import 'category_card.dart';

class CategorySection extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategorySection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Text(
          "Kategori",
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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
                category: category,
                onTap: (selectedCategory) {
                  Navigator.pushNamed(
                    context,
                    NavigationRoute.productListRoute.name,
                    arguments: selectedCategory,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
