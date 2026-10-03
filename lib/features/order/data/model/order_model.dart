import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/features/cart/data/model/cart_model.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/enums/payment_enum.dart';

class OrderModel {
  final int? id;
  final int userId;
  final String name;
  final String phone;
  final String address;
  final String paymentStatus;
  final String orderStatus;
  final num totalPrice;
  final PaymentMethod paymentMethod;
  final List<CartModel> orderItems;
  final String? createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.paymentStatus,
    required this.orderStatus,
    required this.totalPrice,
    required this.paymentMethod,
    required this.orderItems,
    required this.createdAt,
  });
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      userId: userId,
      name: name,
      phone: phone,
      address: address,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      totalPrice: totalPrice,
      paymentMethod: paymentMethod,
      orderItems: orderItems.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      paymentStatus: entity.paymentStatus,
      orderStatus: entity.orderStatus,
      totalPrice: entity.totalPrice,
      paymentMethod: entity.paymentMethod,
      orderItems: entity.orderItems
          .map((e) => CartModel.fromEntity(e))
          .toList(),
      createdAt: entity.createdAt,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'phone': phone,
      'address': address,
      'payment_status': paymentMethod == PaymentMethod.cash
          ? "unpaid"
          : "processing",
      'order_status': paymentMethod == PaymentMethod.cash
          ? "pending"
          : "pending",
      'total_price': totalPrice,
      'payment_method': paymentMethod == PaymentMethod.cash ? 'cash' : 'card',
      'order_items': orderItems
          .map((x) => x.toMap(userId: PrefsHelper.getUser()!.id!))
          .toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    final orderItems = map['order_items'] as List;
    final re = orderItems.map((e) => CartModel.fromMap(e)).toList();
    return OrderModel(
      id: map['id'] != null ? (map['id'] as num).toInt() : null,
      userId: map['user_id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      paymentStatus: map['payment_status'] as String,
      orderStatus: map['order_status'] as String,
      totalPrice: map['total_price'] as num,
      paymentMethod: map["payment_method"] == "cash"
          ? PaymentMethod.cash
          : PaymentMethod.card,
      orderItems: re,
      createdAt: map['created_at'],
    );
  }
}
