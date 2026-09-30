import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/cart/data/model/cart_model.dart';

abstract class CartDataSource {
  Future<void> addToCart({required CartModel cart});
  Future<List<CartModel>> getCartItems();
}

class ApiCartDataSourceImpl implements CartDataSource {
  final DioClient dioClient;

  ApiCartDataSourceImpl({required this.dioClient});
  @override
  Future<void> addToCart({required CartModel cart}) async {
    try {
      final user = PrefsHelper.getUser();

      if (user?.id == null) {
        throw ServerException(
          errMessage: "المستخدم غير مسجل الدخول",
        );
      }
      final res = await dioClient.post(
        "cart/add_cart.php",
        data: cart.toMap(userId: user!.id!),
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

  @override
  Future<List<CartModel>> getCartItems() async {
    try {
      final user = PrefsHelper.getUser();

      if (user?.id == null) {
        throw ServerException(
          errMessage: "المستخدم غير مسجل الدخول",
        );
      }
      final res = await dioClient.post(
        "cart/get_cart.php",
        data: {"user_id": user!.id},
      );

      if (res['success'] == true) {
        final dataList = res["data"] as List;
        return dataList.map((e) => CartModel.fromMap(e)).toList();
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء جلب السلة",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getCartItems error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء جلب السلة",
      );
    }
  }
}
