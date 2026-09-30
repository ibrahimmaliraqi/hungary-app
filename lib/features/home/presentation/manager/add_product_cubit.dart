import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/functions/app_price.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';
import 'package:hungry_app/features/home/presentation/manager/add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit()
    : super(
        AddProductState(
          spicy: 0,
          price: 0,
          productOption: [],
        ),
      );

  void setProductPrice(ProductEntity product) {
    final currentPrice = AppPrice.currentPrice(
      product: product,
    );

    emit(
      state.copyWith(
        price: currentPrice,
      ),
    );
  }

  void addTopping({
    required ProductOptionEntity option,
  }) {
    final options = List<ProductOptionEntity>.from(
      state.productOption,
    );

    if (options.contains(option)) {
      options.remove(option);
    } else {
      options.add(option);
    }

    emit(
      state.copyWith(
        productOption: options,
      ),
    );
  }

  void addSpicy({
    required double spicy,
  }) {
    emit(
      state.copyWith(
        spicy: spicy,
      ),
    );
  }

  num get totalPrice {
    num optionsPrice = 0;

    for (final option in state.productOption) {
      optionsPrice += option.price;
    }

    return state.price + optionsPrice;
  }
}
