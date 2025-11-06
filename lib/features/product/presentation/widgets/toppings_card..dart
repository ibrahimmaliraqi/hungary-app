import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class ToppingsCard extends StatelessWidget {
  const ToppingsCard({
    super.key,
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
              Image.asset(
                "assets/test/to.png",

                width: 60,
                height: 60,
              ),
              Gap(7),
              CustomText(
                text: "Tomato",
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
