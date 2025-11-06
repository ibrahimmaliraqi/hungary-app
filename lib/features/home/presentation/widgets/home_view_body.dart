import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/home/data/manager/get_products/get_products_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/custom_item_card.dart';
import 'package:hungry_app/features/home/presentation/widgets/custom_text_field.dart';
import 'package:hungry_app/features/home/presentation/widgets/food_category.dart';
import 'package:hungry_app/features/home/presentation/widgets/user_header.dart';
import 'package:hungry_app/features/product/presentation/views/product_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    BlocProvider.of<GetProductsCubit>(context).getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsState>(
      builder: (context, state) {
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () =>
              BlocProvider.of<GetProductsCubit>(context).getProduct(),
          child: Skeletonizer(
            enabled: state is GetProductsLoading,
            child: CustomScrollView(
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
                    itemCount: state is GetProductsSuccess
                        ? state.products.length
                        : 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.60,
                    ),
                    itemBuilder: (context, index) {
                      if (state is GetProductsSuccess) {
                        final product = state.products[index];
                        return CustomCardItem(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductView(
                                  price: state.products[index].price!,

                                  image: state.products[index].image!,
                                ),
                              ),
                            );
                          },
                          image: product.image!,
                          rating: product.rating!,
                          subTitle: product.description!,
                          title: product.name!,
                        );
                      }
                      return CustomCardItem(
                        image:
                            "http://sonic-zdi0.onrender.com/storage/products/fried.jpg",
                        rating: "4.9",
                        subTitle: "Loading...",
                        title: "Loading...",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
