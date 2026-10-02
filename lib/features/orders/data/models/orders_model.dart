import '../../domain/entities/orders_entity.dart';

class OrdersModel extends OrdersEntity {
  OrdersModel({
    required super.id,
  });

  factory OrdersModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OrdersModel(
      id: map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}