import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/core/router/app_router.dart';
import 'package:hungry_app/core/widgets/custom_button.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/loading.dart';
import 'package:hungry_app/core/widgets/snack.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:hungry_app/features/auth/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:hungry_app/features/auth/presentation/widgets/profile_text_field.dart';

class UpdateProfileView extends StatefulWidget {
  final UserEntity user;

  const UpdateProfileView({
    super.key,
    required this.user,
  });

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  late TextEditingController nameCon;
  late TextEditingController emailCon;
  late TextEditingController addressCon;
  late TextEditingController phoneCon;
  late TextEditingController visaCon;

  @override
  void initState() {
    super.initState();

    nameCon = TextEditingController(
      text: widget.user.name ?? '',
    );

    emailCon = TextEditingController(
      text: widget.user.email ?? '',
    );

    addressCon = TextEditingController(
      text: widget.user.address ?? '',
    );

    phoneCon = TextEditingController(
      text: widget.user.phoneNumber ?? '',
    );

    visaCon = TextEditingController(
      text: widget.user.visa ?? '',
    );
  }

  @override
  void dispose() {
    nameCon.dispose();
    emailCon.dispose();
    addressCon.dispose();
    phoneCon.dispose();
    visaCon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditProfileCubit(updateUserUsecase: getIt.get<UpdateUserUsecase>()),
      child: Scaffold(
        backgroundColor: Colors.white,

        // ================= APP BAR =================
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const CustomText(
            text: "تعديل البيانات",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
            ),
          ),
        ),

        // ================= BODY =================
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ================= PROFILE IMAGE =================
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // CircleAvatar(
                    //   radius: 60,
                    //   backgroundColor: const Color(0xFFE8F0EB),
                    //   backgroundImage:
                    //       widget.user.image != null &&
                    //           widget.user.image!.isNotEmpty
                    //       ? CachedNetworkImageProvider(
                    //           widget.user.image!,
                    //         )
                    //       : null,
                    //   child:
                    //       widget.user.image == null || widget.user.image!.isEmpty
                    //       ? Icon(
                    //           Icons.person_rounded,
                    //           size: 55,
                    //           color: AppColors.primary,
                    //         )
                    //       : null,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     // TODO: اختيار صورة من المعرض
                    //   },
                    //   borderRadius: BorderRadius.circular(20),
                    //   child: Container(
                    //     padding: const EdgeInsets.all(10),
                    //     decoration: BoxDecoration(
                    //       color: AppColors.primary,
                    //       shape: BoxShape.circle,
                    //       border: Border.all(
                    //         color: Colors.white,
                    //         width: 3,
                    //       ),
                    //     ),
                    //     child: const Icon(
                    //       Icons.edit_rounded,
                    //       color: Colors.white,
                    //       size: 18,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              // const Gap(12),

              // CustomText(
              //   text: "تغيير الصورة الشخصية",
              //   fontSize: 14,
              //   color: AppColors.primary,
              //   fontWeight: FontWeight.w600,
              // ),
              // const Gap(32),

              // ================= INFORMATION CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EB),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFD4E2D9),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان القسم
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        const Gap(8),

                        const CustomText(
                          text: "المعلومات الأساسية",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),

                    const Gap(18),

                    // ================= NAME =================
                    ProfileTextField(
                      label: "الاسم الكامل",
                      controller: nameCon,
                    ),

                    const Gap(16),

                    // ================= EMAIL =================
                    ProfileTextField(
                      label: "البريد الإلكتروني",
                      controller: emailCon,
                    ),

                    const Gap(16),

                    // ================= PHONE =================
                    ProfileTextField(
                      label: "رقم الهاتف",
                      controller: phoneCon,
                    ),

                    const Gap(16),

                    // ================= ADDRESS =================
                    ProfileTextField(
                      label: "عنوان التوصيل",
                      controller: addressCon,
                    ),

                    const Gap(16),

                    // ================= VISA =================
                    ProfileTextField(
                      label: "بطاقة الدفع (Visa)",
                      controller: visaCon,
                    ),
                  ],
                ),
              ),

              const Gap(100),
            ],
          ),
        ),

        // ================= SAVE BUTTON =================
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state is EditProfileSuccess) {
                Snack.show(
                  context,
                  message: "تم تعديل البيانات بنجاح",
                );
                GoRouter.of(context).push(
                  AppRouter.prefileView,
                  extra: state.user,
                );
              }
              if (state is EditProfileFailure) {
                Snack.show(
                  context,
                  message: state.errMessage,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              if (state is EditProfileLoading) {
                return Loading();
              }
              return CustomButton(
                text: "حفظ التغييرات",
                width: double.infinity,
                hight: 54,
                onTap: () {
                  context.read<EditProfileCubit>().editProfileData(
                    user: UserEntity(
                      id: widget.user.id,
                      name: nameCon.text,
                      address: addressCon.text,
                      email: emailCon.text,
                      phoneNumber: phoneCon.text,
                      visa: visaCon.text,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
