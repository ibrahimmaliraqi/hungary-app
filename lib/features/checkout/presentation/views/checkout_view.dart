import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_button.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Order summary",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            Gap(20),
            orderMony(name: "Order", price: "\$18.48"),
            Gap(10),
            orderMony(name: "Taxes", price: "\$0.3"),
            Gap(10),
            orderMony(name: "Delivery fees", price: "\$1.5"),
            Gap(14),
            Divider(),
            orderMony(name: "Total:", price: "\$18.19", isBold: true),
            Gap(20),

            orderMony(
              name: "Estimated delivery time:",
              price: "15 - 30 mins",
              size: 13,
              isBold: true,
            ),

            Gap(60),
            CustomText(
              text: "Payment methods",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            Gap(20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              tileColor: Color(0xff3C2F2F),
              title: CustomText(
                text: "Cash on Delivery",
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              leading: Image.asset(
                "assets/payout/image.png",
                width: 50,
              ),
              trailing: Radio(
                fillColor: WidgetStateProperty.resolveWith<Color?>(
                  (states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey;
                    }
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white;
                    }
                    return Colors.blue;
                  },
                ),
                value: "Cash",
                groupValue: "Cash",
                onChanged: (value) {},
              ),
            ),
            Gap(20),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              tileColor: Colors.blue.shade100,
              title: CustomText(
                text: "Debit card",

                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              subtitle: CustomText(
                text: "3566 **** **** 0505",
                fontSize: 13,
              ),
              leading: Image.asset(
                "assets/payout/visa.png",
                width: 50,
              ),
              trailing: Radio(
                fillColor: WidgetStateProperty.resolveWith<Color?>(
                  (states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey;
                    }
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white;
                    }
                    return Colors.blue;
                  },
                ),
                value: "Debit",
                groupValue: "Debit",
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
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
              text: "Pay Now",
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

Widget orderMony({
  required String name,
  required String price,
  bool isBold = false,
  double? size,
}) {
  return Row(
    children: [
      CustomText(
        text: name,
        fontSize: size ?? 18,
        color: isBold == true ? Colors.black : Colors.grey,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.w400,
      ),
      Spacer(),
      CustomText(
        text: price,
        fontSize: size ?? 18,

        color: isBold == true ? Colors.black : Colors.grey,

        fontWeight: isBold == true ? FontWeight.bold : FontWeight.w400,
      ),
    ],
  );
}
