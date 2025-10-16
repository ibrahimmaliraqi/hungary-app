import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/shared/custom_button.dart';
import 'package:hungry_app/core/shared/custom_text.dart';
import 'package:hungry_app/features/cart/presentation/widgets/custom_cart_item.dart';
import 'package:hungry_app/features/checkout/presentation/views/checkout_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> quntities;
  int itemCount = 20;
  @override
  void initState() {
    quntities = List.generate(
      itemCount,
      (index) => 1,
    );
    super.initState();
  }

  void onAdd(index) {
    setState(() {
      quntities[index]++;
    });
  }

  void onMin(index) {
    if (quntities[index] > 1) {
      setState(() {
        quntities[index]--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 120),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return CustomCartItem(
                      number: quntities[index],
                      onAdd: () => onAdd(index),
                      onMin: () => onMin(index),
                    );
                  },
                ),
              ),
            ],
          ),
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
