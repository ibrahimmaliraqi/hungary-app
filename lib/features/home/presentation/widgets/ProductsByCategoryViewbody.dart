import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/demo/demo_products.dart';
import 'package:hungry_app/features/home/presentation/widgets/CountOfProductInCategory.dart';
import 'package:hungry_app/features/home/presentation/widgets/product_card.dart';

class ProductsByCategoryViewBody extends StatelessWidget {
  const ProductsByCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Gap(10),
          CountOfProductInCategory(categoryName: "categoryName", itemCount: 2),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 130 / 200,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: demoProduct);
              },
            ),
          ),
        ],
      ),
    );
  }
}
