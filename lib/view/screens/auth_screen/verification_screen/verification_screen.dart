
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_pin_code/custom_pin_code.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/auth_screen/controller/auth_controller.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  String? email;

  final authController = Get.put(AuthController());

  final newTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     if(Get.arguments[0]["email"]!=null){

      email = Get.arguments[0]["email"];
    }
  }

  @override
  void dispose() {
    newTextEditingController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            AppStrings.serveOut,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600),
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_rounded, color: AppColors.black,size: isTablet?28.w:32.w
                  ,),
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Obx(
            () {
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/1.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [



                      Column(
                        children: [

                          CustomText(
                            top: 40.h,
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
                            color: AppColors.black,
                          ),

                         ///CustomPinCode(controller: authController.otpController.value),

                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: PinCodeTextField(
                              textStyle: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              appContext: context,
                              length: 4,
                              enableActiveFill: true,
                              animationType: AnimationType.fade,
                              animationDuration: Duration(milliseconds: 300),
                              controller: newTextEditingController,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(16),
                                fieldHeight: isTablet?70.h:60.h,
                                fieldWidth: 60.0,
                                inactiveColor: AppColors.grey_1,
                                activeColor: AppColors.grey_1,
                                activeFillColor: AppColors.grey_1,
                                inactiveFillColor: AppColors.grey_1,
                                selectedFillColor: AppColors.grey_1,
                                disabledColor: AppColors.grey_1,
                                selectedColor: AppColors.grey_1,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              CustomText(
                                text: AppStrings.ididntFind,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black_04,
                                right: 10,
                              ),
                              authController.otpResetLoading.value? Center(child: CircularProgressIndicator()):
                              GestureDetector(
                                onTap: (){
                                 authController.otpResetValidation(email.toString());
                                },
                                child: CustomText(
                                  text: AppStrings.sendAgain,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      ///============ Login Button ============
                      authController.otpLoading.value?Center(child: CircularProgressIndicator()): CustomButton(
                        onTap: () {

                        authController.otpValidation(email.toString(),newTextEditingController.value.text.toString());
                        },
                        title: AppStrings.confirm,
                        height: isTablet?60.h:60.h,
                        fontSize: isTablet ? 10.sp : 14.sp,
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      );
    });

  }
}

