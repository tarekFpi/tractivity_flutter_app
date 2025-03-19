
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/auth_screen/controller/auth_controller.dart';

class EditPersonProfileScreen extends StatefulWidget {
  const EditPersonProfileScreen({super.key});

  @override
  State<EditPersonProfileScreen> createState() => _EditPersonProfileScreenState();
}

class _EditPersonProfileScreenState extends State<EditPersonProfileScreen> {

  bool valuefirst = false;

  String checkValueStatues = "";

  final authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authController.userInformationShow();
    authController.getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: const CustomRoyelAppbar(
          titleName: "Edit Profile",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 50),
            child: Obx(
               () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ///====================== profile image===================

                    Center(
                      child: Stack(
                        children: [

                         /* CustomNetworkImage(
                            imageUrl:
                            "${ApiUrl.imageUrl}${authController.userProfileShow.value.image ?? ""}",
                            height: 120.h,
                            width: 120.w,
                            ///boxShape: BoxShape.circle,
                          ),*/

                          authController.chooseUserImage.value==""?
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
                          image: NetworkImage("${ApiUrl.imageUrl}${authController.userProfileShow.value.image ?? ""}"),
                          fit: BoxFit.cover,
                        ),
                         ),
                          ):
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
                            bottom: 4,
                            right: isTablet? -80:-60,
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

                    /// =====Profile Name List =========
                    SizedBox(
                      height: 12.h,
                    ),

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

                                    authController.editRolesList.add("volunteer");
                                  }else{
                                    authController.editRolesList.remove("volunteer");
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

                                    authController.editRolesList.add("organizer");
                                  }else{
                                    authController.editRolesList.remove("organizer");
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

                                    authController.editRolesList.add("administrator");
                                  }else{
                                    authController.editRolesList.remove("administrator");
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

                    SizedBox(
                      height: 12.h,
                    ),
                    ///============ First Name ============
                    CustomFormCard(
                        title: AppStrings.yourFirstName,
                        hintText: AppStrings.enterYourName,
                        fontSize: isTablet?16:16,
                        hasBackgroundColor: true,
                        controller: authController.editfullNameController.value),

                    ///============ Last Name ============
                    CustomFormCard(
                        title: "Talent/Skill",
                        hintText: "Enter Talent/Skill",
                        fontSize: isTablet?16:16,
                        hasBackgroundColor: true,
                        controller: authController.edittalentSkillController.value),

                    ///============ phoneNumber ============
                    CustomFormCard(
                        title: AppStrings.phoneNumber,
                        hintText: AppStrings.enterYourPhone,
                        hasBackgroundColor: true,
                        fontSize: isTablet?16:16,
                        keyboardType: TextInputType.number,
                        controller: authController.editphoneNumberController.value),

             /*       ///============ email ============
                    CustomFormCard(
                        title: AppStrings.email,
                        hintText: AppStrings.enterYourEmail,
                        hasBackgroundColor: true,
                        fontSize: isTablet?16:16,
                        controller: authController.editemailController.value),
*/
                    ///============ Location ============
                    CustomFormCard(
                        title: AppStrings.location,
                        hintText: AppStrings.enterYourLocation,
                        hasBackgroundColor: true,
                        fontSize: isTablet?16:16,
                        controller: authController.editlocationController.value),

                   authController.userInfoUpdateShowLoading.value?CircularProgressIndicator(color: Colors.amber,):
                    CustomButton(
                      onTap: () {

                       if(authController.editfullNameController.value.text==""){

                          Toast.errorToast("full name is empty!!");

                        }else if(authController.edittalentSkillController.value.text==""){

                         Toast.errorToast("profession Skill is empty!!");

                        }else if(authController.editphoneNumberController.value.text==""){

                         Toast.errorToast("phone number is Empty!..");

                       }else if(authController.editRolesList.isEmpty){

                         Toast.errorToast("user roles is Empty!..");

                       }else if(authController.editlocationController.value.text==""){

                         Toast.errorToast("location name is Empty!..");

                       }else{

                         authController.getLatLongFromAddress();
                        }

                      },
                      title: "Save & Change",
                      height: isTablet?70:60,
                      fontSize: isTablet ? 16 : 14,
                    )
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
