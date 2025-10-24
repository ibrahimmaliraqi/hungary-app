import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/shared/custom_button.dart';
import 'package:hungry_app/core/shared/custom_text.dart';
import 'package:hungry_app/core/shared/snack.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/features/auth/data/manager/edit_profile/edit_profile_cubit.dart';
import 'package:hungry_app/features/auth/data/manager/get_profile/get_profile_data_cubit.dart';
import 'package:hungry_app/features/auth/presentation/widgets/profile_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController visaCon = TextEditingController();

  String? userImage;
  String? visa;
  String? selectedImage;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetProfileDataCubit>(context).getProfileData();

    name.text = "NO NAME";
    email.text = "NO EMAIL";
    address.text = "NO ADDRESS";
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
      builder: (context, state) {
        if (state is GetProfileDataFailure) {
          Snack.show(context, message: state.errMessage);
        }

        if (state is GetProfileDataSuccess) {
          name.text = state.user?.data?.name ?? "";
          email.text = state.user?.data?.email ?? "";
          address.text = state.user?.data?.address ?? "ADD YOUR ADDRESS";
          userImage = state.user?.data?.image;
          visa = state.user?.data?.visa;
        }

        return RefreshIndicator(
          onRefresh: () =>
              BlocProvider.of<GetProfileDataCubit>(context).getProfileData(),
          child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              forceMaterialTransparency: true,
              backgroundColor: Colors.white,
              elevation: 0,

              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.settings, color: Colors.black),
                ),
              ],
            ),
            backgroundColor: AppColors.primary,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Skeletonizer(
                  enabled: state is GetProfileDataLoading,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // صورة البروفايل
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: selectedImage != null
                                  ? FileImage(File(selectedImage!))
                                  : (userImage != null && userImage!.isNotEmpty)
                                  ? NetworkImage(userImage!)
                                  : const NetworkImage(
                                          "https://via.placeholder.com/150",
                                        )
                                        as ImageProvider,
                            ),
                          ),
                        ),
                        const Gap(10),

                        CustomButton(
                          text: "Upload",
                          width: 100,
                          hight: 30,
                          color: Colors.white,
                          textColor: AppColors.primary,
                          onTap: pickImage,
                        ),
                        const Gap(30),

                        ProfileTextField(label: "Name", controller: name),
                        const Gap(25),
                        ProfileTextField(label: "Email", controller: email),
                        const Gap(25),
                        ProfileTextField(
                          label: "Delivery address",
                          controller: address,
                        ),
                        const Gap(10),
                        const Divider(),
                        const Gap(10),

                        (visa == null || visa!.isEmpty)
                            ? ProfileTextField(
                                label: "ADD VISA CARD",
                                type: TextInputType.number,
                                controller: visaCon,
                              )
                            : ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                tileColor: Colors.white,
                                title: const CustomText(
                                  text: "Debit card",
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                subtitle: CustomText(
                                  text: visa!,
                                  fontSize: 13,
                                ),
                                leading: Image.asset(
                                  "assets/payout/visa.png",
                                  width: 50,
                                ),
                                trailing: const CustomText(
                                  text: "Default",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                        const Gap(100),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // زر التعديل وتسجيل الخروج
            bottomSheet: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 70,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () async {
                          if (selectedImage == null) {
                            Snack.show(
                              context,
                              message: "Please choose an image first",
                            );
                            return;
                          }
                          await BlocProvider.of<EditProfileCubit>(
                            context,
                          ).editProfileData(
                            name: name.text,
                            email: email.text,
                            imagePath: selectedImage!,
                            address: address.text,
                            visa: visaCon.text,
                          );
                          await BlocProvider.of<GetProfileDataCubit>(
                            context,
                          ).getProfileData();
                        },
                        child: state is EditProfileLoading
                            ? const Center(
                                child: CupertinoActivityIndicator(
                                  color: AppColors.primary,
                                  radius: 19,
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: "Edit Profile",
                                      color: AppColors.primary,
                                    ),
                                    const Gap(10),
                                    SvgPicture.asset(
                                      "assets/logo/edit.svg",
                                      height: 20,
                                      width: 20,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                      );
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () =>
                        GoRouter.of(context).pushReplacement(AppRouter.login),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 23,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: const [
                          CustomText(
                            text: "Log out",
                            color: Colors.white,
                          ),
                          Gap(10),
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
