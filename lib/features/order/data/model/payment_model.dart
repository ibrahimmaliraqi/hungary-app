// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hungry_app/features/order/domain/entities/payment_entity.dart';

class PaymentModel {
  final int? id;
  final int orderId;
  final double amount;
  final String name;
  final String phone;
  final String address;
  final String? status;
  final String? transactionId;
  final String? paymentUrl;
  final DateTime? createdAt;

  PaymentModel({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.name,
    required this.phone,
    required this.address,
    required this.status,
    required this.transactionId,
    required this.paymentUrl,
    required this.createdAt,
  });
  factory PaymentModel.fromEntity(PaymentEntity entity) {
    return PaymentModel(
      id: entity.id,
      orderId: entity.orderId,
      amount: entity.amount,
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      status: entity.status,
      transactionId: entity.transactionId,
      paymentUrl: entity.paymentUrl,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderId,
      'amount': amount,
      'name': name,
      'phone': phone,
      'address': address,
      'status': status,
      'transaction_id': transactionId,
      'payment_url': paymentUrl,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'],
      orderId: map['order_id'] as int,
      amount: map['amount'] as double,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      status: map['status'] != null ? map['status'] as String : null,
      transactionId: map['transaction_id'] != null
          ? map['transaction_id'] as String
          : null,
      paymentUrl: map['payment_url'] != null
          ? map['payment_url'] as String
          : null,
      createdAt: map['created_at'],
    );
  }
}
