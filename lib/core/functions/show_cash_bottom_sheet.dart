import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/entities/payment_entity.dart';
import 'package:hungry_app/features/order/domain/enums/payment_enum.dart';
import 'package:hungry_app/features/order/presentation/manager/create_order/create_order_cubit.dart';
import 'package:hungry_app/features/order/presentation/manager/create_payment/create_payment_cubit.dart';

void showPaymentBottomSheet(
  BuildContext context, {
  required PaymentMethod paymentMethod,
  required double totalPrice,
  required List<CartEntity> orderItems,
}) {
  final user = PrefsHelper.getUser()!;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final isCash = paymentMethod == PaymentMethod.cash;

      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 12,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCash
                      ? Icons.local_shipping_outlined
                      : Icons.credit_card_rounded,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                isCash ? "الدفع عند الاستلام" : "الدفع الإلكتروني",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                isCash
                    ? "أدخل تفاصيل التواصل والموقع لتأكيد طلبك."
                    : "أدخل تفاصيل التواصل لإكمال طلبك والدفع إلكترونياً.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              TextField(
                keyboardType: TextInputType.phone,
                controller: TextEditingController(
                  text: user.phoneNumber ?? '',
                ),
                decoration: InputDecoration(
                  labelText: "رقم الهاتف",
                  prefixIcon: Icon(
                    Icons.phone_android_rounded,
                    color: AppColors.primary,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF4F6F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: TextEditingController(
                  text: user.address ?? '',
                ),
                decoration: InputDecoration(
                  labelText: "الموقع التفصيلي",
                  hintText: "مثال: حي المنصور، شارع 14، منزل 5",
                  prefixIcon: Icon(
                    Icons.location_on_rounded,
                    color: AppColors.primary,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF4F6F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (isCash) {
                      const paymentStatus = "UNPAID";
                      const orderStatus = "PENDING";

                      final order = OrderEntity(
                        userId: user.id!,
                        name: user.name!,
                        phone: user.phoneNumber!,
                        address: user.address!,
                        totalPrice: totalPrice,
                        paymentMethod: paymentMethod,
                        paymentStatus: paymentStatus,
                        orderStatus: orderStatus,
                        orderItems: orderItems,
                      );

                      Navigator.pop(context);

                      context.read<CreateOrderCubit>().createOrder(
                        order: order,
                      );
                    } else {
                      final order = OrderEntity(
                        userId: user.id!,
                        name: user.name!,
                        phone: user.phoneNumber!,
                        address: user.address!,
                        totalPrice: totalPrice,
                        paymentMethod: paymentMethod,
                        paymentStatus: "PROCESSING",
                        orderStatus: "PENDING",
                        orderItems: orderItems,
                      );

                      final payment = PaymentEntity(
                        amount: totalPrice,
                        name: user.name!,
                        phone: user.phoneNumber!,
                        address: user.address!,
                      );

                      Navigator.pop(context);

                      context.read<CreatePaymentCubit>().createPayment(
                        payment: payment,
                        order: order,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isCash ? "تأكيد الطلب الآن" : "متابعة الدفع",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
