import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/functions/get_time_ago.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final users = PrefsHelper.getUser();
  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController address = TextEditingController();

  final TextEditingController visaCon = TextEditingController();
  final TextEditingController accountCreated = TextEditingController(
    text: getTimeAgo(PrefsHelper.getUser()!.createdAt),
  );
  @override
  void initState() {
    name.text = users?.name ?? '';
    phoneNumber.text = users?.phoneNumber ?? 'لا يوجد';
    email.text = users?.email ?? '';
    address.text = users?.address ?? 'لا يوجد';
    visaCon.text = users?.visa ?? 'لا يوجد';
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    address.dispose();
    visaCon.dispose();
    accountCreated.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
      child: Column(
        children: [
          _buildProfileHeader(),

          const Gap(30),

          _buildSectionTitle("المعلومات الشخصية"),

          const Gap(12),

          _buildPersonalInfoCard(),

          const Gap(28),

          _buildSectionTitle("طريقة الدفع"),

          const Gap(12),

          _buildPaymentCard(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 112,
              height: 112,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  users?.image ?? "",
                ),
                backgroundColor: Color(0xFFF4F6F8),
              ),
            ),

            Positioned(
              bottom: 2,
              right: 2,
              child: Material(
                color: AppColors.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    // TODO: اختيار صورة
                  },
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const Gap(16),

        CustomText(
          text: users?.name ?? '',
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),

        const Gap(6),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomText(
        text: title,
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF202124),
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE8ECEF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoField(
            icon: Icons.person_outline_rounded,
            label: "الاسم الكامل",
            controller: name,
          ),

          const Gap(12),

          _buildInfoField(
            icon: Icons.email_outlined,
            label: "البريد الإلكتروني",
            controller: email,
          ),
          const Gap(12),

          _buildInfoField(
            icon: Icons.phone_outlined,
            label: "رقم الهاتف",
            controller: phoneNumber,
          ),

          const Gap(12),

          _buildInfoField(
            icon: Icons.location_on_outlined,
            label: "عنوان التوصيل",
            controller: address,
          ),
          const Gap(12),

          _buildInfoField(
            icon: Icons.time_to_leave_outlined,
            label: "تاريخ انشاء الحساب",
            controller: accountCreated,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEDF0F2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 21,
            ),
          ),

          const Gap(12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: label,
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),

                const Gap(3),

                TextField(
                  enabled: false,
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF202124),
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE9ECEF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8F9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(
              "assets/payout/visa.png",
              fit: BoxFit.contain,
            ),
          ),

          const Gap(14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: "بطاقة ائتمان",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),

                const Gap(5),

                CustomText(
                  text: users?.visa != null && users!.visa!.length >= 4
                      ? '${users!.visa!.substring(0, 2)}********${users!.visa!.substring(users!.visa!.length - 2)}'
                      : users?.visa ?? '',
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomText(
              text: "الأساسية",
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
