import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/entities/payment_entity.dart';

abstract class OrderRepo {
  Future<Either<Failure, int>> createOrder({required OrderEntity order});
  Future<Either<Failure, List<OrderEntity>>> getOrders({required int userId});
  Future<Either<Failure, String>> createPayment({
    required OrderEntity order,

    required PaymentEntity payment,
  });
}
