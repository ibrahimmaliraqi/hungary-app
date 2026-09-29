import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/custom_button.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/presentation/widgets/product_details_view_body.dart';
import 'package:hungry_app/features/product/data/manager/cart/cart_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailsView({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        productEntity: productEntity,
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
                  text: "السعر الكلي",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff3C2F2F),
                ),
                Gap(5),
                CustomText(
                  text: "${productEntity.price} دينار عراقي",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3C2F2F),
                ),
              ],
            ),

            Spacer(),
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartFailure) {
                  print(state.errMessage);
                }
                if (state is CartLoaded) {
                  SnackBar(content: CustomText(text: "تمت الاضافه"));
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: "اضف للسلة",
                  width: 170,
                  hight: 70,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
