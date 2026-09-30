import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/home/data/models/product_option_model.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';

class CartModel {
  final ProductsModel product;
  final int quantity;
  final int productId;
  final num spicy;
  final num totalPrice;
  final List<ProductOptionModel> productOptions;

  CartModel({
    required this.product,
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.totalPrice,
    required this.productOptions,
  });
  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      product: ProductsModel.fromEntity(entity.product),
      productId: entity.productId,
      quantity: entity.quantity,
      spicy: entity.spicy,
      totalPrice: entity.totalPrice,
      productOptions: entity.productOptions
          .map((e) => ProductOptionModel.fromEntity(e))
          .toList(),
    );
  }
  Map<String, dynamic> toMap({required int userId}) {
    return <String, dynamic>{
      'user_id': userId,
      'product_id': productId,

      'product': product.toMap(),
      'quantity': quantity,
      'spicy': spicy,
      'total_price': totalPrice,
      'product_options': productOptions.map((x) => x.toMap()).toList(),
    };
  }

  CartEntity toEntity() {
    return CartEntity(
      productId: productId,
      product: product.toEntity(),
      quantity: quantity,
      spicy: spicy,
      totalPrice: totalPrice,
      productOptions: productOptions.map((e) => e.toEntity()).toList(),
    );
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      product: ProductsModel.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      productId: map['product_id'] as int,

      spicy: map['spicy'] as num,
      totalPrice: map['totalPrice'] as num,
      productOptions: (map['productOptions'] as List<dynamic>)
          .map(
            (e) => ProductOptionModel.fromMap(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}
