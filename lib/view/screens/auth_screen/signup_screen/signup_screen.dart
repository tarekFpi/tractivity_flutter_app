/*
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_dropdown/custom_royel_dropdown.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 80, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.singUpText,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                bottom: 15.h,
              ),
              Container(
                height: 1.h,
                width: MediaQuery.sizeOf(context).width,
                color: AppColors.white_50,
              ),
              SizedBox(height: 30.h,),
              /// profile image======
              Center(
                child: Stack(
                  children: [
                    // profileController.profileImage.value == null
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height: 120.h,
                      width: 120.w,
                      boxShape: BoxShape.circle,
                    ),
                    */
/*   Container(
                      height: 120.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                              ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),*//*

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
                          decoration: BoxDecoration(
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
                height: 20.h,
              ),

              ///============ First Name ============
              CustomFormCard(
                  title: AppStrings.yourFirstName,
                  hintText: AppStrings.enterYourName,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ Last Name ============
              CustomFormCard(
                  title: AppStrings.yourLastName,
                  hintText: AppStrings.enterYourName,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ User Name ============
              CustomFormCard(
                  title: AppStrings.userName,
                  hintText: AppStrings.enterYourName,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ phoneNumber ============
              CustomFormCard(
                  title: AppStrings.phoneNumber,
                  hintText: AppStrings.enterYourPhone,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ phoneNumber ============
              CustomFormCard(
                  title: AppStrings.email,
                  hintText: AppStrings.enterYourEmail,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ Date of Birth ============
              CustomFormCard(
                  title: AppStrings.dateOfBirth,
                  hintText: AppStrings.typeYourDate,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ Gender ============
              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: AppStrings.gender,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  bottom: 10.h,
                ),
              ),
              CustomRoyelDropdown(
                fillColor: AppColors.black_80,
                textColor: AppColors.white,
                title: AppStrings.gender,
              ),
              SizedBox(
                height: 15.h,
              ),
              ///============ password ============
              CustomFormCard(
                  title: AppStrings.password,
                  hintText: AppStrings.enterYourPassword,
                  hasBackgroundColor: true,
                  isPassword: true,
                  controller: TextEditingController()),

              ///============ confirmPassword ============
              CustomFormCard(
                  title: AppStrings.confirmPassword,
                  hintText: AppStrings.enterYourPassword,
                  hasBackgroundColor: true,
                  isPassword: true,
                  controller: TextEditingController()),

              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.loginScreen);
                },
                title: AppStrings.singUpText,
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
