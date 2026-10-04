class PaymentEntity {
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

  const PaymentEntity({
    this.id,
    required this.orderId,
    required this.amount,
    required this.name,
    required this.phone,
    required this.address,
    this.status = "unpaid",
    this.transactionId,
    this.paymentUrl,
    this.createdAt,
  });
}
