import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';

class AppPrice {
  static num currentPrice({required ProductEntity product}) {
    return product.disCount != 0 ? product.disCount! : product.price;
  }

  static num cartTotalPrice({required List<CartEntity> product}) {
    num total = 0;
    for (var element in product) {
      total += element.totalPrice;
    }
    return total;
  }
}
