import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class FoodCategory extends StatefulWidget {
  const FoodCategory({super.key});

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  List categories = [
    "All",
    "Combos",
    "Sliders",
    "Classic",
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            categories.length,
            (index) {
              return GestureDetector(
                onTap: () => setState(() => selectedIndex = index),
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 25,
                  ),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? AppColors.primary
                        : Color(0xffF3F4F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomText(
                    text: categories[index],
                    color: selectedIndex == index
                        ? Colors.white
                        : Color(0xff6A6A6A),
                    fontSize: 16,
                    fontWeight: selectedIndex == index
                        ? FontWeight.w500
                        : FontWeight.w300,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
