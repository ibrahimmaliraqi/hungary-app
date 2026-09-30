import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';

final CartEntity demoCart = CartEntity(
  product: ProductEntity(
    id: 1,
    name: "name",
    description: "description",
    image: "image",
    rating: 3.5,
    price: 1500,
  ),
  productId: 11,
  quantity: 1,
  spicy: 1,
  totalPrice: 15000,
  productOptions: [
    ProductOptionEntity(
      id: 11,
      productId: 11,
      name: "name",
      image: "image",
      price: 500,
    ),
    ProductOptionEntity(
      id: 11,
      productId: 11,
      name: "name",
      image: "image",
      price: 500,
    ),
  ],
);
final List<CartEntity> demoCarts = [
  demoCart,
  demoCart,
  demoCart,
  demoCart,
  demoCart,
  demoCart,
  demoCart,
  demoCart,
];
