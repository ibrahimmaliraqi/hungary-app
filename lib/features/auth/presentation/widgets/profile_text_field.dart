import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? type;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.controller,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      controller: controller,

      cursorColor: AppColors.primary,

      style: const TextStyle(
        color: Color(0xFF26332C),
        fontSize: 14,
      ),

      decoration: InputDecoration(
        labelText: label,

        labelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 13,
        ),

        floatingLabelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        border: buildBorder(),

        enabledBorder: buildBorder(),

        focusedBorder: buildFocusedBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFFD4E2D9),
        width: 1,
      ),
    );
  }

  OutlineInputBorder buildFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 1.5,
      ),
    );
  }
}
