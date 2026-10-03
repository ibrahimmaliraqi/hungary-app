import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hungry_app/core/functions/order_state_function.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';

class OrderDetailsView extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailsView({
    super.key,
    required this.order,
  });

  static const primaryColor = Color(0xFF08431D);
  static const bgColor = Color(0xFFF8F9FA);

  String formatPrice(num price) {
    return '${NumberFormat('#,###').format(price)} دينار عراقي';
  }

  String getPaymentMethodText() {
    switch (order.paymentMethod.name) {
      case 'cash':
        return 'الدفع عند الاستلام';

      case 'card':
        return 'الدفع الإلكتروني';

      default:
        return 'غير محدد';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        centerTitle: true,
        title: Text(
          'الطلب رقم ${order.id ?? 'جديد'}',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(),
            const SizedBox(height: 24),

            _buildSectionTitle('تفاصيل التوصيل'),
            const SizedBox(height: 12),
            _buildDeliveryInfoCard(),

            const SizedBox(height: 24),

            _buildSectionTitle('المنتجات'),
            const SizedBox(height: 12),
            _buildOrderItems(),

            const SizedBox(height: 24),

            _buildReceiptSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            primaryColor,
            Color(0xFF2E7D32),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'حالة الطلب',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              if (order.createdAt != null)
                Text(
                  DateFormat(
                    'yyyy/MM/dd - hh:mm a',
                    'ar',
                  ).format(DateTime.parse(order.createdAt!)),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  getOrderState(order: order),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      order.paymentStatus.toLowerCase() == 'paid'
                          ? Icons.check_circle
                          : Icons.pending,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      getPaymentState(order: order),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            Icons.person_outline,
            order.name,
          ),

          const Divider(
            height: 24,
            thickness: 1,
            color: Color(0xFFF0F0F0),
          ),

          _buildInfoRow(
            Icons.phone_outlined,
            order.phone,
          ),

          const Divider(
            height: 24,
            thickness: 1,
            color: Color(0xFFF0F0F0),
          ),

          _buildInfoRow(
            Icons.location_on_outlined,
            order.address,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItems() {
    if (order.orderItems.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'لا توجد منتجات في هذا الطلب',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: order.orderItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = order.orderItems[index];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item.product.image,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.fastfood,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    if (item.spicy > 0) _buildSpicyIndicator(item.spicy),

                    const SizedBox(height: 8),

                    if (item.productOptions.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: item.productOptions.map((opt) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '+ ${opt.name}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatPrice(item.totalPrice),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '× ${item.quantity}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpicyIndicator(num spicyLevel) {
    return Row(
      children: List.generate(
        3,
        (index) {
          return Icon(
            Icons.local_fire_department,
            size: 16,
            color: index < spicyLevel ? Colors.redAccent : Colors.grey[300],
          );
        },
      ),
    );
  }

  Widget _buildReceiptSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            'طريقة الدفع',
            getPaymentMethodText(),
          ),

          const SizedBox(height: 12),

          _buildSummaryRow(
            'المجموع الفرعي',
            formatPrice(order.totalPrice),
          ),

          const SizedBox(height: 12),

          _buildSummaryRow(
            'أجرة التوصيل',
            'مشمولة',
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: _DashedLine(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'المجموع الكلي',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                formatPrice(order.totalPrice),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            final boxWidth = constraints.constrainWidth();

            const dashWidth = 8.0;
            const dashHeight = 1.5;

            final dashCount = (boxWidth / (2 * dashWidth)).floor();

            return Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: List.generate(
                dashCount,
                (_) {
                  return const SizedBox(
                    width: dashWidth,
                    height: dashHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                    ),
                  );
                },
              ),
            );
          },
    );
  }
}
