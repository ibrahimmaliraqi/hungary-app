import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_button.dart';
import 'package:hungry_app/core/shared/custom_text.dart';
import 'package:hungry_app/features/checkout/presentation/views/checkout_view.dart';
import 'package:hungry_app/features/product/presentation/widgets/spicy_slider.dart';
import 'package:hungry_app/features/product/presentation/widgets/topping_card.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  double value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,

        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Padding(
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

              Gap(110),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 0),
              color: Colors.black,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
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
              text: "Check Out",
              width: 170,
              hight: 70,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
