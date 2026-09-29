import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final bool isPassword;
  const CustomTextFormField({
    super.key,
    required this.text,
    required this.controller,
    required this.isPassword,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isObscured;
  @override
  void initState() {
    isObscured = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      controller: widget.controller,
      cursorColor: AppColors.primary,
      obscureText: isObscured,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword == true
            ? IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            : null,
        hintText: widget.text,
        filled: true,
        fillColor: Colors.white,
        border: buildBorder(),
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
  }
}
