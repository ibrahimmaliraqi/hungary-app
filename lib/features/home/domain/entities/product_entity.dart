// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductEntity {
  int id;
  String name;
  String description;
  String image;
  num rating;
  num price;
  num? disCount;
  ProductEntity({
    required this.id,
    this.disCount,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });
}
