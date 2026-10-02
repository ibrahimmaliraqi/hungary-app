import 'package:flutter/material.dart';
import 'package:hungry_app/features/order/presentation/widgets/custom_again_item.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FA,
      ), // Off-white background for contrast
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: 10,
          itemBuilder: (context, index) {
            // Staggered animation effect
            return TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(
                milliseconds: 400 + (index * 100).clamp(0, 1000),
              ),
              curve: Curves.easeOutCubic,
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: const CustomAgainItem(),
            );
          },
        ),
      ),
    );
  }
}
