import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/features/home/domain/use_case/get_products_by_title_usecase.dart';
import 'package:hungry_app/features/home/presentation/manager/products_by_title/products_by_title_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProductsByTitleCubit(
          getProductsByTitleUsecase: getIt.get<GetProductsByTitleUsecase>(),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchViewBody(),
          ),
        ),
      ),
    );
  }
}
