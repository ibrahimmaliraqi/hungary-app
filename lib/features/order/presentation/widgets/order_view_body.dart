import 'package:flutter/material.dart';
import 'package:hungry_app/features/order/presentation/widgets/order_list_bloc.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OrderListBloc();
  }
}
