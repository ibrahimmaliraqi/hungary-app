import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/net_image.dart';

class ToppingsCard extends StatelessWidget {
  final String image;
  final void Function()? onTap;
  final String text;
  const ToppingsCard({
    super.key,
    required this.image,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Material(
        elevation: 8,

        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 126, 158, 125),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                NetImage(
                  imageUrl: image,
                  width: 60,
                  height: 60,
                ),
                Gap(7),
                CustomText(
                  text: text,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
