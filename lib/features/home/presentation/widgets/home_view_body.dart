import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/features/home/presentation/widgets/custom_text_field.dart';
import 'package:hungry_app/features/home/presentation/widgets/food_category.dart';
import 'package:hungry_app/features/home/presentation/widgets/product_list_view.dart';
import 'package:hungry_app/features/home/presentation/widgets/user_header.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        UserHeader(),
        Gap(20),
        HomeSearch(),
        Gap(15),
        FoodCategory(),
        Gap(15),
        Expanded(child: ProductListView()),
      ],
    );
  }
}
