import 'package:dartz/dartz.dart';
import 'package:hungry_app/features/product/data/models/cart_model.dart';
import 'package:hungry_app/features/product/data/models/toppings_model.dart';
import 'package:hungry_app/features/product/data/repos/product_detils_repo.dart';

import '../../../../core/error/supabsae_failure.dart';
import '../../../../main.dart';

class ProductDetilsRepoImpl implements ProductDetilsRepo {
  @override
  Future<Either<Failure, List<ToppingsModel>>> getSideOption() async {
    try {
      final data = await supabase.from('side_options').select();
      List<ToppingsModel> items = [];
      for (var item in data) {
        items.add(ToppingsModel.fromJson(item));
      }

      return right(items);
    } catch (e) {
      return left(SupabaseAuthError.from(e));
    }
  }

  @override
  Future<Either<Failure, List<ToppingsModel>>> getToppings() async {
    try {
      final data = await supabase.from('toppings').select();
      List<ToppingsModel> items = [];
      for (var item in data) {
        items.add(ToppingsModel.fromJson(item));
      }

      return right(items);
    } catch (e) {
      return left(SupabaseAuthError.from(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> addOrUpdateCart({
    required String userId,
    required CartModel cart,
  }) async {
    try {
      await supabase.from('cart').upsert({
        'id': userId,
        'cart': cart.toJson()['items'],
      });
      return right("تمت الاضافة");
    } catch (e) {
      return left(SupabaseAuthError.from(e));
    }
  }
}
