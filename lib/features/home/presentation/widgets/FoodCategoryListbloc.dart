import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/demo/demo_category.dart';
import 'package:hungry_app/core/widgets/error_widget.dart';
import 'package:hungry_app/features/home/presentation/manager/get_categories/get_categories_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/food_category_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FoodCategoryListBloc extends StatefulWidget {
  const FoodCategoryListBloc({
    super.key,
  });

  @override
  State<FoodCategoryListBloc> createState() => _FoodCategoryListBlocState();
}

class _FoodCategoryListBlocState extends State<FoodCategoryListBloc> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
      builder: (context, state) {
        if (state is GetCategoriesSuccess) {
          return FoodCategoryList(
            categories: state.categories,

            // العنصر المحدد
            selectedIndex: selectedIndex,

            // لما يضغط على Category
            onCategorySelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          );
        } else if (state is GetCategoriesLoading) {
          return Skeletonizer(
            enabled: true,
            child: FoodCategoryList(
              categories: demoProducts,

              // قيمة مؤقتة أثناء التحميل
              selectedIndex: 0,

              // ما نحتاج نسوي شيء أثناء التحميل
              onCategorySelected: (_) {},
            ),
          );
        }

        return FailureWidget(
          message: state is GetCategoriesFailure ? state.message : "مدري",
          title: "حدث خطأ",
        );
      },
    );
  }
}
