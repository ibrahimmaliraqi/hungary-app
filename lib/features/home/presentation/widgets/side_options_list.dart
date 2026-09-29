import 'package:flutter/material.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';
import 'package:hungry_app/features/home/presentation/widgets/toppings_card..dart';

class ProductOptionList extends StatelessWidget {
  final List<ProductOptionEntity> options;

  const ProductOptionList({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((option) {
          return ToppingsCard(
            imageUrl: option.image,
            title: option.name,
            onAdd: () {},
          );
        }).toList(),
      ),
    );
  }
}
