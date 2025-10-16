import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/assets.dart';
import 'package:hungry_app/core/shared/custom_button.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    this.onAdd,
    this.onMin,
    required this.number,
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
                Image.asset(
                  Assets.splashLogo,
                  width: 111,
                  height: 102,
                ),
                Gap(3),
                CustomText(
                  text: "Hamburger",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: "Veggie Burger",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
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
