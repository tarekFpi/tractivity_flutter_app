

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';


class ExoloreCompleteDetailsScreen extends StatelessWidget {

  ExoloreCompleteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Event Details",
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.eventImage,
                  height:isTablet?200.h: 170.h,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: BorderRadius.circular(10),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomImage(imageSrc: AppIcons.dowanload),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              const CustomText(
                                text: "Rohingya refugee camp",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_80,
                              ),

                              GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.volunteerChartScreen);
                                  },
                                  child: CustomImage(imageSrc: AppIcons.chart)),

                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          CustomText(
                            text: "Download",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightBlue,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),

                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    CustomText(
                      text: "Cox’s Bazar",
                      fontSize:isTablet?6.sp: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_80,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),

                const Divider(
                  color: Colors.black54,
                ),

                SizedBox(
                  height: 8.h,
                ),

                CustomText(
                  text: "Organization",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),

                SizedBox(
                  height: 4.h,
                ),
                CustomText(
                  text: "Global Horizons Foundation",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_80,
                  bottom: 6,
                ),

                const Divider(
                  color: Colors.black54,
                ),

                SizedBox(
                  height: 12.h,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                      text: "Mission Name",
                      fontSize:isTablet?6.sp: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),

                    SizedBox(
                      height: 4.h,
                    ),

                    CustomText(
                      text: "Empower Tomorrow",
                      fontSize:isTablet?6.sp: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_80,
                      bottom: 6,
                    ),

                  ],
                ),

                const Divider(
                  color: Colors.black54,
                ),

                SizedBox(
                  height: 12.h,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                      text: "Event",
                      fontSize:isTablet?6.sp: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,

                    ),
                    SizedBox(
                      height: 4.h,
                    ),

                    CustomText(
                      text: "Rohingya refugee camp",
                      fontSize:isTablet?6.sp: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_80,
                      bottom: 6,
                    ),

                    const Divider(
                      color: Colors.black54,
                    ),
                  ],
                ),

                SizedBox(
                  height: 12.h,
                ),

                CustomText(
                  text: "Organizer",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  bottom: 8,
                ),
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height:isTablet?42.h: 32.h,
                      width:isTablet?42.w: 32.w,
                      boxShape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                    ),

                    SizedBox(
                      width: 8.w,
                    ),
                    CustomText(
                      text: "Sujon",
                      fontSize:isTablet?6.sp: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      bottom: 6,
                    ),
                  ],
                ),

                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height:isTablet?42.h: 32.h,
                      width:isTablet?42.w: 32.w,
                      boxShape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                    ),

                    SizedBox(
                      width: 8.w,
                    ),
                    CustomText(
                      text: "Mehedi",
                      fontSize:isTablet?6.sp: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      bottom: 6,
                    ),
                  ],
                ),

                const Divider(
                  color: Colors.black54,
                ),
                SizedBox(
                  height: 12.h,
                ),

                CustomText(
                  text: "Description",
                  fontSize:isTablet?6.sp: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 8.h,
                ),

                CustomText(
                  text:
                  "The Rohingya have faced decades of discrimination \n and repression under successive Myanmar authorities. denied citizenship \n under the 1982 Citizenship Law, they are one of \n the largest stateless populations in the world.",
                  fontSize:isTablet?6.sp: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_80,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 16.h,
                ),

                const Divider(
                  color: Colors.black54,
                ),

                CustomText(
                  text: "Time & Date",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomText(
                  text: "22 December, 2024, 8.00 am-12.00 pm",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_80,
                ),


                SizedBox(
                  height: 8.h,
                ),
                const Divider(
                  color: Colors.black54,
                ),

                CustomText(
                  text: "Street",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 4.h,
                ),
                CustomText(
                  text: "Bijoy Sarani",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_80,
                  bottom: 6,
                ),

                const Divider(
                  color: Colors.black54,
                ),

                CustomText(
                  text: "City",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 4.h,
                ),
                CustomText(
                  text: "Dhaka city, Keraniganj",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_80,
                  bottom: 6,
                ),

                const Divider(
                  color: Colors.black54,
                ),

                CustomText(
                  text: "My Role",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 4.h,
                ),
                CustomText(
                  text: "Food Delivery",
                  fontSize:isTablet?6.sp: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_80,
                  bottom: 6,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}