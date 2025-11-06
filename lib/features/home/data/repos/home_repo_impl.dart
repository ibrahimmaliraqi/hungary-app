import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';
import 'package:hungry_app/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  ApiService apiService = ApiService();
  @override
  Future<Either<Failure, List<ProductsModel>>> getProducts() async {
    try {
      final res = await apiService.get("/products");
      return right(
        (res['data'] as List).map((e) => ProductsModel.fromJson(e)).toList(),
      );
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
