import 'package:flutter/material.dart';
import 'package:hungry_app/features/home/presentation/widgets/product_card.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 2,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 130 / 180,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return ProductCard();
      },
    );
  }
}
