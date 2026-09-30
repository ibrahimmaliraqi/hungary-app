import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';

class AddProductState {
  final num price;
  final num spicy;
  final List<ProductOptionEntity> productOption;

  AddProductState({
    required this.price,
    required this.productOption,
    required this.spicy,
  });

  AddProductState copyWith({
    num? price,
    num? spicy,
    List<ProductOptionEntity>? productOption,
  }) {
    return AddProductState(
      spicy: spicy ?? this.spicy,
      price: price ?? this.price,
      productOption: productOption ?? this.productOption,
    );
  }
}
