import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionText;
  final IconData? actionIcon;

  const NoDataWidget({
    super.key,
    this.title = "لا توجد بيانات",
    this.subtitle = "القائمة فارغة في الوقت الحالي.",
    this.icon = Icons.folder_open_rounded, // أيقونة افتراضية
    this.onAction,
    this.actionText,
    this.actionIcon = Icons.add_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize:
              MainAxisSize.min, // ليأخذ مساحة المحتوى فقط إذا وضع في ListView
          children: [
            // خلفية دائرية هادئة للأيقونة
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,

                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade100, width: 2),
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppColors.primary,
              ),
            ),
            const Gap(24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Gap(12),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            // عرض الزر فقط إذا تم تمرير دالة الإجراء ونص الزر
            if (onAction != null && actionText != null) ...[
              const Gap(32),
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: onAction,
                  icon: Icon(actionIcon, size: 22),
                  label: Text(
                    actionText!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
