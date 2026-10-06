import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/demo/demo_order.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/router/app_router.dart';
import 'package:hungry_app/core/widgets/error_widget.dart';
import 'package:hungry_app/core/widgets/not_data_found.dart';
import 'package:hungry_app/features/order/presentation/manager/get_orders/get_orders_cubit.dart';
import 'package:hungry_app/features/order/presentation/widgets/order_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderListBloc extends StatelessWidget {
  const OrderListBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
      builder: (context, state) {
        if (state is GetOrdersLoading) {
          return Skeletonizer(
            enabled: true,
            child: OrdersList(
              orders: demoOrders,
            ),
          );
        } else if (state is GetOrdersSuccess) {
          if (state.orders.isEmpty) {
            return NoDataWidget(
              icon: Icons.receipt_long_outlined,
              title: 'لا توجد طلبات بعد',
              subtitle: 'ستظهر طلباتك هنا عند إجراء أول طلب',
              actionText: 'ابدأ التسوق',
              actionIcon: Icons.shopping_bag_outlined,
              onAction: () =>
                  GoRouter.of(context).pushReplacement(AppRouter.rootView),
            );
          } else {
            return OrdersList(
              orders: state.orders,
            );
          }
        }
        return FailureWidget(
          message: 'حدث خطأ أثناء جلب الطلبات',
          title: 'تعذر تحميل الطلبات',
          onRetry: () => context.read<GetOrdersCubit>().getOrders(
            userId: PrefsHelper.getUser()!.id!,
          ),
        );
      },
    );
  }
}
