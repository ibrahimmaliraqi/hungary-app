import 'package:flutter/material.dart';
import 'package:hungry_app/features/product/presentation/widgets/toppings_card..dart';

class ToppingCard extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ToppingCard({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            5,
            (index) {
              return ToppingsCard();
            },
          ),
        ],
      ),
    );
  }
}
