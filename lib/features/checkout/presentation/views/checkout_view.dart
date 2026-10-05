import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/functions/app_price.dart';
import 'package:hungry_app/core/functions/show_cash_bottom_sheet.dart';
import 'package:hungry_app/core/functions/show_success_dialog.dart';
import 'package:hungry_app/core/helper/url_launacher.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/snack.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/order/domain/enums/payment_enum.dart';
import 'package:hungry_app/features/order/presentation/manager/create_order/create_order_cubit.dart';
import 'package:hungry_app/features/order/presentation/manager/create_payment/create_payment_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CheckoutView extends StatefulWidget {
  final List<CartEntity> carts;
  const CheckoutView({super.key, required this.carts});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        title: const CustomText(
          text: "إتمام الطلب", // Checkout
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons
                    .arrow_forward_ios_rounded, // أيقونة السهم متوافقة مع اللغة العربية
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ),
        ),
      ),

      body: BlocConsumer<CreateOrderCubit, CreateOrderState>(
        listener: (context, state) {
          if (state is CreateOrderSuccess) {
            // Snack.show(context, message: "تم إنشاء الطلب بنجاح");
            showSuccessDialog(context);
          }
          if (state is CreateOrderFailure) {
            Snack.show(context, message: state.errMessage, isError: true);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is CreateOrderLoading,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "ملخص الطلب", // Order Summary
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  const Gap(16),

                  // بطاقة الفاتورة (Receipt Card)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _orderMoneyRow(
                          name: "الطلب",
                          price:
                              "${AppPrice.cartTotalPrice(product: widget.carts)} دينار",
                        ),
                        const Gap(12),
                        _orderMoneyRow(name: "الضرائب", price: "لا يوجد"),
                        const Gap(12),
                        _orderMoneyRow(
                          name: "رسوم التوصيل",
                          price: "2000 دينار",
                        ),
                        const Gap(16),

                        // خط متقطع (Dashed Divider)
                        Row(
                          children: List.generate(
                            30,
                            (index) => Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                height: 1.5,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),

                        const Gap(16),
                        _orderMoneyRow(
                          name: "الإجمالي",
                          price:
                              "${AppPrice.cartTotalPrice(product: widget.carts) + 2000} دينار",
                          isBold: true,
                          size: 20,
                        ),

                        const Gap(16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              const Gap(8),
                              CustomText(
                                text: "الوقت المتوقع للتوصيل: ",
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                              CustomText(
                                text: "30 دقيقة - ساعة",
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Gap(32),

                  const CustomText(
                    text: "طرق الدفع", // Payment Methods
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  const Gap(16),

                  // خيار الدفع كاش
                  _buildPaymentCard(
                    title: "الدفع عند الاستلام",
                    subtitle: "ادفع نقداً عند استلام طلبك",
                    value: "Cash",
                    imagePath: "assets/payout/image.png",
                    icon: Icons.payments_rounded,
                  ),

                  const Gap(16),

                  // خيار بطاقة الدفع
                  _buildPaymentCard(
                    title: "بطاقة الدفع",
                    subtitle: "3566 **** **** 0505",
                    value: "debit",
                    imagePath: "assets/payout/visa.png",
                    icon: Icons.credit_card_rounded,
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // شريط الدفع السفلي
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "المجموع الكلي",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                    const Gap(4),
                    CustomText(
                      text:
                          "${AppPrice.cartTotalPrice(product: widget.carts) + 2000} دينار",

                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ],
                ),

                // زر ادفع الآن
                BlocListener<CreatePaymentCubit, CreatePaymentState>(
                  listener: (context, state) async {
                    if (state is CreatePaymentSuccess) {
                      await openLink(link: state.paymentLink);
                    }
                    if (state is CreatePaymentFailure) {
                      Snack.show(
                        context,
                        message: state.errMessage,
                        isError: true,
                      );
                    }
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        if (selectedMethod == "debit") {
                          showPaymentBottomSheet(
                            orderItems: widget.carts,
                            paymentMethod: PaymentMethod.card,
                            totalPrice:
                                AppPrice.cartTotalPrice(product: widget.carts) +
                                2000,

                            context,
                          );
                        } else {
                          showPaymentBottomSheet(
                            orderItems: widget.carts,
                            paymentMethod: PaymentMethod.cash,
                            totalPrice:
                                AppPrice.cartTotalPrice(product: widget.carts) +
                                2000,

                            context,
                          );
                        }
                        print(selectedMethod);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            CustomText(
                              text: "ادفع الآن",
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            Gap(8),
                            Icon(
                              Icons.lock_outline_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  // تصميم بطاقات الدفع
  Widget _buildPaymentCard({
    required String title,
    required String subtitle,
    required String value,
    required String imagePath,
    required IconData icon,
  }) {
    bool isSelected = selectedMethod == value;

    return GestureDetector(
      onTap: () => setState(() => selectedMethod = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(icon, color: Colors.grey.shade700, size: 24),
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  const Gap(4),
                  CustomText(
                    text: subtitle,
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // صف لترتيب تفاصيل الفاتورة
  Widget _orderMoneyRow({
    required String name,
    required String price,
    bool isBold = false,
    double? size,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: name,
          fontSize: size ?? 15,
          color: isBold ? Colors.black : Colors.grey.shade600,
          fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
        ),
        CustomText(
          text: price,
          fontSize: size ?? 15,
          color: isBold ? Colors.black : Colors.black87,
          fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
        ),
      ],
    );
  }

  // نافذة النجاح ثلاثية الأبعاد (Pop-out effect)
}
