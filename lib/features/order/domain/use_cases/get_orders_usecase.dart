import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/repo/order_repo.dart';

class GetOrdersUsecase {
  final OrderRepo orderRepo;

  GetOrdersUsecase({required this.orderRepo});
  Future<Either<Failure, List<OrderEntity>>> call({required int userId}) {
    return orderRepo.getOrders(userId: userId);
  }
}
