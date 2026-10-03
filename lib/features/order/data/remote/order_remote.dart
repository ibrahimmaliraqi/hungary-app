import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/order/data/model/order_model.dart';

abstract class OrderRemote {
  Future<void> createOrder({required OrderModel order});
  Future<List<OrderModel>> getOrders({required int userId});
}

class ApiOrderRemoteImpl implements OrderRemote {
  final DioClient dioClient;

  ApiOrderRemoteImpl({required this.dioClient});
  @override
  Future<void> createOrder({required OrderModel order}) async {
    try {
      final res = await dioClient.post(
        "orders/create_order.php",
        data: order.toMap(),
      );

      if (res['success'] == true) {
        return;
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء انشاء الأوردر",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getCartItems error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء انشاء الأوردر",
      );
    }
  }

  @override
  Future<List<OrderModel>> getOrders({required int userId}) async {
    try {
      final res = await dioClient.post(
        "orders/get_orders.php",
        data: {"user_id": userId},
      );

      if (res['success'] == true) {
        final data = res['data'] as List;
        return data.map((e) => OrderModel.fromMap(e)).toList();
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء جلب الطلبات",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("getCartItems error: $e");

      throw ServerException(
        errMessage: "حدث خطأ أثناء جلب الطلبات",
      );
    }
  }
}
