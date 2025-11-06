import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class CustomCardItem extends StatelessWidget {
  final void Function()? onTap;
  final String image, title, subTitle, rating;
  const CustomCardItem({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                left: -8,
                top: 95,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: SvgPicture.asset(
                    "assets/logo/shado.svg",
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    image,
                    width: 120,
                    height: 120,
                  ),
                  Gap(9),
                  CustomText(
                    text: title,
                    fontSize: 16,
                    color: Color(0xff3C2F2F),
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    isCaption: true,
                    text: subTitle,
                    fontSize: 14,
                    color: Color(0xff3C2F2F),
                    fontWeight: FontWeight.w400,
                  ),
                  Gap(9),
                  Row(
                    children: [
                      CustomText(
                        text: "⭐ $rating",
                        fontSize: 14,

                        color: Color(0xff3C2F2F),
                        fontWeight: FontWeight.w400,
                      ),
                      Spacer(),
                      Icon(CupertinoIcons.heart_fill, color: AppColors.primary),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
