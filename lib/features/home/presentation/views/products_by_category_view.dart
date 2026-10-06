import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/domain/use_case/get_products_by_category_usecase.dart';
import 'package:hungry_app/features/home/presentation/manager/products_by_category/products_by_category_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/ProductsByCategoryViewbody.dart';

class ProductsByCategoryView extends StatelessWidget {
  final CategoryEntity categoryEntity;
  const ProductsByCategoryView({super.key, required this.categoryEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ProductsByCategoryCubit(
            getProductsByCategoryUsecase: getIt
                .get<GetProductsByCategoryUsecase>(),
          )..getProductsByCategory(categoryId: categoryEntity.id),
          child: ProductsByCategoryViewBody(
            categoryEntity: categoryEntity,
          ),
        ),
      ),
    );
  }
}
