import 'package:hungry_app/features/home/domain/entities/product_entity.dart';

class AppPrice {
  static num currentPrice({required ProductEntity product}) {
    return product.disCount != 0 ? product.disCount! : product.price;
  }
}
