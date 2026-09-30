import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/cart/data/model/cart_model.dart';

abstract class CartDataSource {
  Future<void> addToCart({required CartModel cart});
}

class ApiCartDataSourceImpl implements CartDataSource {
  final DioClient dioClient;

  ApiCartDataSourceImpl({required this.dioClient});
  @override
  Future<void> addToCart({required CartModel cart}) async {
    try {
      final res = await dioClient.post(
        "cart/add_cart.php",
        data: cart.toMap(userId: 133),
      );

      if (res['success'] == true) {
        return;
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء إضافة المنتج للسلة",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("addToCart error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء إضافة المنتج للسلة",
      );
    }
  }
}
