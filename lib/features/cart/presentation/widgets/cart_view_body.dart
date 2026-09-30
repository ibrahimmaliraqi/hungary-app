import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/features/cart/presentation/manager/get_cart_items/get_cart_items_cubit.dart';
import 'package:hungry_app/features/cart/presentation/widgets/cart_list_bloc.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    context.read<GetCartItemsCubit>().getCartItem(
      userId: PrefsHelper.getUser()!.id!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: CartListBloc(),
          ),
        ],
      ),
    );
  }
}
