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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

          Column(
            children: [
              Center(
                  child: CustomText(
                    text: AppStrings.alternet,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    bottom: 40.h,
                  )),
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
                color: AppColors.white_50,
              ),
            ],
          ),

          Column(
            children: [
              ///============ Email ============
              CustomFormCard(
                  title: AppStrings.newPassword,
                  hintText: AppStrings.password,
                  hasBackgroundColor: true,
                  isPassword: true,
                  controller: TextEditingController()),
              ///============ Password ============
              CustomFormCard(
                  title: AppStrings.confirmPassword,
                  hintText: AppStrings.enterYourPassword,
                  hasBackgroundColor: true,
                  isPassword: true,
                  controller: TextEditingController()),
            ],
          ),
            ///============ Login Button ============
            CustomButton(onTap: (){
              Get.toNamed(AppRoutes.loginScreen);
            }, title: AppStrings.updatePasswordText,),



          ],
        ),
      ),
    );
  }
}
