import 'package:hungry_app/features/home/domain/entities/product_entity.dart';

class ProductsModel {
  int id;
  String name;
  String description;
  String image;
  num rating;
  num price;
  num? disCount;
  ProductsModel({
    required this.id,
    this.disCount,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });
  ProductEntity toEntity() {
    return ProductEntity(
      disCount: disCount,
      id: id,

      name: name,
      description: description,
      image: image,
      rating: rating,
      price: price,
    );
  }

  factory ProductsModel.fromEntity(ProductEntity entity) {
    return ProductsModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      image: entity.image,
      rating: entity.rating,
      price: entity.price,
      disCount: entity.disCount,
    );
  }
  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      rating: map['rating'] as num,
      price: map['price'] as num,
      disCount: map['discount'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'rating': rating,
      'price': price,
      'disCount': disCount,
    };
  }
}
