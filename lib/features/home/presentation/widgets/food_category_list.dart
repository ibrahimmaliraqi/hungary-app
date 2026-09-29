import 'package:flutter/material.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/presentation/widgets/category_card.dart';

class FoodCategoryList extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const FoodCategoryList({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55, // مهم جداً
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categories[index],
            isSelected: selectedIndex == index,
            onTap: () => onCategorySelected(index),
          );
        },
      ),
    );
  }
}
