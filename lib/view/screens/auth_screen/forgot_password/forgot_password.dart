
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
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/auth_screen/controller/auth_controller.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String? email;

  final authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["email"]!=null){

      email = Get.arguments[0]["email"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: SingleChildScrollView(
            child: Obx(
               () {
                return Column(
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
                          fontSize: isTablet?16:16,
                          title: AppStrings.newPassword,
                          hintText: AppStrings.password,
                          hasBackgroundColor: true,
                          isPassword: true,
                          controller: authController.resetNewPasswordController.value,
                        ),
                        CustomFormCard(
                          fontSize: isTablet?16:16,
                          title: AppStrings.confirmPassword,
                          hintText: AppStrings.enterYourPassword,
                          hasBackgroundColor: true,
                          isPassword: true,
                          controller: authController.resetConfirmPasswordController.value,
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Add spacing if needed

                    ///Bottom section with button
                   authController.resetPasswordLoading.value?CustomLoader(): CustomButton(
                      onTap: () {

                      if(authController.resetNewPasswordController.value.text==""){

                        Toast.errorToast("New password is Empty..!!");

                      }else if(authController.resetConfirmPasswordController.value.text==""){

                        Toast.errorToast("Confirm password is Empty..!!");

                      }else if(authController.resetNewPasswordController.value.text!=authController.resetConfirmPasswordController.value.text){

                        Toast.errorToast("Password & Confirm Password do not match!");
                      }else{

                        authController.restPassword(email.toString());
                      }

                      },
                      title: AppStrings.updatePasswordText,
                      height: isTablet?60.h:60.h,
                      fontSize: isTablet ? 10.sp : 14.sp,
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      );
    });

  }
}

