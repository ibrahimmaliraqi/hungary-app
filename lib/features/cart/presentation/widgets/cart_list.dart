import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/cart/presentation/manager/get_cart_items/get_cart_items_cubit.dart';
import 'package:hungry_app/features/cart/presentation/widgets/cart_card.dart';

class CartList extends StatefulWidget {
  final List<CartEntity> carts;
  const CartList({
    super.key,
    required this.carts,
  });

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 120),
      itemCount: widget.carts.length,
      itemBuilder: (context, index) {
        return CartCard(
          cartEntity: widget.carts[index],
          number: widget.carts[index].quantity,
          onDelete: () => context.read<GetCartItemsCubit>().deleteItemFromCart(
            itemId: widget.carts[index].id!,
          ),
          onAdd: () {},
          onMin: () {},
        );
      },
    );
  }
}
