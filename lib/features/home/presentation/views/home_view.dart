import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/home/data/manager/get_products/get_products_cubit.dart';
import 'package:hungry_app/features/home/data/repos/home_repo_impl.dart';
import 'package:hungry_app/features/home/presentation/widgets/home_view_body.dart';
import 'package:hungry_app/features/product/data/manager/toppings/toppings_cubit.dart';
import 'package:hungry_app/features/product/data/repos/product_detils_repo_impl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetProductsCubit(HomeRepoImpl()),
          ),
          BlocProvider(
            create: (context) => ToppingsCubit(ProductDetilsRepoImpl()),
          ),
        ],
        child: Scaffold(
          body: HomeViewBody(),
        ),
      ),
    );
  }
}
