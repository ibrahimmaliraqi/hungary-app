import 'package:flutter/material.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
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
          onAdd: () {},
          onMin: () {},
        );
      },
    );
  }
}
