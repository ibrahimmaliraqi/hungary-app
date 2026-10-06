import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/demo/demo_products.dart';
import 'package:hungry_app/core/widgets/error_widget.dart';
import 'package:hungry_app/core/widgets/not_data_found.dart';
import 'package:hungry_app/features/home/presentation/manager/products_by_title/products_by_title_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/SearchViewList.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchViewListBloc extends StatelessWidget {
  const SearchViewListBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsByTitleCubit, ProductsByTitleState>(
      builder: (context, state) {
        if (state is ProductsByTitleLoading) {
          return Skeletonizer(
            enabled: true,
            child: SearchViewList(
              prodcuts: demoProducts,
            ),
          );
        }
        if (state is ProductsByTitleFailure) {
          FailureWidget(message: state.errMessage);
        }
        if (state is ProductsByTitleInitial) {
          return const NoDataWidget(
            title: "شنو تدور؟",
            subtitle: "اكتب اسم الوجبة أو المنتج حتى نبحث لك عنه",
            icon: Icons.search,
          );
        }
        if (state is ProductsByTitleSuccess) {
          if (state.products.isEmpty) {
            return NoDataWidget(
              title: "لم نجد ما تبحث عنه",
              subtitle: "جرّب البحث عن وجبة أو منتج آخر",
              actionText: "مسح البحث",
              actionIcon: Icons.clear,
              icon: Icons.search_off,
            );
          }
          return SearchViewList(
            prodcuts: state.products,
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
