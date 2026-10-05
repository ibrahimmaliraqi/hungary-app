import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/secret_keys.dart';
import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/order/data/model/order_model.dart';
import 'package:hungry_app/features/order/data/model/payment_model.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';

abstract class OrderRemote {
  Future<int> createOrder({required OrderModel order});
  Future<List<OrderModel>> getOrders({required int userId});
  Future<String> createPayment({
    required PaymentModel payment,

    required OrderEntity order,
  });
}

class ApiOrderRemoteImpl implements OrderRemote {
  final DioClient dioClient;

  ApiOrderRemoteImpl({required this.dioClient});
  @override
  Future<int> createOrder({required OrderModel order}) async {
    try {
      final res = await dioClient.post(
        "orders/create_order.php",

        data: order.toMap(),
      );

      if (res['success'] == true) {
        return res['order_id'];
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

  @override
  Future<String> createPayment({
    required PaymentModel payment,

    required OrderEntity order,
  }) async {
    try {
      final res = await Dio().post(
        "https://api.swiftpayiq.com/api/v1/payment-links",

        data: {
          "title": payment.name,
          "amount": payment.amount,
          "isReusable": false,
          "customerName": payment.name,
          "customerPhone": payment.phone,
        },
        options: Options(headers: {"Authorization": SecretKeys.SwiftpayiqKey}),
      );
      Map<String, dynamic> resData = res.data;
      final transId = resData["id"];
      final payPageUrl = resData["payPageUrl"];
      print('      final payPageUrl = resData["payPageUrl"];');
      print(payPageUrl);
      final res2 = await dioClient.post(
        "payment/create_payment.php",
        data: {
          "order_id": payment.orderId,
          "amount": payment.amount,
          "name": payment.name,
          "phone": payment.phone,
          "address": payment.address,
          "payment_method": "CARD",
          "payment_link_id": transId,
          "payment_url": payPageUrl,
        },
      );
      if (resData.containsKey("statusCode")) {
        throw ServerException(
          errMessage:
              res2['error'] ?? "حدث خطأ أثناء انشاء دفع الكتروني من ويل",
        );
      }

      if (res2['success'] == true) {
        return res2['data']["payment_url"];
      }

      throw ServerException(
        errMessage: res2['message'] ?? "حدث خطأ أثناء جلب الطلبات",
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
