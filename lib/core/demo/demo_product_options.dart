import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';

final ProductOptionEntity demoProductOptionsOne = ProductOptionEntity(
  id: 1,
  productId: 101,
  name: 'Matte Black',
  image:
      'https://i.pinimg.com/736x/93/90/e6/9390e6cd144f89705ab95dcb0c60fb41.jpg',
  price: 0, // Base price option
);
final List<ProductOptionEntity> demoProductOptions = [
  demoProductOptionsOne,
  demoProductOptionsOne,
  demoProductOptionsOne,
  demoProductOptionsOne,
  demoProductOptionsOne,
  demoProductOptionsOne,
];
