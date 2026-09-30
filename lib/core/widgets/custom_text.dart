import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool? lineThrough;
  final double? fontSize;
  final bool? isCaption;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.isCaption,
    this.lineThrough,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      textScaler: TextScaler.linear(1.0),
      text,
      maxLines: 2,
      style: TextStyle(
        decoration: lineThrough == true
            ? TextDecoration.lineThrough
            : TextDecoration.none,

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
