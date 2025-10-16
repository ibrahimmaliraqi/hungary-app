import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/assets.dart';
import 'package:hungry_app/features/home/presentation/widgets/custom_item_card.dart';
import 'package:hungry_app/features/home/presentation/widgets/custom_text_field.dart';
import 'package:hungry_app/features/home/presentation/widgets/food_category.dart';
import 'package:hungry_app/features/home/presentation/widgets/user_header.dart';
import 'package:hungry_app/features/product/presentation/views/product_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          elevation: 0,
          floating: false,
          backgroundColor: Colors.white,
          toolbarHeight: 178,
          pinned: true,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 19, right: 19),
            child: Column(
              children: [
                Gap(50),
                UserHeader(),
                Gap(17),
                CustomTextField(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 19,
            ),
            child: Column(
              children: [
                FoodCategory(),
                Gap(30),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 19),
          sliver: SliverGrid.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              return CustomCardItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductView(),
                    ),
                  );
                },
                image: Assets.test,
                rating: "4.9",
                subTitle: "Wendy's Burger",
                title: "Cheese burger",
              );
            },
          ),
        ),
      ],
    );
  }
}
