import '../entities/orders_entity.dart';

abstract class OrdersRepo {
  Future<OrdersEntity> getOrders();
}