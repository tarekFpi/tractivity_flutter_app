// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.red,
    );
  }
}
