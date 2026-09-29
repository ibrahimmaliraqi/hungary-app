import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';

abstract class HomeRemote {
  Future<List<ProductsModel>> getProducts();
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
}
