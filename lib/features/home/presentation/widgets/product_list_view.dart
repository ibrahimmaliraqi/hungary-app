import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/router/app_router.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/presentation/widgets/product_card.dart';

class ProductListView extends StatelessWidget {
  final List<ProductEntity> products;
  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 130 / 200,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return ProductCard(
          onTap: () => GoRouter.of(
            context,
          ).push(AppRouter.productView, extra: products[index]),
          product: products[index],
        );
      },
    );
  }
}
