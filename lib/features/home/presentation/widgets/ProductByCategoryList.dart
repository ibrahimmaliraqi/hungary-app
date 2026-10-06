import 'package:flutter/material.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/presentation/widgets/product_card.dart';

class ProductByCategoryList extends StatelessWidget {
  final List<ProductEntity> prodcuts;
  const ProductByCategoryList({
    super.key,
    required this.prodcuts,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: prodcuts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 130 / 200,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return ProductCard(product: prodcuts[index]);
      },
    );
  }
}
