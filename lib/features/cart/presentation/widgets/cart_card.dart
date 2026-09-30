import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/custom_button.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/net_image.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';

class CartCard extends StatelessWidget {
  final CartEntity cartEntity;
  const CartCard({
    super.key,
    this.onAdd,
    this.onMin,
    required this.number,
    required this.cartEntity,
  });
  final int number;
  final void Function()? onAdd;
  final void Function()? onMin;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            Column(
              children: [
                NetImage(
                  imageUrl: cartEntity.product.image,

                  width: 111,
                  height: 102,
                ),
                Gap(3),
                CustomText(
                  text: cartEntity.product.name,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: "${cartEntity.totalPrice} دينار عراقي",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onAdd,
                      child: Container(
                        width: 39,
                        height: 43,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Gap(20),
                    CustomText(text: number.toString()),
                    Gap(20),

                    GestureDetector(
                      onTap: onMin,
                      child: Container(
                        width: 39,
                        height: 43,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                Gap(40),
                CustomButton(
                  text: "Remove",
                  width: 140,
                  hight: 43,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
