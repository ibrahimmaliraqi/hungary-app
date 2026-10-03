import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/enums/payment_enum.dart';

final demoOrder = OrderEntity(
  id: 1,
  userId: 10,
  name: 'Ibrahim',
  phone: '07700000000',
  address: 'Mosul, Iraq',
  paymentStatus: 'PAID',
  orderStatus: 'PREPARING',
  totalPrice: 25000,
  paymentMethod: PaymentMethod.card,
  orderItems: [],
  createdAt: "2026-10-03 08:50:12",
);
final demoOrders = [
  demoOrder,
  demoOrder,
  demoOrder,
  demoOrder,
  demoOrder,
  demoOrder,
  demoOrder,
  demoOrder,
];
