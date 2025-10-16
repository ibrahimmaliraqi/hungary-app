import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class SpicySlider extends StatelessWidget {
  final double value;
  final void Function(double val)? onChanged;

  const SpicySlider({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/product/image.jpg",
          width: 120,
          height: 240,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text:
                  "Customize Your Burger\n to Your Tastes.\n  UltimateExperience",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            Gap(18),
            CustomText(
              text: "Spicy",
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            Gap(4),
            Slider(
              activeColor: AppColors.primary,
              min: 0,
              max: 1,

              value: value,
              onChanged: onChanged,
            ),
            Row(
              children: [
                Gap(20),

                CustomText(text: "🥶"),
                Gap(110),

                CustomText(text: "🌶️"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
