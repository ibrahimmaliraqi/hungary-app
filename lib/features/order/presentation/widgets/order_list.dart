import 'package:flutter/material.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/enums/payment_enum.dart';
import 'package:hungry_app/features/order/presentation/widgets/order_card.dart';

class OrdersList extends StatelessWidget {
  final List<OrderEntity> orders;
  const OrdersList({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: orders.length,
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
          child: OrderCard(
            order: orders[index],
            isOnlinePayment: orders[index].paymentMethod == PaymentMethod.card
                ? true
                : false,
          ),
        );
      },
    );
  }
}
