// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_selected.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/user_profile_screen.dart';

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
                UserProfileScreen(),

                SizedBox(height: 15,),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.neutral02,
                        borderRadius: BorderRadius.circular(10),
                      ),child: CustomText(text: "Working Time : 6:30 hours",fontSize: 12,fontWeight: FontWeight.w400,),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.neutral02,
                        borderRadius: BorderRadius.circular(10),
                      ),child: CustomText(text: "Millage : 8km",fontSize: 12,fontWeight: FontWeight.w400,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTabSelector(
                    fontSize: isTablet?24:16,
                    tabs: eventsController.nameList,
                    selectedIndex: eventsController.currentIndex.value,
                    onTabSelected: (value) {
                      eventsController.currentIndex.value = value;
                      setState(() {});
                    },
                    selectedColor: AppColors.primary,
                    unselectedColor: AppColors.black),
                SizedBox(
                  height: 20,
                ),
                if (eventsController.currentIndex.value == 0)
                  Column(
                      children: List.generate(3, (index) {
          
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            children: [
          
                              CustomNetworkImage(
                                imageUrl: AppConstants.eventImage,
                                height: isTablet ? 200.h : 170.h,
                                width: isTablet ? 180.w : 170.w,
                                borderRadius: BorderRadius.circular(10),
                              ),
          
                              SizedBox(
                                width: 10,
                              ),
          
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
          
                                  SizedBox(
                                    width: 140.w,
                                    child: Expanded(
                                      child: CustomText(
                                        textAlign: TextAlign.start,
                                        text: "Cox’s Bazar Beach Helping Peolple",
                                        maxLines: 3,
                                        fontSize:isTablet?6.sp: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        bottom: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  /// Location
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: AppColors.black,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 140.w,
                                        child: CustomText(
                                          text: "Cox’s Bazar, Bangladesh",
                                          maxLines: 3,
                                          fontSize:isTablet?6.sp: 14.sp,
                                          color: AppColors.black_80,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                         textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Leader
                                  Row(
                                    children: [
                                      CustomNetworkImage(
                                        imageUrl: AppConstants.profileImage,
                                        height: isTablet?45: 30,
                                        width: isTablet?45: 30,
                                        boxShape: BoxShape.circle,
                                      ),
                                      CustomText(
                                        text: "Mehedi",
                                        fontSize:isTablet?6.sp: 14.sp,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                        right: 10.w,
                                        left: 10.w,
                                      ),
                                    /*  CustomText(
                                        text: "Leader",
                                        fontSize:isTablet?6.sp: 14.sp,
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
          
                                          Get.toNamed(AppRoutes.exploreEventScreen);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: CustomText(
                                            text:   "Explore",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
          
          
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      })),
                if(eventsController.currentIndex.value == 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///========== volunteer =========
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(70)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: AppStrings.volunteer,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          )
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
                        text: "Mededi Bin Ab. Salam",
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
