import '../../domain/entities/orders_entity.dart';
import '../../domain/repositories/orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  @override
  Future<OrdersEntity> getOrders() async {
    throw UnimplementedError();
  }
}