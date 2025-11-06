class ProductsModel {
  int? id;
  String? name;
  String? description;
  String? image;
  String? rating;
  String? price;

  ProductsModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.rating,
    this.price,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'];
    price = json['price'];
  }
}
