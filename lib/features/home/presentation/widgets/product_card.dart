import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';

class ProductCard extends StatelessWidget {
  final void Function()? onTap;
  const ProductCard({
    super.key,

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
                    "https://i.pinimg.com/736x/26/13/9c/26139cc85f59683e8e953eb161215f2c.jpg",
                    width: 120,
                    height: 120,
                  ),
                  Gap(9),
                  CustomText(
                    text: "برغر",
                    fontSize: 16,
                    color: Color(0xff3C2F2F),
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    isCaption: true,
                    text: "برغر طيب ولذيذ",
                    fontSize: 14,
                    color: Color(0xff3C2F2F),
                    fontWeight: FontWeight.w400,
                  ),
                  Gap(9),
                  Row(
                    children: [
                      CustomText(
                        text: "⭐ 4.9",
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
