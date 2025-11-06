import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class SpicySlider extends StatelessWidget {
  final double value;
  final String image;
  final void Function(double val)? onChanged;

  const SpicySlider({
    super.key,
    required this.value,
    this.onChanged,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(
          image,
          height: 240,
        ),
        Column(
          children: [
            Gap(20),
            Slider(
              padding: EdgeInsets.all(0),
              activeColor: AppColors.primary,
              min: 0,
              max: 1,

              value: value,
              onChanged: onChanged,
            ),
            Row(
              children: [
                CustomText(text: "🥶"),
                Spacer(),

                CustomText(text: "🌶️"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
