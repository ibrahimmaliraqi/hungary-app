import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;

  final void Function()? onTap;
  const CustomAuthButton({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
        ),
        height: 50,
        width: double.infinity,
        child: Center(
          child: CustomText(
            text: text,
            color: textColor ?? AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
