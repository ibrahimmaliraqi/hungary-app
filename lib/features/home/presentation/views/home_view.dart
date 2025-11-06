import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/home/data/manager/get_products/get_products_cubit.dart';
import 'package:hungry_app/features/home/data/repos/home_repo_impl.dart';
import 'package:hungry_app/features/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => GetProductsCubit(HomeRepoImpl()),
        child: Scaffold(
          body: HomeViewBody(),
        ),
      ),
    );
  }
}
