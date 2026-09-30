import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/demo/demo_cart.dart';
import 'package:hungry_app/core/functions/app_price.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
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
        getCartItemsUsecase: getIt.get<GetCartItemsUsecase>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: CartViewBody(),
        ),
        bottomSheet: Container(
          // Removed fixed height to let padding and content dictate the size dynamically
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05), // Soft, modern shadow
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, -5), // Shadow casts upwards
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price Details Section
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "مجموع السلة",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            Colors.grey.shade600, // Subdued color for subtitle
                      ),
                      const Gap(4),
                      BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
                        builder: (context, state) {
                          if (state is GetCartItemsLoading) {
                            return Skeletonizer(
                              enabled: true,
                              child: CustomText(
                                text: "00000 دينار",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            );
                          }

                          if (state is GetCartItemsSuccess) {
                            return CustomText(
                              text:
                                  "${AppPrice.cartTotalPrice(product: state.carts)} دينار",
                              fontSize: 22, // Larger, prominent price
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary, // Make price pop
                            );
                          }

                          return CustomText(
                            text: "0 دينار",
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ],
                  ),

                  // Creative Premium Checkout Button
                  BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
                    builder: (context, state) {
                      if (state is GetCartItemsLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutView(
                                      carts: demoCarts,
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
                                      color: AppColors.primary.withOpacity(
                                        0.3,
                                      ), // Glowing button effect
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CustomText(
                                      text:
                                          "إتمام الطلب", // Arabic to match the context
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Gap(10),
                                    // Small elegant arrow indicator
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons
                                            .arrow_forward_ios_rounded, // Use arrow_back_ios_rounded if your app is strictly RTL
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is GetCartItemsSuccess) {
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
                                    color: AppColors.primary.withOpacity(
                                      0.3,
                                    ), // Glowing button effect
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CustomText(
                                    text:
                                        "إتمام الطلب", // Arabic to match the context
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const Gap(10),
                                  // Small elegant arrow indicator
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons
                                          .arrow_forward_ios_rounded, // Use arrow_back_ios_rounded if your app is strictly RTL
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutView(
                                  carts: demoCarts,
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
                                  color: AppColors.primary.withOpacity(
                                    0.3,
                                  ), // Glowing button effect
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CustomText(
                                  text:
                                      "إتمام الطلب", // Arabic to match the context
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                const Gap(10),
                                // Small elegant arrow indicator
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons
                                        .arrow_forward_ios_rounded, // Use arrow_back_ios_rounded if your app is strictly RTL
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
            ),
          ),
        ),
      ),
    );
  }
}
