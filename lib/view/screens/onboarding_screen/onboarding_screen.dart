// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_images/app_images.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.onboarding), fit: BoxFit.fill)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: AppStrings.welcomeToAlterNet,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.loginScreen);
              },
              title: AppStrings.letsGo,
            )
          ],
        ),
      ),
    ));
  }
}
