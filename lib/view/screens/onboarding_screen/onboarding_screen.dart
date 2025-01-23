
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600; // Detect if it's a tablet

          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.onboarding),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 60 : 20, // Adjust padding for tablets
                vertical: isTablet ? 120 : 80,  // More space for tablets
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// **Welcome Text Section**
                  Column(
                    children: [
                      CustomText(
                        text: AppStrings.welcomeToAlterNet,
                        fontSize: isTablet ? 42 : 48, // Bigger text for tablets
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isTablet ? 30 : 10), // More spacing for tablets
                      CustomText(
                        text: AppStrings.joinUpAlterNet,
                        fontSize: isTablet ? 40 : 32,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  /// **Let's Go Button**
                  CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    title: AppStrings.letsGo,
                    fontSize: isTablet ? 20 : 16, // Bigger button text for tablets
                    width: double.infinity,
                    height: isTablet?70:60, // Wider button on tablets
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

/*

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

/// CustomImage(imageSrc: AppImages.onboarding), joinUpAlterNet

Column(
children: [

CustomText(
text: AppStrings.welcomeToAlterNet,
fontSize: 48,
fontWeight: FontWeight.w700,
color: AppColors.white,
),

CustomText(
text: AppStrings.joinUpAlterNet,
fontSize: 32,
fontWeight: FontWeight.w600,
color: AppColors.white,
),

],
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

*/


