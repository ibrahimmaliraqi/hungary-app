import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/repo/order_repo.dart';

class CreateOrderUseCase {
  final OrderRepo orderRepo;

  CreateOrderUseCase({required this.orderRepo});
  Future<Either<Failure, void>> call({required OrderEntity order}) async {
    return await orderRepo.createOrder(order: order);
  }
}
