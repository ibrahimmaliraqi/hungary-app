import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class ToppingsCard extends StatelessWidget {
  final String image;
  final String text;
  const ToppingsCard({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Material(
        elevation: 8,

        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 126, 158, 125),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Image.network(
                image,

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
    );
  }
}
