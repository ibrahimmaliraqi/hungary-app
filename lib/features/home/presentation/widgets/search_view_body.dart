import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/features/home/presentation/manager/products_by_title/products_by_title_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/CountOfProductInCategory.dart';
import 'package:hungry_app/features/home/presentation/widgets/SearchViewListBloc.dart';
import 'package:hungry_app/features/home/presentation/widgets/custom_text_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        HomeSearch(
          isEnabled: true,
        ),
        Gap(20),
        Row(
          children: [
            CustomText(
              text: "عدد المنتجات",
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            Spacer(),
            BlocBuilder<ProductsByTitleCubit, ProductsByTitleState>(
              builder: (context, state) {
                if (state is ProductsByTitleSuccess) {
                  return CountOfProductInCategory(
                    itemCount: state.products.length.toString(),
                  );
                }
                return Skeletonizer(
                  enabled: state is ProductsByTitleLoading,
                  child: CountOfProductInCategory(
                    itemCount: "فارغ",
                  ),
                );
              },
            ),
          ],
        ),
        Gap(8),
        Expanded(child: SearchViewListBloc()),
      ],
    );
  }
}
