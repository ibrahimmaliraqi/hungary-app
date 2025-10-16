import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/assets.dart';
import 'package:hungry_app/core/shared/custom_button.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class CustomAgainItem extends StatelessWidget {
  const CustomAgainItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),

      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    Assets.splashLogo,
                    width: 100,
                    height: 100,
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Hamburger Salid",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "Qty: X3 ",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomText(
                        text: r"Price: 20$",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),

              CustomButton(
                text: "Order Again",
                width: double.infinity,
                hight: 50,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
