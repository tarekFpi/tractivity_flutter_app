
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class VerificationMailScreen extends StatelessWidget {
  const VerificationMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName:  AppStrings.serveOut,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /*CustomText(
                text: AppStrings.serveOut,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                ),*/
            Column(
              children: [
                CustomText(
                  top: 80.h,
                  text: AppStrings.emailConfirmation,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  bottom: 20.h,
                ),
                CustomText(
                  text: AppStrings.enterYourEmailForVerification,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                  bottom: 32.h,
                  color: AppColors.black,
                ),

                ///============ Email ============
                CustomFormCard(
                    title: AppStrings.email,
                   // hasBackgroundColor: true,
                    titleColor: Colors.black,
                    hintText: AppStrings.enterYourEmail,
                    controller: TextEditingController(),

                ),

                ///============ Login Button ============
                CustomButton(
                  onTap: () {

                   Get.toNamed(AppRoutes.verificationScreen);
                  },
                  title: AppStrings.sendVerificationCode,
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}

