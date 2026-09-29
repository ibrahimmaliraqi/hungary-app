import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/assets/assets.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';

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
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: Image.network(
            image,
            height: 240,
          ),
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
                Image.asset(
                  Assets.assetsImagesColdIcon,
                  width: 25,
                  height: 25,
                ),
                Spacer(),

                Image.asset(
                  Assets.assetsImagesHotIcon,
                  width: 25,
                  height: 25,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
