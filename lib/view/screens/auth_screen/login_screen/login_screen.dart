
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool valuefirst = false;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;


          // Check if the available width is wide enough for a tablet layout
          /*   if (constraints.maxWidth > 600) {
                return _buildTabletLayout();
              } else {
                return _buildPhoneLayout();
              }
              */

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 40 : 20, // Adjust padding for tablet
                vertical: isTablet ? 80 : 60,  // Adjust vertical padding for tablet
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: CustomText(
                      text: AppStrings.serveOut,
                      fontSize: isTablet ? 36 : 32, // Adjust font size for tablet
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      bottom: 40.h,
                    ),
                  ),

                  CustomText(
                    text: AppStrings.signin,
                    fontSize: isTablet ? 28 : 24, // Adjust font size for tablet
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    bottom: 30.h,
                  ),
                  Container(
                    height: 1.h,
                    width: double.infinity,
                    color: AppColors.grey_2,
                  ),
                  const SizedBox(height: 20),

                  /// Email Field
                  CustomFormCard(
                    title: AppStrings.email,
                    hintText: AppStrings.enterYourEmail,
                    fontSize: isTablet?16:16,
                    hasBackgroundColor: true,
                    controller: TextEditingController(),
                  ),

                  /// Password Field
                  CustomFormCard(
                    titleColor: Colors.black,
                    title: AppStrings.password,
                    hintText: AppStrings.enterYourPassword,
                    fontSize: isTablet?16:16,
                    hasBackgroundColor: true,
                    isPassword: true,
                    controller: TextEditingController(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Remember Me Checkbox
                      Row(
                        children: [

                          Checkbox(
                            value: valuefirst,
                            checkColor: Colors.yellow,
                            activeColor: Colors.grey,
                            onChanged: (bool? newValue) {
                              setState(() {
                                valuefirst = newValue!;
                              });
                            },
                          ),
                          CustomText(
                            text: "Remember me",
                            fontSize: isTablet ? 14 : 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                          ),
                        ],
                      ),

                      /// Forgot Password
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.verificationMailScreen);
                        },
                        child: CustomText(
                          text: AppStrings.forgotPassword,
                          fontSize: isTablet ? 14 : 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isTablet ? 30.h : 20.h),

                  /// Login Button
                  CustomButton(
                    height: isTablet?70:60,
                    onTap: () {
                      Get.toNamed(AppRoutes.homeScreen);
                    },
                    title: AppStrings.logIn,
                    fontSize: isTablet ? 16 : 14,
                  ),

                  SizedBox(height: isTablet ? 40.h : 30.h),

                  /// Divider with Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.h,
                          width: isTablet ? 150.w : 110.w,
                          color: AppColors.grey_2,
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          text: AppStrings.orSignInWith,
                          fontSize: isTablet ? 16 : 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.h,
                          width: isTablet ? 150.w : 110.w,
                          color: AppColors.grey_2,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isTablet ? 40.h : 30.h),

                  /// Social Login Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImage(imageSrc: AppIcons.apple, height: 32, width: 32),
                      SizedBox(width: isTablet ? 48.w : 32.w),
                      CustomImage(imageSrc: AppIcons.google, height: 32, width: 32),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Sign-Up Prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: AppStrings.dontHaveAccount,
                        fontSize: isTablet ? 16 : 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      SizedBox(width: isTablet ? 12.w : 10.w),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.signupScreen);
                        },
                        child: CustomText(
                          text: AppStrings.singUpText,
                          fontSize: isTablet ? 16 : 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

