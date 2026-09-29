import 'package:hungry_app/features/home/domain/entities/product_entity.dart';

final ProductEntity demoProduct = ProductEntity(
  disCount: 3.4,
  id: 1,
  name: "برغر",
  description: "برغر لحم طازج مع الخضار والصلصة الخاصة",
  image:
      "https://i.pinimg.com/736x/26/13/9c/26139cc85f59683e8e953eb161215f2c.jpg",
  rating: 4.9,
  price: 8.99,
);
final List<ProductEntity> demoProducts = [
  demoProduct,
  demoProduct,
  demoProduct,
  demoProduct,
  demoProduct,
  demoProduct,
];
