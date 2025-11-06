import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/product/data/models/toppings_model.dart';
import 'package:hungry_app/features/product/data/repos/product_detils_repo.dart';

class ProductDetilsRepoImpl implements ProductDetilsRepo {
  ApiService apiService = ApiService();
  @override
  Future<Either<Failure, List<ToppingsModel>>> getSideOption() async {
    try {
      final res = await apiService.get("/side-options");
      return right(
        (res['data'] as List).map((e) => ToppingsModel.fromJson(e)).toList(),
      );
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ToppingsModel>>> getToppings() async {
    try {
      final res = await apiService.get("/toppings");
      return right(
        (res['data'] as List).map((e) => ToppingsModel.fromJson(e)).toList(),
      );
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
