import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/features/checkout/presentation/views/checkout_view.dart';
import 'package:intl/intl.dart';
import 'package:hungry_app/core/functions/order_state_function.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/core/widgets/net_image.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/enums/payment_enum.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;

  const OrderCard({
    super.key,
    required this.order,
  });

  static const primaryColor = Color(0xFF08431D);

  String formatPrice(num price) {
    return '${NumberFormat('#,###').format(price)} دينار عراقي';
  }

  String getPaymentMethodText() {
    switch (order.paymentMethod) {
      case PaymentMethod.cash:
        return 'كاش';

      case PaymentMethod.card:
        return 'أونلاين';
    }
  }

  IconData getPaymentIcon() {
    switch (order.paymentMethod) {
      case PaymentMethod.cash:
        return Icons.payments_outlined;

      case PaymentMethod.card:
        return Icons.credit_card;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // التاريخ وحالة الطلب
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.createdAt != null
                      ? DateFormat(
                          'yyyy/MM/dd - hh:mm a',
                          'ar',
                        ).format(DateTime.parse(order.createdAt!))
                      : 'تاريخ غير معروف',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    getOrderState(order: order),
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة المنتج
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: NetImage(
                    imageUrl: order.orderItems.isNotEmpty
                        ? order.orderItems.first.product.image
                        : '',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 15),

                // تفاصيل الطلب
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderItems.isNotEmpty
                            ? order.orderItems.first.product.name
                            : '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${order.orderItems.length} منتجات',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              formatPrice(order.totalPrice),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          // طريقة الدفع
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: order.paymentMethod == PaymentMethod.card
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  getPaymentIcon(),
                                  size: 14,
                                  color:
                                      order.paymentMethod == PaymentMethod.card
                                      ? Colors.blue
                                      : Colors.orange,
                                ),

                                const SizedBox(width: 4),

                                Text(
                                  getPaymentMethodText(),
                                  style: TextStyle(
                                    color:
                                        order.paymentMethod ==
                                            PaymentMethod.card
                                        ? Colors.blue
                                        : Colors.orange,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Divider(
              color: Colors.grey.shade200,
              thickness: 1.5,
            ),

            const SizedBox(height: 10),

            // الأزرار
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      GoRouter.of(context).push(
                        AppRouter.orderDetailsView,
                        extra: order,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      side: const BorderSide(
                        color: primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'تفاصيل الطلب',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CheckoutView(carts: order.orderItems),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'اطلب مجدداً',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
