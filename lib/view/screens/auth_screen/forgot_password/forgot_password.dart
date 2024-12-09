
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';


class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(
                      text: AppStrings.serveOut,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      bottom: 40.h,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      text: AppStrings.resetPassword,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      bottom: 20.h,
                    ),
                  ),
                  Container(
                    height: 1.h,
                    width: double.infinity,
                    color: AppColors.black_80,
                  ),
                ],
              ),

              SizedBox(height: 48), // Add spacing if needed

              // Middle section with form fields
              Column(
                children: [
                  CustomFormCard(
                    title: AppStrings.newPassword,
                    hintText: AppStrings.password,
                    hasBackgroundColor: true,
                    isPassword: true,
                    controller: TextEditingController(),
                  ),
                  CustomFormCard(
                    title: AppStrings.confirmPassword,
                    hintText: AppStrings.enterYourPassword,
                    hasBackgroundColor: true,
                    isPassword: true,
                    controller: TextEditingController(),
                  ),
                ],
              ),
              SizedBox(height: 20), // Add spacing if needed

              // Bottom section with button
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.loginScreen);
                },
                title: AppStrings.updatePasswordText,
              ),
            ],
          ),
        ),
      ),
    );

  }
}

