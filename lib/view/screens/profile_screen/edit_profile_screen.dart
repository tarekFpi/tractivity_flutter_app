
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class EditPersonProfileScreen extends StatefulWidget {
  const EditPersonProfileScreen({super.key});

  @override
  State<EditPersonProfileScreen> createState() => _EditPersonProfileScreenState();
}

class _EditPersonProfileScreenState extends State<EditPersonProfileScreen> {

  bool valuefirst = false;

  String checkValueStatues = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRoyelAppbar(
        titleName: "Edit Profile",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///====================== profile image===================

              Center(
                child: Stack(
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height: 120.h,
                      width: 120.w,
                      boxShape: BoxShape.circle,
                    ),

                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // profileController.getFileImage();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// =====Profile Name List =========
              SizedBox(
                height: 12.h,
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: "Volunteer",
                          fillColor:
                          MaterialStateColor.resolveWith((states) => AppColors.primary),
                          groupValue: checkValueStatues,
                          onChanged: (String? value) {
                            setState(() {
                              checkValueStatues = value!;
                            });
                          },
                        ),
                        const CustomText(
                          text: "Volunteer",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: "Organizer",
                          groupValue: checkValueStatues,
                          fillColor:
                          MaterialStateColor.resolveWith((states) => AppColors.primary),
                          onChanged: (value) {
                            setState(() {
                              checkValueStatues = value!;
                            });
                          },
                        ),
                        CustomText(
                          text: "Organizer",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Radio(
                          value: "Administrator",
                          groupValue: checkValueStatues,
                          fillColor:
                          MaterialStateColor.resolveWith((states) => AppColors.primary),
                          onChanged: (value) {
                            setState(() {
                              checkValueStatues = value!;
                            });
                          },
                        ),

                        CustomText(
                          text: "Administrator",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 12.h,
              ),
              ///============ First Name ============
              CustomFormCard(
                  title: AppStrings.yourFirstName,
                  hintText: AppStrings.enterYourName,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ Last Name ============
              CustomFormCard(
                  title: "Talent/Skill",
                  hintText: "Enter Talent/Skill",
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ phoneNumber ============
              CustomFormCard(
                  title: AppStrings.phoneNumber,
                  hintText: AppStrings.enterYourPhone,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ email ============
              CustomFormCard(
                  title: AppStrings.email,
                  hintText: AppStrings.enterYourEmail,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ Location ============
              CustomFormCard(
                  title: AppStrings.location,
                  hintText: AppStrings.enterYourLocation,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),


              CustomButton(
                onTap: () {
                //  Get.toNamed(AppRoutes.loginScreen);
                },
                title: "SAVE SETTINGS",
              )
            ],
          ),
        ),
      ),
    );
  }
}
