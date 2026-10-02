import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/assets.dart';

class CustomAgainItem extends StatelessWidget {
  // متغير لتحديد نوع الدفع (أونلاين أو كاش) - يمكنك تمريره من قاعدة البيانات
  final bool isOnlinePayment;

  const CustomAgainItem({
    super.key,
    this.isOnlinePayment = true, // افتراضياً أونلاين للتجربة
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // الصف الأول: التاريخ وحالة الطلب
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Oct 3, 2026 • 1:58 AM",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "تم التوصيل",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // الصف الثاني: الصورة، التفاصيل، وطريقة الدفع
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة الوجبة
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    Assets.splashLogo,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),

                // تفاصيل الطلب
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "همبرغر وسلطة",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // شارة الكمية
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "الكمية: 3",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // السعر وطريقة الدفع
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            r"$20.00",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.deepOrange,
                            ),
                          ),
                          // شارة طريقة الدفع تتغير حسب نوع الدفع
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isOnlinePayment
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isOnlinePayment
                                      ? Icons.credit_card
                                      : Icons.payments_outlined,
                                  size: 14,
                                  color: isOnlinePayment
                                      ? Colors.blue
                                      : Colors.orange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isOnlinePayment ? "أونلاين" : "كاش",
                                  style: TextStyle(
                                    color: isOnlinePayment
                                        ? Colors.blue
                                        : Colors.orange,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // خط فاصل
            Divider(color: Colors.grey.shade200, thickness: 1.5),

            const SizedBox(height: 10),

            // الأزرار السفلية (تفاصيل الطلب + اطلب مجدداً)
            Row(
              children: [
                // زر تفاصيل الطلب
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Navigate to Order Details Screen
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Colors.deepOrange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "تفاصيل الطلب",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // مسافة بين الزرين
                // زر اطلب مجدداً
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Handle Order Again
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "اطلب مجدداً",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
