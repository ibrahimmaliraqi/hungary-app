import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/functions/app_price.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/net_image.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final void Function()? onTap;
  const ProductCard({
    super.key,

    this.onTap,
    required this.product,
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
                  Center(
                    child: NetImage(
                      height: 120,
                      width: 120,
                      imageUrl: product.image,
                    ),
                  ),
                  Gap(9),
                  CustomText(
                    text: product.name,
                    fontSize: 16,
                    color: Color(0xff3C2F2F),
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(9),

                  CustomText(
                    text:
                        "${AppPrice.currentPrice(product: product)} دينار عراقي",
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(2),
                  product.disCount != 0 || product.disCount == null
                      ? CustomText(
                          isCaption: true,
                          lineThrough: true,
                          text: "${product.price} دينار عراقي",
                          fontSize: 12,
                          color: AppColors.discount,
                          fontWeight: FontWeight.w500,
                        )
                      : const SizedBox(
                          height: 18,
                        ),
                  Gap(9),
                  Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/product/star.png",
                            width: 17,
                            height: 17,
                          ),
                          Gap(8),

                          CustomText(
                            text: "${product.rating}",
                            fontSize: 14,

                            color: Color(0xff3C2F2F),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Spacer(),

                      Icon(
                        CupertinoIcons.heart,
                        color: AppColors.primary,
                      ),
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
