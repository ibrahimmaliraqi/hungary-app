import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/home/data/models/category_model.dart';
import 'package:hungry_app/features/home/data/models/product_option_model.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';

abstract class HomeRemote {
  Future<List<ProductsModel>> getProducts();
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductOptionModel>> getToppings({
    required int productId,
  });
  Future<List<ProductOptionModel>> getSideOptions({
    required int productId,
  });
  Future<List<ProductsModel>> getProductsByCategory({
    required int categoryId,
  });
  Future<List<ProductsModel>> getProductsByTitle({
    required String query,
  });
}

class ApiHomeRemoteImpl implements HomeRemote {
  final DioClient dioClient;

  ApiHomeRemoteImpl({
    required this.dioClient,
  });

  @override
  Future<List<ProductsModel>> getProducts() async {
    try {
      final res = await dioClient.get(
        "products/get_products.php",
      );

      if (res['success'] == true) {
        final data = res['data'] as List;

        return data.map((e) => ProductsModel.fromMap(e)).toList();
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء جلب المنتجات",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getProducts error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء جلب المنتجات",
      );
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final res = await dioClient.get(
        "categories/get_categories.php",
      );

      if (res['success'] == true) {
        final data = res['data'] as List;

        return data.map((e) => CategoryModel.fromMap(e)).toList();
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء جلب التصنيفات",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getCategories error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء جلب التصنيفات",
      );
    }
  }

  @override
  Future<List<ProductOptionModel>> getSideOptions({
    required int productId,
  }) async {
    try {
      final res = await dioClient.post(
        "products/get_side_options.php",
        data: {"product_id": productId},
      );

      if (res['success'] == true) {
        final data = res['data'] as List;

        return data.map((e) => ProductOptionModel.fromMap(e)).toList();
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء جلب الإضافات الجانبية",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getCategories error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء جلب الإضافات الجانبية",
      );
    }
  }

  @override
  Future<List<ProductOptionModel>> getToppings({required int productId}) async {
    try {
      final res = await dioClient.post(
        "products/get_toppings.php",
        data: {"product_id": productId},
      );

      if (res['success'] == true) {
        final data = res['data'] as List;

        return data.map((e) => ProductOptionModel.fromMap(e)).toList();
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء جلب الإضافات",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getCategories error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء جلب الإضافات",
      );
    }
  }

  @override
  Future<List<ProductsModel>> getProductsByCategory({
    required int categoryId,
  }) async {
    try {
      final res = await dioClient.post(
        "products/get_products_by_category.php?category_id=$categoryId",
      );

      if (res['success'] == true) {
        final data = res['data'] as List;
        print(data);

        return data.map((e) => ProductsModel.fromMap(e)).toList();
      }
      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء منتجات القسم",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getCategories error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء منتجات القسم",
      );
    }
  }

  @override
  Future<List<ProductsModel>> getProductsByTitle({
    required String query,
  }) async {
    try {
      final res = await dioClient.post(
        "products/search_products.php?query=$query",
      );

      if (res['success'] == true) {
        final data = res['data'] as List;
        print(data);

        return data.map((e) => ProductsModel.fromMap(e)).toList();
      }
      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء البحث",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getCategories error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء البحث",
      );
    }
  }
}
