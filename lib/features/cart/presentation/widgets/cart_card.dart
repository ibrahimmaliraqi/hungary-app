import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/net_image.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';

class CartCard extends StatelessWidget {
  final CartEntity cartEntity;
  final int number;
  final void Function()? onAdd;
  final void Function()? onMin;
  final VoidCallback? onDelete;

  const CartCard({
    super.key,
    required this.cartEntity,
    required this.number,
    this.onAdd,
    this.onMin,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Creative Image Container
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: NetImage(
                    imageUrl: cartEntity.product.image,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),

              const Gap(16),

              // Product Info Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Spacing for Delete Icon
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ), // space for trash icon
                      child: CustomText(
                        text: cartEntity.product.name,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Gap(4),

                    // Price with Highlight
                    CustomText(
                      text: "${cartEntity.totalPrice} دينار",
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),

                    const Gap(10),

                    // Creative Tags for Options (Spicy & Add-ons)
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        if (cartEntity.spicy != null)
                          _buildTag(
                            icon: Icons.local_fire_department_rounded,
                            text: "حار: ${cartEntity.spicy}",
                            color: Colors.orange,
                          ),
                        ...cartEntity.productOptions.map(
                          (option) => _buildTag(
                            icon: Icons.add_circle_rounded,
                            text: option.name,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const Gap(12),

                    // Quantity Pill Stepper
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _buildQuantityPill(),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Elegant Delete Icon Button in the top corner (RTL responsive)
          Positioned(
            left: 0,
            top: 0,
            child: InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.redAccent,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Creative Widget Generators ---

  // 1. Tag UI for Spicy & Add-ons
  Widget _buildTag({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const Gap(4),
          CustomText(
            text: text,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ],
      ),
    );
  }

  // 2. Modern Pill-shaped Stepper for Quantity
  Widget _buildQuantityPill() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Light grey background
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // _stepperButton(
          //   icon: Icons.remove_rounded,
          //   onTap: onMin,
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 12),
          //   child: CustomText(
          //     text: number.toString(),
          //     fontSize: 15,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // _stepperButton(
          //   icon: Icons.add_rounded,
          //   onTap: onAdd,
          //   isAdd: true,
          // ),
        ],
      ),
    );
  }

  // Helper for Stepper buttons inside the Pill
  Widget _stepperButton({
    required IconData icon,
    required VoidCallback? onTap,
    bool isAdd = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isAdd ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: isAdd ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
