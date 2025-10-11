import 'package:flutter/material.dart';
import '../../../style/colors/app_colors.dart';
import '../../../data/model/category.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final Function(CategoryModel category) onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onTap(category),
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            /// Category Image
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.neutral70.withAlpha(30),
                border: Border.all(color: colorScheme.primary, width: 1.5),
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  category.imageUrl,
                  fit: BoxFit.cover,
                ), // GANTI INI
              ),
            ),
            const SizedBox(height: 8),

            /// Category Name
            Text(
              category.name,
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
