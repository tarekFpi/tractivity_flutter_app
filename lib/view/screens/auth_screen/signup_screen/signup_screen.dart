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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool valuefirst = false;

  String checkValueStatues = "";

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
              SizedBox(
                height: 30.h,
              ),

              ///====================== profile image===================

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
                height: 12.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      CustomText(
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

              ///============ First Name ============
              CustomFormCard(
                  title: AppStrings.yourFirstName,
                  hintText: AppStrings.enterYourName,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ Last Name ============
              CustomFormCard(
                  title: AppStrings.profession,
                  hintText: AppStrings.enterYourName,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    //  tristate: true,  // Example with tristate
                    value: valuefirst,
                    checkColor: Colors.yellow,
                    activeColor: Colors.grey,
                    onChanged: (bool? newValue) {
                      setState(() {
                        valuefirst = newValue!;
                      });
                    },
                  ),
                  Text.rich(
                    TextSpan(
                        text: 'I agree with ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: 'terms',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.orange),
                          ),
                          TextSpan(
                            text: ' of service and',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: ' privacy policy',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.orange),
                          ),
                        ]),
                  ),
                ],
              ),

              SizedBox(
                height: 8,
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
