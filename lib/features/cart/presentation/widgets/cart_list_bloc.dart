import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/demo/demo_cart.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/router/app_router.dart';
import 'package:hungry_app/core/widgets/error_widget.dart';
import 'package:hungry_app/core/widgets/not_data_found.dart';
import 'package:hungry_app/features/cart/presentation/manager/get_cart_items/get_cart_items_cubit.dart';
import 'package:hungry_app/features/cart/presentation/widgets/cart_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartListBloc extends StatelessWidget {
  const CartListBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
      builder: (context, state) {
        if (state is GetCartItemsSuccess) {
          if (state.carts.isEmpty) {
            return NoDataWidget(
              icon: Icons.shopping_cart_outlined,
              title: "سلتك فارغة",
              subtitle: "ابدأ بإضافة منتجاتك المفضلة إلى السلة",
              actionText: "تصفح المنتجات",
              actionIcon: Icons.arrow_forward,
              onAction: () {
                GoRouter.of(context).pushReplacement(AppRouter.rootView);
              },
            );
          }
          return CartList(
            carts: state.carts,
          );
        } else if (state is GetCartItemsLoading) {
          return Skeletonizer(
            enabled: true,
            child: CartList(
              carts: demoCarts,
            ),
          );
        } else {
          return FailureWidget(
            title: "حطأ في جلب البيانات",
            message: state is GetCartItemsFailure
                ? state.errMessage
                : "حدث حطأ",
            onRetry: () => context.read<GetCartItemsCubit>().getCartItem(
              userId: PrefsHelper.getUser()!.id!,
            ),
          );
        }
      },
    );
  }
}
