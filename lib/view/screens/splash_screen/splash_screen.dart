// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import '../../../utils/app_images/app_images.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  //final AuthController authController =Get.find<AuthController>();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
       Get.offAllNamed(AppRoutes.onboardingScreen);
      });
    });
  }

  void configLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..backgroundColor = AppColors.brinkPink
      ..indicatorColor = AppColors.brinkPink
      ..textColor = AppColors.brinkPink
      ..maskColor = Colors.white.withOpacity(0.8);
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
           /// Center(child: CustomImage(imageSrc: AppImages.splashImage))

             Center(child: Image.asset(AppImages.splashImage))
          ],
        ),
      ),
    );
  }
}
