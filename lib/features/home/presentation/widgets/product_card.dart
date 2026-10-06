import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/functions/app_price.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/net_image.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Cleaner logic to check if a discount exists
    final bool hasDiscount = product.disCount != null && product.disCount != 0;

    return Card(
      elevation: 4,
      color: Colors.white,
      clipBehavior: Clip
          .antiAlias, // Ensures the InkWell ripple stays inside the rounded corners
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image
              Center(
                child: NetImage(
                  height: 120,
                  width: 120,
                  imageUrl: product.image,
                ),
              ),
              const Gap(12),

              // 2. Product Name
              CustomText(
                text: product.name,
                fontSize: 16,
                color: const Color(0xff3C2F2F),
                fontWeight: FontWeight.w600,
              ),
              const Gap(6),

              // 3. Current Price
              CustomText(
                text: "${AppPrice.currentPrice(product: product)} دينار عراقي",
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
              const Gap(2),

              // 4. Discount / Old Price
              if (hasDiscount)
                CustomText(
                  isCaption: true,
                  lineThrough: true,
                  text: "${product.price} دينار عراقي",
                  fontSize: 12,
                  color: AppColors.discount,
                  fontWeight: FontWeight.w500,
                )
              else
                const SizedBox(
                  height: 18,
                ), // Keeps layout height stable when no discount

              const Gap(12),

              // 5. Rating and Favorite Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const Gap(4),
                      CustomText(
                        text: "${product.rating}",
                        fontSize: 14,
                        color: const Color(0xff3C2F2F),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  const Icon(
                    CupertinoIcons.heart,
                    color: AppColors.primary,
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
