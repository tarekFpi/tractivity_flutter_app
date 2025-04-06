// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_dropdown/custom_royel_dropdown.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/auth_screen/controller/auth_controller.dart';
import 'package:tractivity_app/view/screens/auth_screen/signup_screen/CapitalizeWordsFormatter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final authController = Get.put(AuthController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///final TextEditingController locationEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

  authController.getUserCurrentLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustomRoyelAppbar(titleName: AppStrings.singUpText),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 40 : 12.w, // Adjust padding dynamically
                  vertical: isTablet ? 32 : 12.h, // Adjust top padding for tablet
                ),
                child: Obx(
                      () {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        /// Title
                        Container(
                          height: 1.h,
                          width: MediaQuery.sizeOf(context).width,
                          color: AppColors.white_50,
                        ),

                        SizedBox(height: 30.h),


                        /// Profile Role Selection (Radio Buttons)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Checkbox(
                                    checkColor: AppColors.white,
                                    activeColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    side: const BorderSide(
                                      // ======> CHANGE THE BORDER COLOR HERE <======
                                      color: AppColors.primary,
                                      // Give your checkbox border a custom width
                                      width: 1.4,
                                    ),
                                    value: authController.volunteer.value,
                                    onChanged: (bool? value) {

                                      authController.volunteer.value = value!;

                                      if(authController.volunteer.value){

                                        authController.rolesList.add("volunteer");
                                      }else{
                                        authController.rolesList.remove("volunteer");
                                      }

                                    },
                                  ),

                                CustomText(
                                    text: "Volunteer",
                                    fontSize:isTablet?10.sp: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),


                                ],
                              ),

                              SizedBox(
                                width: 4.w,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Checkbox(
                                    checkColor: AppColors.white,
                                    activeColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    side: const BorderSide(
                                      // ======> CHANGE THE BORDER COLOR HERE <======
                                      color: AppColors.primary,
                                      // Give your checkbox border a custom width
                                      width: 1.4,
                                    ),
                                    value: authController.organizer.value,
                                    onChanged: (bool? value) {

                                      authController.organizer.value=value!;

                                      if(authController.organizer.value){

                                        authController.rolesList.add("organizer");
                                      }else{
                                        authController.rolesList.remove("organizer");
                                      }

                                    },
                                  ),

                                  CustomText(
                                    text: "Organizer",
                                    fontSize:isTablet?10.sp: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),

                                ],
                              ),

                              SizedBox(
                                width: 4.w,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Checkbox(
                                    checkColor: AppColors.white,
                                    activeColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    side: const BorderSide(
                                      // ======> CHANGE THE BORDER COLOR HERE <======
                                      color: AppColors.primary,
                                      // Give your checkbox border a custom width
                                      width: 1.4,
                                    ),
                                    value: authController.administrator.value,
                                    onChanged: (bool? value) {

                                      authController.administrator.value=value!;

                                      if(authController.administrator.value){

                                        authController.rolesList.add("administrator");
                                      }else{
                                        authController.rolesList.remove("administrator");
                                      }
                                    },
                                  ),

                                  CustomText(
                                    text: "Administrator",
                                    fontSize:isTablet?10.sp: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 12.h),

                        /// Form Fields
                        ///============ Last Name ============
                    /*    CustomFormCard(
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
                        ),*/

                        CustomText(
                          text: AppStrings.yourName,
                          color:  AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize:isTablet? 16:16,
                          bottom: 8.h,
                          maxLines: 2,
                        ),

                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: authController.fullNameController.value,
                          keyboardType: TextInputType.text,
                          inputFormatters: [CapitalizeWordsFormatter()],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            //labelText: 'Email',
                            hintText: AppStrings.enterYourName,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16), // 👈 Circular corners
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16), // 👈 Keep consistent
                              borderSide: BorderSide(color: Colors.black, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey),
                            ),

                          ),
                        ),

                        SizedBox(
                          height: 12.h,
                        ),

                        ///============ Talent/skill ============
                        CustomFormCard(
                          maxLine: 1,
                          keyboardType: TextInputType.emailAddress,
                          title: AppStrings.talentSkill,
                          hintText: AppStrings.enterSkill,
                          fontSize: isTablet?16:14,
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
                          keyboardType: TextInputType.number,
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
                     /*   CustomFormCard(
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
                        ),*/

                        CustomText(
                          text: AppStrings.email,
                          color:  AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize:isTablet? 16:16,
                          bottom: 8.h,
                          maxLines: 2,
                        ),

                        TextFormField(
                          controller: authController.emailController.value,
                          keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                        }
                        return null;
                        },
                          decoration: InputDecoration(
                            //labelText: 'Email',
                            hintText: 'example@email.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16), // 👈 Circular corners
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16), // 👈 Keep consistent
                              borderSide: BorderSide(color: Colors.black, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey),
                            ),

                          ),
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                        ///============ Location ============
                        CustomFormCard(
                          title: AppStrings.location,
                          hintText: AppStrings.enterYourLocation,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          readOnly: true,
                          suffixIcon: Icon(Icons.location_pin),
                           controller: authController.locationController.value,
                         // controller: locationEditingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.fieldCantBeEmpty;
                            }
                            return null;
                          },
                          onTap: (){

                           // Get.toNamed(AppRoutes.locationMapScreen);
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
                     /*   Row(
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
                        ),*/

                        SizedBox(height: 8),

                        /// Sign Up Button

                    //  authController.userRegisterLoading.value?CustomLoader():
                      CustomButton(
                          height: isTablet?70:60,
                          onTap: () {


                        if (formKey.currentState!.validate()) {

                              if(authController.passwordController.value.text!= authController.confirmPasswordController.value.text){

                                Toast.errorToast("password & Confirm Not match");

                              }else if(authController.rolesList.isEmpty){

                                Toast.errorToast("User roll is Empty!..");
                              }else{

                                authController.userRegister();
                              }
                            }

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
