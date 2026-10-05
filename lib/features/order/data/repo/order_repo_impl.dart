import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/order/data/model/order_model.dart';
import 'package:hungry_app/features/order/data/model/payment_model.dart';
import 'package:hungry_app/features/order/data/remote/order_remote.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/entities/payment_entity.dart';
import 'package:hungry_app/features/order/domain/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderRemote orderRemote;

  OrderRepoImpl({
    required this.orderRemote,
  });

  @override
  Future<Either<Failure, int>> createOrder({
    required OrderEntity order,
  }) async {
    try {
      final res = await orderRemote.createOrder(
        order: OrderModel.fromEntity(order),
      );

      return right(res);
    } on AppExceptions catch (e) {
      return left(
        ServerFailure(
          message: e.errMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({
    required int userId,
  }) async {
    try {
      final res = await orderRemote.getOrders(
        userId: userId,
      );

      return right(
        res.map((e) => e.toEntity()).toList(),
      );
    } on AppExceptions catch (e) {
      return left(
        ServerFailure(
          message: e.errMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> createPayment({
    required OrderEntity order,
    required PaymentEntity payment,
  }) async {
    try {
      // أولاً ننشئ الطلب
      final orderId = await orderRemote.createOrder(
        order: OrderModel.fromEntity(order),
      );

      // بعدها ننشئ عملية الدفع ونربطها بالطلب
      final paymentUrl = await orderRemote.createPayment(
        order: order,
        payment: PaymentModel.fromEntity(payment).copyWith(
          orderId: orderId,
        ),
      );

      return right(paymentUrl);
    } on AppExceptions catch (e) {
      return left(
        ServerFailure(
          message: e.errMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> checkPaymentStatus({
    required String orderId,
  }) async {
    try {
      final res = await orderRemote.checkPaymentStatus(orderId: orderId);

      return right(res);
    } on AppExceptions catch (e) {
      return left(
        ServerFailure(
          message: e.errMessage,
        ),
      );
    }
  }
}
