// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductOptionEntity {
  int id;
  int productId;
  String name;
  String image;
  int price;
  ProductOptionEntity({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
  });
}
