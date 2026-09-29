import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/demo/demo_product_options.dart';
import 'package:hungry_app/features/home/presentation/manager/get_product_options/get_product_options_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/side_options_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ToppingsListBloc extends StatelessWidget {
  const ToppingsListBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductOptionsCubit, GetProductOptionsState>(
      builder: (context, state) {
        if (state is GetProductOptionsLoading) {
          return Skeletonizer(
            enabled: true,
            child: ProductOptionList(
              options: demoProductOptions,
            ),
          );
        }

        if (state is GetProductOptionsSuccess) {
          return ProductOptionList(
            options: state.toppings,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
