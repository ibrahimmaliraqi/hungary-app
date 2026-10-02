import '../entities/orders_entity.dart';
import '../repositories/orders_repo.dart';

class CreateOrderUseCase {
  final OrdersRepo repository;

  CreateOrderUseCase({
    required this.repository,
  });

  Future<OrdersEntity> call() async {
    return repository.getOrders();
  }
}