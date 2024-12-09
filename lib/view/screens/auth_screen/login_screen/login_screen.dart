
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
                child: CustomText(
                    text: AppStrings.serveOut,
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    bottom: 40.h)),

            CustomText(
              text: AppStrings.signin,
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              bottom: 30.h,
            ),
            Container(
              height: 1.h,
              width: double.infinity,
              color: AppColors.grey_2,
            ),
            SizedBox(
              height: 20,
            ),

            ///============ Email ============
            CustomFormCard(
              //  titleColor: Colors.white,
                title: AppStrings.email,
                hintText: AppStrings.enterYourEmail,
                hasBackgroundColor: true,
                controller: TextEditingController()),

            ///============ Password ============
            CustomFormCard(
                titleColor: Colors.black,
                title: AppStrings.password,
                hintText: AppStrings.enterYourPassword,
                hasBackgroundColor: true,
                isPassword: true,
                controller: TextEditingController()),
            ///============ Fortgot Password ============
            GestureDetector(
              onTap: () {
              //  Get.toNamed(AppRoutes.verificationMailScreen);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CustomText(
                  text: AppStrings.forgotPassword,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                  bottom: 30.h,
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            ///============ Login Button ============
            CustomButton(onTap: (){
              Get.toNamed(AppRoutes.homeScreen);
            }, title: AppStrings.logIn,),
            SizedBox(height: 30.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 1.h,
                  width: 110.w,
                  color: AppColors.grey_2,
                ),
                CustomText(
                  text: AppStrings.orSignInWith,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  left: 5.w,
                  right: 5.w,
                ),
                Container(
                  height: 1.h,
                  width: 110.w,
                  color: AppColors.grey_2,
                ),
              ],
            ),
            SizedBox(height: 30.h,),
            ///============ Social Login ============
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(imageSrc: AppIcons.setting, height: 50,width: 50,),
                SizedBox(width: 30.w,),
                CustomImage(imageSrc: AppIcons.setting, height: 50,width: 50,),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: AppStrings.dontHaveAccount,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                SizedBox(width: 10.w),

                GestureDetector(
                  onTap: (){
                  },
                  child: CustomText(
                    text: AppStrings.singUpText,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
*/
