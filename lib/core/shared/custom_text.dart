import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final bool? isCaption;
  final FontWeight? fontWeight;
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.isCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textScaler: TextScaler.linear(1.0),
      text,
      maxLines: 2,
      style: TextStyle(
        color: color,
        overflow: isCaption == true
            ? TextOverflow.ellipsis
            : TextOverflow.visible,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
