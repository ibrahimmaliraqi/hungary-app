import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/order/domain/enums/payment_enum.dart';

class OrderEntity {
  final int? id;
  final int userId;
  final String name;
  final String phone;
  final String address;
  final String paymentStatus;
  final String orderStatus;
  final num totalPrice;
  final PaymentMethod paymentMethod;
  final List<CartEntity> orderItems;
  final String? createdAt;

  const OrderEntity({
    this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.totalPrice,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.orderItems,
    this.createdAt,
  });
}
