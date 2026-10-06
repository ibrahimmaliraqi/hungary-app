import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/demo/demo_products.dart';
import 'package:hungry_app/core/widgets/error_widget.dart';
import 'package:hungry_app/core/widgets/not_data_found.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/presentation/manager/products_by_category/products_by_category_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/ProductByCategoryList.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductByCategoryListBloc extends StatelessWidget {
  final CategoryEntity categoryEntity;
  const ProductByCategoryListBloc({
    super.key,
    required this.categoryEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
      builder: (context, state) {
        if (state is ProductsByCategoryLoading) {
          return Skeletonizer(
            enabled: true,
            child: ProductByCategoryList(
              prodcuts: demoProducts,
            ),
          );
        }
        if (state is ProductsByCategorySuccess) {
          if (state.products.isEmpty) {
            if (state.products.isEmpty) {
              return NoDataWidget(
                icon: Icons.fastfood_outlined,
                title: 'ماكو منتجات',
                subtitle: 'حالياً ماكو منتجات مضافة لهذا التصنيف',
                actionText: 'إعادة المحاولة',
                actionIcon: Icons.refresh,
                onAction: () {
                  context.read<ProductsByCategoryCubit>().getProductsByCategory(
                    categoryId: categoryEntity.id,
                  );
                },
              );
            }
          }
          return ProductByCategoryList(
            prodcuts: state.products,
          );
        }
        if (state is ProductsByCategoryFailure) {
          return FailureWidget(
            title: 'حدث خطأ',
            message: state.errMessage,
            onRetry: () {
              context.read<ProductsByCategoryCubit>().getProductsByCategory(
                categoryId: categoryEntity.id,
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
