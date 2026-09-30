import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';
import 'package:hungry_app/features/home/presentation/manager/add_product_cubit.dart';
import 'package:hungry_app/features/home/presentation/manager/add_product_state.dart';
import 'package:hungry_app/features/home/presentation/widgets/toppings_card..dart';

class ProductOptionList extends StatelessWidget {
  final List<ProductOptionEntity> options;

  const ProductOptionList({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options.map((option) {
              final isSelected = state.productOption.contains(option);

              return ToppingsCard(
                imageUrl: option.image,
                title: option.name,
                isSelected: isSelected,
                onAdd: () {
                  context.read<AddProductCubit>().addTopping(
                    option: option,
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
