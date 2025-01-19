// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_dropdown/custom_royel_dropdown.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/auth_screen/controller/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final authController = Get.put(AuthController());


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void singUpValidator(){

    if (formKey.currentState!.validate()) {

     ///authController.login(phone, pin);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 40 : 15, // Adjust padding dynamically
                  vertical: isTablet ? 100 : 80, // Adjust top padding for tablet
                ),
                child: Obx(
                      () {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title
                        CustomText(
                          text: AppStrings.singUpText,
                          fontSize: isTablet ? 28 : 24,
                          fontWeight: FontWeight.w600,
                          bottom: 15.h,
                        ),
                        Container(
                          height: 1.h,
                          width: MediaQuery.sizeOf(context).width,
                          color: AppColors.white_50,
                        ),
                        SizedBox(height: 30.h),

                        /// Profile Image
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 120.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.primary,
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(File(authController.chooseUserImage.value)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: isTablet? -80:0,
                                 left: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    authController.chooseUserPhoto();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// Profile Role Selection (Radio Buttons)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: AppStrings.volunteer,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColors.primary),
                                    groupValue: authController.checkValueStatues.value,
                                    onChanged: (String? value) {
                                      authController.checkValueStatues.value = value!;
                                    },
                                  ),
                                  CustomText(
                                    text: AppStrings.volunteer,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: AppStrings.organizer,
                                    groupValue: authController.checkValueStatues.value,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColors.primary),
                                    onChanged: (value) {
                                      authController.checkValueStatues.value = value!;
                                    },
                                  ),
                                  CustomText(
                                    text: AppStrings.organizer,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: AppStrings.administrator,
                                    groupValue: authController.checkValueStatues.value,
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => AppColors.primary),
                                    onChanged: (value) {
                                      authController.checkValueStatues.value = value!;
                                    },
                                  ),
                                  CustomText(
                                    text: AppStrings.administrator,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 12.h),

                        /// Form Fields
                        ///============ Last Name ============
                        CustomFormCard(
                          title: AppStrings.yourName,
                          hintText: AppStrings.enterYourName,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: authController.fullNameController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),

                        ///============ Talent/skill ============
                        CustomFormCard(
                          title: AppStrings.talentSkill,
                          hintText: AppStrings.enterSkill,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: authController.talentSkillController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),

                        ///============ phoneNumber ============
                        CustomFormCard(
                          title: AppStrings.phoneNumber,
                          hintText: AppStrings.enterYourPhone,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: authController.phoneNumberController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),

                        ///============ email ============
                        CustomFormCard(
                          title: AppStrings.email,
                          hintText: AppStrings.enterYourEmail,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: authController.emailController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),

                        ///============ Location ============
                        CustomFormCard(
                          title: AppStrings.location,
                          hintText: AppStrings.enterYourLocation,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: authController.locationController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),

                        ///============ password ============
                        CustomFormCard(
                          title: AppStrings.password,
                          hintText: AppStrings.enterYourPassword,
                          hasBackgroundColor: true,
                          fontSize: isTablet?16:16,
                          isPassword: true,
                          controller: authController.passwordController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),

                        ///============ confirmPassword ============
                        CustomFormCard(
                          title: AppStrings.confirmPassword,
                          hintText: AppStrings.enterYourPassword,
                          hasBackgroundColor: true,
                          fontSize: isTablet?16:16,
                          isPassword: true,
                          controller: authController.confirmPasswordController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),

                        /// Terms and Conditions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: authController.agreeStatue.value,
                              checkColor: Colors.yellow,
                              activeColor: Colors.grey,
                              onChanged: (bool? newValue) {
                                authController.agreeStatue.value = newValue!;
                              },
                            ),
                            Flexible(
                              child: Text.rich(
                                TextSpan(
                                  text: 'I agree with ',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                  children: [
                                    TextSpan(
                                      text: 'terms',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.orange),
                                    ),
                                    TextSpan(
                                      text: ' of service and ',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: 'privacy policy',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        /// Sign Up Button

                        CustomButton(
                          height: isTablet?70:60,
                          onTap: () {
                            singUpValidator();
                          },
                          title: AppStrings.singUpText,
                          fontSize: isTablet ? 16 : 14,
                        ),

                        SizedBox(height: 16),

                        /// Navigate to Login
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.loginScreen);
                            },
                            child: Text.rich(
                              TextSpan(
                                text: 'Have an account?',
                                style: TextStyle(fontSize: isTablet?16:14, fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: ' SIGN IN!',
                                    style: TextStyle(fontSize: isTablet?16: 14, fontWeight: FontWeight.w500, color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}


/*
SingleChildScrollView(
child: Form(
key: formKey,
child: Padding(
padding:
const EdgeInsets.only(left: 15, right: 15, top: 80, bottom: 50),
child: Obx(
() {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
CustomText(
text: AppStrings.singUpText,
fontSize: 24,
fontWeight: FontWeight.w600,
bottom: 15.h,
),
Container(
height: 1.h,
width: MediaQuery.sizeOf(context).width,
color: AppColors.white_50,
),
SizedBox(
height: 30.h,
),

///====================== profile image===================

Center(
child: Stack(
children: [
// profileController.profileImage.value == null
*//* CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 120.h,
                            width: 120.w,
                            boxShape: BoxShape.circle,
                          ),*//*

Container(
height: 120.h,
width: 120.w,
decoration: BoxDecoration(
shape: BoxShape.circle, // Set to circle
color: Colors.grey,
border: Border.all(
width: 1,
color: AppColors.primary,
),
image: DecorationImage(
image: FileImage(File(authController.chooseUserImage.value)),
fit: BoxFit.cover,
),
),
),

Positioned(
bottom: 5,
right: 0,
child: GestureDetector(
onTap: () {
authController.chooseUserPhoto();
},
child: Container(
height: 30,
width: 30,
decoration: BoxDecoration(
color: AppColors.primary,
shape: BoxShape.circle,
),
child: const Icon(
Icons.camera_alt,
size: 18,
color: AppColors.white,
),
),
),
),
],
),
),

/// =====Profile Name List =========
SizedBox(
height: 12.h,
),

SingleChildScrollView(
scrollDirection: Axis.horizontal,
child: Row(
children: [

Row(
mainAxisAlignment: MainAxisAlignment.start,
children: [
Radio(
value: AppStrings.volunteer,
fillColor:
MaterialStateColor.resolveWith((states) => AppColors.primary),
groupValue:authController.checkValueStatues.value,
onChanged: (String? value) {

authController.checkValueStatues.value = value!;

},
),
CustomText(
text:AppStrings.volunteer,
fontSize: 12,
fontWeight: FontWeight.w400,
),
],
),

Row(
mainAxisAlignment: MainAxisAlignment.start,
children: [
Radio(
value: AppStrings.organizer,
groupValue: authController.checkValueStatues.value,
fillColor:
MaterialStateColor.resolveWith((states) => AppColors.primary),
onChanged: (value) {

authController.checkValueStatues.value =value!;
},
),
CustomText(
text: AppStrings.organizer,
fontSize: 12,
fontWeight: FontWeight.w400,
),
],
),

Row(
mainAxisAlignment: MainAxisAlignment.start,
children: [

Radio(
value: AppStrings.administrator,
groupValue:  authController.checkValueStatues.value,
fillColor:
MaterialStateColor.resolveWith((states) => AppColors.primary),
onChanged: (value) {

authController.checkValueStatues.value = value!;

},
),

CustomText(
text: AppStrings.administrator,
fontSize: 12,
fontWeight: FontWeight.w400,
),
],
),
],
),
),

SizedBox(
height: 12.h,
),

///============ Last Name ============
CustomFormCard(
title: AppStrings.yourName,
hintText: AppStrings.enterYourName,
hasBackgroundColor: true,
controller: authController.fullNameController.value,
validator: (value) {
if (value == null || value.isEmpty) {
return AppStrings.fieldCantBeEmpty;
}
return null;
},
),

///============ Talent/skill ============
CustomFormCard(
title:AppStrings.talentSkill,
hintText: AppStrings.enterSkill,
hasBackgroundColor: true,
controller: authController.talentSkillController.value,
validator: (value) {
if (value == null || value.isEmpty) {
return AppStrings.fieldCantBeEmpty;
}
return null;
},
),



///============ phoneNumber ============
CustomFormCard(
title: AppStrings.phoneNumber,
hintText: AppStrings.enterYourPhone,
hasBackgroundColor: true,
controller: authController.phoneNumberController.value,
validator: (value) {
if (value == null || value.isEmpty) {
return AppStrings.fieldCantBeEmpty;
}
return null;
},
),

///============ email ============
CustomFormCard(
title: AppStrings.email,
hintText: AppStrings.enterYourEmail,
hasBackgroundColor: true,
controller: authController.emailController.value,
validator: (value) {
if (value == null || value.isEmpty) {
return AppStrings.fieldCantBeEmpty;
}
return null;
},
),

///============ Location ============
CustomFormCard(
title: AppStrings.location,
hintText: AppStrings.enterYourLocation,
hasBackgroundColor: true,
controller: authController.locationController.value,
validator: (value) {
if (value == null || value.isEmpty) {
return AppStrings.fieldCantBeEmpty;
}
return null;
},
),

///============ password ============
CustomFormCard(
title: AppStrings.password,
hintText: AppStrings.enterYourPassword,
hasBackgroundColor: true,
isPassword: true,
controller: authController.passwordController.value,
validator: (value) {
if (value == null || value.isEmpty) {
return AppStrings.fieldCantBeEmpty;
}
return null;
},
),

///============ confirmPassword ============
CustomFormCard(
title: AppStrings.confirmPassword,
hintText: AppStrings.enterYourPassword,
hasBackgroundColor: true,
isPassword: true,
controller: authController.confirmPasswordController.value,
validator: (value) {
if (value == null || value.isEmpty) {
return AppStrings.fieldCantBeEmpty;
}
return null;
},
),

Row(
mainAxisAlignment: MainAxisAlignment.start,
children: [
Checkbox(
value:authController.agreeStatue.value,
checkColor: Colors.yellow,
activeColor: Colors.grey,
onChanged: (bool? newValue) {

authController.agreeStatue.value = newValue!;

},
),
Flexible(
child: Text.rich(
TextSpan(
text: 'I agree with ',
style: TextStyle(
fontSize: 14, fontWeight: FontWeight.w400),
children: [
TextSpan(
text: 'terms',
style: TextStyle(
fontSize: 14,
fontWeight: FontWeight.w400,
color: Colors.orange),
),
TextSpan(
text: ' of service and',
style: TextStyle(
fontSize: 14, fontWeight: FontWeight.w400),
),
TextSpan(
text: ' privacy policy',
style: TextStyle(
fontSize: 14,
fontWeight: FontWeight.w400,
color: Colors.orange),
),
]),
),
),
],
),

SizedBox(
height: 8,
),
CustomButton(
onTap: () {

singUpValidator();
},
title: AppStrings.singUpText,
),

SizedBox(
height: 16,
),
Center(
child: GestureDetector(
onTap: (){
Get.toNamed(AppRoutes.loginScreen);
},
child: Text.rich(
TextSpan(
text: 'Have any account?',
style: TextStyle(
fontSize: 14, fontWeight: FontWeight.w500),
children: [
TextSpan(
text: ' SIGN IN!',
style: TextStyle(
fontSize: 14,
fontWeight: FontWeight.w500,
color: Colors.orange),
),

]),
),
),
),
],
);
}
),
),
),
)

*/