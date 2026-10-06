import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/widgets/custom_app_bar.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/presentation/manager/products_by_category/products_by_category_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/CountOfProductInCategory.dart';
import 'package:hungry_app/features/home/presentation/widgets/ProductByCategoryListBloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsByCategoryViewBody extends StatelessWidget {
  final CategoryEntity categoryEntity;
  const ProductsByCategoryViewBody({super.key, required this.categoryEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Gap(10),
          CustomAppBar(
            leading: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: categoryEntity.name,
            actions: [
              BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
                builder: (context, state) {
                  if (state is ProductsByCategoryLoading) {
                    return Skeletonizer(
                      enabled: true,
                      child: CountOfProductInCategory(
                        categoryName: categoryEntity.name,
                        itemCount: "123",
                      ),
                    );
                  }
                  if (state is ProductsByCategorySuccess) {
                    if (state.products.isEmpty) {
                      return CountOfProductInCategory(
                        categoryName: categoryEntity.name,
                        itemCount: "فارغ",
                      );
                    }
                    return CountOfProductInCategory(
                      categoryName: categoryEntity.name,
                      itemCount: "${state.products.length} منتج",
                    );
                  }
                  if (state is ProductsByCategoryFailure) {
                    return Text("حدث خطأ");
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
          Expanded(
            child: ProductByCategoryListBloc(
              categoryEntity: categoryEntity,
            ),
          ),
        ],
      ),
    );
  }
}
