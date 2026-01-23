import 'package:dartz/dartz.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';
import 'package:hungry_app/features/home/data/repos/home_repo.dart';

import '../../../../core/error/supabsae_failure.dart';
import '../../../../main.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, List<ProductsModel>>> getProducts() async {
    try {
      final data = await supabase.from('products').select();
      List<ProductsModel> items = [];
      for (var item in data) {
        items.add(ProductsModel.fromJson(item));
      }

      return right(items);
    } catch (e) {
      return left(SupabaseAuthError.from(e));
    }
  }
}
