import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';

class ProductOptionModel {
  int id;
  int productId;
  String name;
  String image;
  int price;
  ProductOptionModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
  });
  ProductOptionEntity toEntity() {
    return ProductOptionEntity(
      id: id,
      productId: productId,
      name: name,
      image: image,
      price: price,
    );
  }

  factory ProductOptionModel.fromMap(Map<String, dynamic> map) {
    return ProductOptionModel(
      id: map['id'] as int,
      productId: map['product_id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as int,
    );
  }
}
