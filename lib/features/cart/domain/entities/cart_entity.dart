import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';

class CartEntity {
  final ProductEntity product;
  final int quantity;
  final int productId;
  final num spicy;
  final num totalPrice;
  final List<ProductOptionEntity> productOptions;

  CartEntity({
    required this.product,
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.totalPrice,
    required this.productOptions,
  });
}
