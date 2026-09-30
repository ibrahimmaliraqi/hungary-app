import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/home/data/models/product_option_model.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';

class CartModel {
  final ProductsModel product;
  final int quantity;
  final num? spicy;
  final num? totalPrice;
  final List<ProductOptionModel> productOptions;

  CartModel({
    required this.product,
    required this.quantity,
    required this.spicy,
    required this.totalPrice,
    required this.productOptions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
      'spicy': spicy,
      'totalPrice': totalPrice,
      'productOptions': productOptions.map((x) => x.toMap()).toList(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      product: ProductsModel.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      spicy: map['spicy'] != null ? map['spicy'] as num : null,
      totalPrice: map['totalPrice'] != null ? map['totalPrice'] as num : null,
      productOptions: List<ProductOptionModel>.from(
        (map['productOptions'] as List<int>).map<ProductOptionModel>(
          (x) => ProductOptionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      product: product.toEntity(),
      quantity: quantity,
      spicy: spicy,
      totalPrice: totalPrice,
      productOptions: productOptions.map((e) => e.toEntity()).toList(),
    );
  }
}
