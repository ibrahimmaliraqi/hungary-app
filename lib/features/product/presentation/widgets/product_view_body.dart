import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/shared/custom_button.dart';
import 'package:hungry_app/core/shared/custom_text.dart';
import 'package:hungry_app/features/product/presentation/widgets/spicy_slider.dart';
import 'package:hungry_app/features/product/presentation/widgets/topping_card.dart';

class ProductViewBody extends StatefulWidget {
  const ProductViewBody({super.key});

  @override
  State<ProductViewBody> createState() => _ProductViewBodyState();
}

class _ProductViewBodyState extends State<ProductViewBody> {
  double value = 0.5;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpicySlider(
              value: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
            Gap(40),
            CustomText(
              text: "Toppings",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            Gap(9),
            ToppingCard(
              text: "Tomato",
              onTap: () {},
            ),
            Gap(40),
            CustomText(
              text: "Side options",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            Gap(9),

            ToppingCard(
              text: "Potato",
              onTap: () {},
            ),
            Gap(40),
            Row(
              children: [
                Column(
                  children: [
                    CustomText(
                      text: "Total",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff3C2F2F),
                    ),
                    Gap(5),
                    CustomText(
                      text: "\$18.19",
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff3C2F2F),
                    ),
                  ],
                ),

                Spacer(),
                CustomButton(
                  text: "Add To Cart",
                  width: 170,
                  hight: 70,
                  onTap: () {},
                ),
              ],
            ),
            Gap(100),
          ],
        ),
      ),
    );
  }
}
