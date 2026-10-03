import 'package:hungry_app/features/order/domain/entities/order_entity.dart';

String getOrderState({required OrderEntity order}) {
  switch (order.orderStatus) {
    case "pending":
      return 'تم استلام الطلب';

    case "preparing":
      return 'جاري تحضير الطلب';

    case "outForDelivery":
      return 'الطلب في الطريق';

    case "delivered":
      return 'تم توصيل الطلب';

    case "cancelled":
      return 'تم إلغاء الطلب';
    default:
      return "حدث خطأ";
  }
}

String getPaymentState({required OrderEntity order}) {
  switch (order.paymentStatus) {
    case "paid":
      return 'تم الدفع';
    case "unpaid":
      return 'الدفع عند الاستلام';
    default:
      return "حدث خطأ";
  }
}
