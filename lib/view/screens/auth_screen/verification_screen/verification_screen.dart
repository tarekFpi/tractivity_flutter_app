/*
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_pin_code/custom_pin_code.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: AppStrings.serveOut,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                bottom: 20.h),
           Column(
             children: [
               CustomText(
                 top: 80.h,
                 text: AppStrings.enterCode,
                 fontSize: 32,
                 fontWeight: FontWeight.w600,
                 bottom: 20.h,
               ),
               CustomText(
                 text: AppStrings.enterTheCodeTitle,
                 fontSize: 15,
                 fontWeight: FontWeight.w400,
                 maxLines: 2,
                 bottom: 30.h,
                 color: AppColors.white_50,
               ),
               CustomPinCode(controller: TextEditingController()),
               SizedBox(height: 20.h,),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   CustomText(
                     text: AppStrings.ididntFind,
                     fontSize: 14,
                     fontWeight: FontWeight.w400,
                     color: AppColors.black_04,
                     right: 10
                   ),
                   CustomText(
                     text: AppStrings.sendAgain,
                     fontSize: 15,
                     fontWeight: FontWeight.w400,
                     color: AppColors.red,
                   ),
                 ],
               ),
             ],
           ),
            ///============ Login Button ============
            CustomButton(onTap: (){
             // Get.toNamed(AppRoutes.forgotPassword);
            }, title: AppStrings.confirm,),


          ],
        ),
      ),
    );
  }
}
*/
