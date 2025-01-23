
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';

import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/auth_screen/controller/auth_controller.dart';

class VerificationMailScreen extends StatelessWidget {
    VerificationMailScreen({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        ///appBar: CustomRoyelAppbar(titleName:  AppStrings.serveOut,),
        appBar: AppBar(
          title: Text(
            AppStrings.serveOut,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600),
          ),

        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                      bottom: 32.h,
                      color: AppColors.black,
                    ),

                    ///============ Email ============ forgetEmailController
                    CustomFormCard(
                      title: AppStrings.email,
                      // hasBackgroundColor: true,
                      titleColor: Colors.black,
                      fontSize: isTablet?16:16,
                      hintText: AppStrings.enterYourEmail,
                      controller:authController.forgetEmailController.value,

                    ),

                    SizedBox(
                      height: 12,
                    ),

                    ///============ Login Button ============
                  authController.forgetPasswordLoading.value?CircularProgressIndicator(color: AppColors.primary,):  CustomButton(
                      onTap: () {

                        if(authController.forgetEmailController.value.text==""){

                          Toast.errorToast("Your email is Empty!!..");

                        }else{

                         authController.forgetPassword();
                        }


                      },
                      title: AppStrings.sendVerificationCode,
                      height: isTablet?60.h:60.h,
                      fontSize: isTablet ? 10.sp : 14.sp,
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      );
    });
  }
}

