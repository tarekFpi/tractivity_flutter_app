// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_selected.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';

class UserEventProfile extends StatefulWidget {
  const UserEventProfile({super.key});

  @override
  State<UserEventProfile> createState() => _UserEventProfileState();
}

class _UserEventProfileState extends State<UserEventProfile> {

  final EventsController eventsController = Get.find<EventsController>();



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Profile",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                ///================= Profile Image , Name and Location
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height: isTablet ? 120.h : 100.h,
                      width: isTablet ? 120.w : 100.w,
                      boxShape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Mehedi Hasan Tarek",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            CustomText(
                              text: "Bushwhack Brooklyn, NY, USA",
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),

                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.neutral02,
                        borderRadius: BorderRadius.circular(10),
                      ),child: CustomText(text: "Hours: 4:30 Hours",fontSize:isTablet?8: 12.sp,fontWeight: FontWeight.w400,),
                    ),

                    SizedBox(
                      width: 8.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.neutral02,
                        borderRadius: BorderRadius.circular(10),
                      ),child: CustomText(text: "Millage: 8Km",fontSize:isTablet?8: 12.sp,fontWeight: FontWeight.w400,),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20.h,
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ///========== volunteer =========
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        CustomText(
                          text:"Details",
                          fontSize: isTablet?9.sp: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),

                        CustomButton(
                          onTap: () {
                         Get.toNamed(AppRoutes.volunteerEventReportScreen);
                          },
                          title: "Report",
                          height:isTablet?40.h: 35.h,
                          width: 80.w,
                          textColor: AppColors.white,
                          fillColor: AppColors.primary,
                          fontSize: 12,
                        ),
                      ],
                    ),

                    ///========== full name =========
                    CustomText(
                      top: 10,
                      text: AppStrings.fullName,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      bottom: 10,
                    ),
                    CustomText(
                      text: "Mededi Hasan",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    ///========== profession =========
                    CustomText(
                      top: 10,
                      text: AppStrings.profession,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      bottom: 10,
                    ),
                    CustomText(
                      text: "Software Engineer",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    ///========== phoneNumber =========
                    CustomText(
                      top: 10,
                      text: AppStrings.phoneNumber,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      bottom: 10,
                    ),
                    CustomText(
                      text: "88+ 880 1234567",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    ///========== email =================
                    CustomText(
                      top: 10,
                      text: AppStrings.email,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      bottom: 10,
                    ),
                    CustomText(
                      text: "mehedi@gmail.com",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),

                    ///========== address ===============
                    CustomText(
                      top: 10,
                      text: AppStrings.address,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      bottom: 10,
                    ),
                    CustomText(
                      text: "Diamond, Dhaka, Bangladesh",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
