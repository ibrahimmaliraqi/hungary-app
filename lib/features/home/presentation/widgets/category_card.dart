import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Color(0xffF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomText(
          text: category.name,
          color: isSelected ? Colors.white : const Color(0xff6A6A6A),
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }
}
