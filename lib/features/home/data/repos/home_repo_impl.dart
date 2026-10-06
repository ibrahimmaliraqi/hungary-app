import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/features/home/data/data_source/home_remote.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';
import 'package:hungry_app/features/home/domain/repo/home_repo.dart';

import '../../../../core/error/failure.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemote homeRemote;

  HomeRepoImpl({required this.homeRemote});
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final res = await homeRemote.getProducts();

      return right(res.map((e) => e.toEntity()).toList());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final res = await homeRemote.getCategories();

      return right(res.map((e) => e.toEntity()).toList());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductOptionEntity>>> getSideOptions({
    required int productId,
  }) async {
    try {
      final res = await homeRemote.getSideOptions(productId: productId);

      return right(res.map((e) => e.toEntity()).toList());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductOptionEntity>>> getToppings({
    required int productId,
  }) async {
    try {
      final res = await homeRemote.getToppings(productId: productId);

      return right(res.map((e) => e.toEntity()).toList());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required int categoryId,
  }) async {
    try {
      final res = await homeRemote.getProductsByCategory(
        categoryId: categoryId,
      );

      return right(res.map((e) => e.toEntity()).toList());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }
}
