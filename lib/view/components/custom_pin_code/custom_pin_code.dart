// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/app_colors/app_colors.dart';

class CustomPinCode extends StatelessWidget {
  const CustomPinCode({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: PinCodeTextField(
        textStyle: TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        appContext: context,
        length: 4,
        enableActiveFill: true,
        animationType: AnimationType.fade,
        animationDuration: Duration(milliseconds: 300),
        controller: controller,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(16),
          fieldHeight: 65,
          fieldWidth: size.width * 0.15,
          inactiveColor: AppColors.black,
          activeColor: AppColors.black,
          activeFillColor: AppColors.black,
          inactiveFillColor: AppColors.black,
          selectedFillColor: AppColors.black,
          disabledColor: AppColors.black,
          selectedColor: AppColors.black,
        ),
      ),
    );
  }
}
