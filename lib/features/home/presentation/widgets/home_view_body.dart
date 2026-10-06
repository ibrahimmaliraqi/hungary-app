import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/home/presentation/manager/get_categories/get_categories_cubit.dart';
import 'package:hungry_app/features/home/presentation/manager/get_products/get_products_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/FoodCategoryListbloc.dart';
import 'package:hungry_app/features/home/presentation/widgets/ProductListViewBloc.dart';
import 'package:hungry_app/features/home/presentation/widgets/custom_text_field.dart';
import 'package:hungry_app/features/home/presentation/widgets/user_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<GetProductsCubit>().getProduct();
    context.read<GetCategoriesCubit>().getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: Colors.white,
      onRefresh: () async {
        context.read<GetProductsCubit>().getProduct();
      },
      child: Column(
        children: [
          Gap(10),
          UserHeader(),
          Gap(20),
          HomeSearch(),
          Gap(15),
          FoodCategoryListBloc(),
          Gap(15),
          Expanded(child: ProductListViewBloc()),
        ],
      ),
    );
  }
}
