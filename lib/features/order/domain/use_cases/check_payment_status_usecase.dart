import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/order/domain/repo/order_repo.dart';

class CheckPaymentStatusUsecase {
  final OrderRepo orderRepo;

  CheckPaymentStatusUsecase({required this.orderRepo});
  Future<Either<Failure, bool>> call({required String orderId}) {
    return orderRepo.checkPaymentStatus(orderId: orderId);
  }
}
