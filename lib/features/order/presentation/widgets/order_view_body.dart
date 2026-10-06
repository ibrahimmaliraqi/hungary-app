import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/features/order/presentation/manager/get_orders/get_orders_cubit.dart';
import 'package:hungry_app/features/order/presentation/widgets/order_list_bloc.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: Colors.white,
      onRefresh: () => context.read<GetOrdersCubit>().getOrders(
        userId: PrefsHelper.getUser()!.id!,
      ),
      child: OrderListBloc(),
    );
  }
}
