import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/order/domain/entities/payment_entity.dart';
import 'package:hungry_app/features/order/domain/repo/order_repo.dart';

class CreatePaymentUsecase {
  final OrderRepo orderRepo;

  CreatePaymentUsecase({required this.orderRepo});
  Future<Either<Failure, String>> call({required PaymentEntity payment}) async {
    return await orderRepo.createPayment(payment: payment);
  }
}
