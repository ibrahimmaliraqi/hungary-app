import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/demo/demo_products.dart';
import 'package:hungry_app/core/widgets/error_widget.dart';
import 'package:hungry_app/features/home/presentation/manager/get_products/get_products_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/product_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductListViewBloc extends StatelessWidget {
  const ProductListViewBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsLoading) {
          return Skeletonizer(
            enabled: true,
            child: ProductListView(
              products: demoProducts,
            ),
          );
        } else if (state is GetProductsSuccess) {
          return ProductListView(
            products: state.products,
          );
        }
        return FailureWidget(
          title: "تعذر تحميل المنتجات",
          message: state is GetProductsFailure
              ? state.errMessage
              : "حدث خطأ أثناء جلب المنتجات",
          onRetry: () => context.read<GetProductsCubit>().getProduct(),
        );
      },
    );
  }
}
