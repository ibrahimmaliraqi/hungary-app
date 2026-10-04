import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/features/order/domain/use_cases/create_payment_usecase.dart';
import 'package:hungry_app/features/order/domain/use_cases/get_orders_usecase.dart';
import 'package:hungry_app/features/order/presentation/manager/create_payment/create_payment_cubit.dart';
import 'package:hungry_app/features/order/presentation/manager/get_orders/get_orders_cubit.dart';
import 'package:hungry_app/features/order/presentation/widgets/order_view_body.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetOrdersCubit(getOrdersUsecase: getIt.get<GetOrdersUsecase>())
                ..getOrders(userId: PrefsHelper.getUser()!.id!),
        ),
        BlocProvider(
          create: (context) => CreatePaymentCubit(
            createPaymentUsecase: getIt.get<CreatePaymentUsecase>(),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(
          0xFFF8F9FA,
        ), // Off-white background for contrast
        body: SafeArea(
          child: OrderViewBody(),
        ),
      ),
    );
  }
}
