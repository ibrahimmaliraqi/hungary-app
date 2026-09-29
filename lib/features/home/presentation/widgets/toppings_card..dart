import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/net_image.dart';

class ToppingsCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onAdd;

  const ToppingsCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7),
      width: 125, // العرض المتناسق مع الصورة
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // حواف دائرية ناعمة جداً
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      // استخدمنا ClipRRect لضمان عدم خروج الجزء البني عن حدود البطاقة الدائرية
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 1. الصورة
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              bottom: 70, // ترك مساحة كافية للجزء السفلي
              child: NetImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),

            // 2. الجزء البني ذو الانحناء
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 75,
              child: ClipPath(
                clipper: _BottomCurveClipper(), // كلاس الانحناء المخصص
                child: Container(
                  color: AppColors.options, // درجة اللون البني المطابقة للتصميم
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 12,
                    top: 22, // إزاحة للأسفل لتفادي منطقة الانحناء
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // النص
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600, // خط عريض قليلاً
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      // زر الإضافة المربع بحواف دائرية
                      InkWell(
                        onTap: onAdd,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFE53935,
                            ), // اللون الأحمر المطابق
                            borderRadius: BorderRadius.circular(8), // حواف الزر
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// كلاس مخصص لرسم الانحناء المطابق للصورة (شكل الابتسامة)
class _BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    // رسم الانحناء (النزول بمقدار 22 بكسل في المنتصف)
    path.quadraticBezierTo(size.width / 2, 22, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
