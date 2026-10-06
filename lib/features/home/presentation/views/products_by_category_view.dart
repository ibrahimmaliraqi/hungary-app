import 'package:flutter/material.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/presentation/widgets/ProductsByCategoryViewbody.dart';

class ProductsByCategoryView extends StatelessWidget {
  final CategoryEntity categoryEntity;
  const ProductsByCategoryView({super.key, required this.categoryEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProductsByCategoryViewBody(),
      ),
    );
  }
}
