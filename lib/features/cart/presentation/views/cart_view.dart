import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/functions/app_price.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/features/cart/domain/use_cases/clear_cart_usecase.dart';
import 'package:hungry_app/features/cart/domain/use_cases/delete_item_from_cart_usecase.dart';
import 'package:hungry_app/features/cart/domain/use_cases/get_cart_items_usecase.dart';
import 'package:hungry_app/features/cart/presentation/manager/get_cart_items/get_cart_items_cubit.dart';
import 'package:hungry_app/features/cart/presentation/widgets/cart_view_body.dart';
import 'package:hungry_app/features/checkout/presentation/views/checkout_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCartItemsCubit(
        clearCartUsecase: getIt.get<ClearCartUsecase>(),
        deleteItemFromCartUsecase: getIt.get<DeleteItemFromCartUsecase>(),
        getCartItemsUsecase: getIt.get<GetCartItemsUsecase>(),
      ),
      child: Scaffold(
        body: const SafeArea(
          child: CartViewBody(),
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // الصف الأول: عنوان المجموع وزر الحذف بتصميم إبداعي
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "مجموع السلة",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                      BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
                        builder: (context, state) {
                          if (state is! GetCartItemsSuccess ||
                              state.carts.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                context.read<GetCartItemsCubit>().cleatCart(
                                  userId: PrefsHelper.getUser()!.id!,
                                );
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.red.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.remove_shopping_cart_rounded,
                                      color: Colors.red.shade700,
                                      size: 16,
                                    ),
                                    const Gap(6),
                                    CustomText(
                                      text: "إفراغ السلة",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red.shade700,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const Gap(8),

                  // الصف الثاني: السعر الإجمالي وزر إتمام الطلب
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // السعر
                      BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
                        builder: (context, state) {
                          if (state is GetCartItemsLoading) {
                            return Skeletonizer(
                              enabled: true,
                              child: CustomText(
                                text: "00000 دينار",
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            );
                          }

                          if (state is GetCartItemsSuccess) {
                            return CustomText(
                              text:
                                  "${AppPrice.cartTotalPrice(product: state.carts)} دينار",
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            );
                          }

                          return CustomText(
                            text: "0 دينار",
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          );
                        },
                      ),

                      // زر إتمام الطلب
                      BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
                        builder: (context, state) {
                          if (state is! GetCartItemsSuccess ||
                              state.carts.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutView(
                                      carts: state.carts,
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CustomText(
                                      text: "إتمام الطلب",
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Gap(10),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
