import 'package:flutter/material.dart';

class CountOfProductInCategory extends StatelessWidget {
  const CountOfProductInCategory({
    super.key,
    required this.categoryName,
    required this.itemCount,
  });

  final String categoryName;
  final String itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        itemCount, // عرض عدد المنتجات هنا
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
