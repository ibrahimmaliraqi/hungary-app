import 'dart:io';

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
import 'package:hungry_app/features/auth/data/manager/get_profile/get_profile_data_cubit.dart';
import 'package:hungry_app/features/auth/presentation/widgets/profile_text_field.dart';
import 'package:hungry_app/root_view.dart';
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
  @override
  void initState() {
    BlocProvider.of<GetProfileDataCubit>(context).getProfileData();

    super.initState();
  }

  String? userImage;
  String? visa;
  String? selectedImage;
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      selectedImage = pickedImage!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    name.text = "NO NAME";
    email.text = " NO EMAIL";
    address.text = "NO ADDRESS";
    return BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
      builder: (context, state) {
        if (state is GetProfileDataFailure) {
          Snack.show(context, message: state.errMessage);
        }
        if (state is GetProfileDataSuccess) {
          name.text = state.user?.data?.name ?? "";
          email.text = state.user?.data?.email ?? "";
          address.text = state.user?.data?.address ?? "ADD YOUR ADDRESS";
          userImage = state.user!.data!.image!;
          visa = state.user?.data?.visa;
        }
        return RefreshIndicator(
          onRefresh: () =>
              BlocProvider.of<GetProfileDataCubit>(context).getProfileData(),
          child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              forceMaterialTransparency: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ],

              backgroundColor: Colors.white,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RootView(),
                  ),
                  (route) => false,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),

            backgroundColor: AppColors.primary,

            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Skeletonizer(
                  enabled: state is GetProfileDataLoading ? true : false,

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(selectedImage ?? '')),
                            ),
                          ),
                        ),
                        Gap(10),

                        CustomButton(
                          text: "Upload",
                          width: 100,
                          hight: 30,
                          color: Colors.white,
                          textColor: AppColors.primary,
                          onTap: pickImage,
                        ),
                        Gap(30),
                        ProfileTextField(label: "Name", controller: name),
                        Gap(25),
                        ProfileTextField(label: "Email", controller: email),
                        Gap(25),
                        ProfileTextField(
                          label: "Delivery address",
                          controller: address,
                        ),
                        Gap(10),
                        Divider(),
                        Gap(10),
                        visa == null
                            ? ProfileTextField(
                                label: "ADD VISA CARD",
                                type: TextInputType.number,
                                controller: visaCon,
                              )
                            : ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                tileColor: Colors.white,
                                title: CustomText(
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
                                trailing: CustomText(
                                  text: "Default",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                        Gap(100),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            bottomSheet: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Edit Profile",
                          color: AppColors.primary,
                        ),
                        Gap(10),
                        SvgPicture.asset(
                          "assets/logo/edit.svg",
                          height: 20,
                          width: 20,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),

                  Spacer(),
                  GestureDetector(
                    onTap: () =>
                        GoRouter.of(context).pushReplacement(AppRouter.login),
                    child: Container(
                      padding: EdgeInsets.symmetric(
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
                        children: [
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
