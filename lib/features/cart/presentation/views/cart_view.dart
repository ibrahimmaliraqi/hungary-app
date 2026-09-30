import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/functions/app_price.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/core/widgets/custom_button.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 0),
                color: Colors.black,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Gap(5),
                  CustomText(
                    text: "مجموع السلة",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  Gap(10),
                  BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
                    builder: (context, state) {
                      if (state is GetCartItemsLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: const CustomText(
                            text: "00000",
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3C2F2F),
                          ),
                        );
                      }

                      if (state is GetCartItemsSuccess) {
                        return CustomText(
                          text:
                              "${AppPrice.cartTotalPrice(
                                product: state.carts,
                              ).toString()} دينار عراقي",
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff3C2F2F),
                        );
                      }

                      return const CustomText(
                        text: "0",
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3C2F2F),
                      );
                    },
                  ),
                ],
              ),

              Spacer(),
              CustomButton(
                text: "Check Out",
                width: 170,
                hight: 70,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
