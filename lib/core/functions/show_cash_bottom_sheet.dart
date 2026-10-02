import 'package:flutter/material.dart';

void showCashPaymentBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // مهم جداً لرفع النافذة عند ظهور الكيبورد
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        // MediaQuery.of(context).viewInsets.bottom تمنع الكيبورد من تغطية الحقول
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // لجعل النافذة تأخذ مساحة المحتوى فقط
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان
            const Text(
              "تأكيد الدفع عند الاستلام",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "يرجى إدخال تفاصيل التواصل والموقع لتأكيد طلبك.",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // حقل رقم الهاتف
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "رقم الهاتف",
                prefixIcon: const Icon(
                  Icons.phone_android,
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepOrange,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // حقل الموقع
            TextField(
              decoration: InputDecoration(
                labelText: "الموقع التفصيلي",
                hintText: "مثال: شارع 10، عمارة 5، شقة 2",
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Colors.deepOrange,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepOrange,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // زر التأكيد
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // إغلاق النافذة المنبثقة
                  Navigator.pop(context);

                  // TODO: يمكنك هنا كتابة كود إرسال الطلب لقاعدة البيانات
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("تم تأكيد طلبك بنجاح!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "تأكيد الطلب الآن",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
