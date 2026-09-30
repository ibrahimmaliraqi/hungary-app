import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/core/widgets/custom_button.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/loading.dart';
import 'package:hungry_app/core/widgets/snack.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/cart/domain/use_cases/add_to_cart_usecase.dart';
import 'package:hungry_app/features/cart/presentation/manager/add_to_cart/add_to_cart_cubit.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/use_case/get_side_option_usecase.dart';
import 'package:hungry_app/features/home/domain/use_case/get_toppings_usecase.dart';
import 'package:hungry_app/features/home/presentation/manager/add_product_cubit.dart';
import 'package:hungry_app/features/home/presentation/manager/add_product_state.dart';
import 'package:hungry_app/features/home/presentation/manager/get_product_options/get_product_options_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/product_details_view_body.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductEntity productEntity;
  const ProductDetailsView({
    super.key,
    required this.productEntity,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    context.read<AddProductCubit>().setProductPrice(
      widget.productEntity,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductOptionsCubit(
            getSideOptionUsecase: getIt.get<GetSideOptionUsecase>(),
            getToppingsUsecase: getIt.get<GetToppingsUsecase>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              AddToCartCubit(addToCartUsecase: getIt.get<AddToCartUsecase>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          forceMaterialTransparency: true,

          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
        body: ProductDetailsViewBody(
          productEntity: widget.productEntity,
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "السعر",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff3C2F2F),
                  ),
                  Gap(5),
                  BlocBuilder<AddProductCubit, AddProductState>(
                    builder: (context, state) {
                      return CustomText(
                        text:
                            "${context.read<AddProductCubit>().totalPrice} دينار عراقي",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3C2F2F),
                      );
                    },
                  ),
                ],
              ),

              Spacer(),
              BlocConsumer<AddToCartCubit, AddToCartState>(
                listener: (context, state) {
                  if (state is AddToCartFailure) {
                    Snack.show(
                      context,
                      message: state.errMessage,
                      isError: true,
                    );
                  }
                  if (state is AddToCartSuccess) {
                    Snack.show(
                      context,
                      message: "تمت إضافة المنتج إلى السلة",
                    );

                    context.go(AppRouter.cartView);
                  }
                },
                builder: (context, state) {
                  if (state is AddToCartLoading) {
                    return Loading(
                      color: Colors.white,
                    );
                  }
                  return CustomButton(
                    text: "اضف للسلة",
                    width: 170,
                    hight: 70,
                    onTap: () {
                      final data = context.read<AddProductCubit>();

                      CartEntity cart = CartEntity(
                        product: widget.productEntity,
                        productId: widget.productEntity.id,
                        quantity: 1,
                        spicy: data.state.spicy,
                        totalPrice: data.totalPrice,
                        productOptions: data.state.productOption,
                      );
                      context.read<AddToCartCubit>().addToCart(cart: cart);
                    },
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
