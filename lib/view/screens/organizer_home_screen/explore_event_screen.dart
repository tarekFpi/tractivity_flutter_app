// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';

class ExploreEventScreen extends StatefulWidget {
  const ExploreEventScreen({super.key});

  @override
  State<ExploreEventScreen> createState() => _ExploreEventScreenState();
}

class _ExploreEventScreenState extends State<ExploreEventScreen> {


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
                  imageUrl: AppConstants.profileImage,
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
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(
                          height: 12,
                        ),

                        CustomText(
                          text: "Rohingya refugee camp",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_80,
                        ),

                        SizedBox(
                          height: 4,
                        ),
                        CustomText(
                          text: "Download",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightBlue,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),

                Row(
                  children: [

                    CustomText(
                      text: "Rohingya refugee camp",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_80,
                    ),

                    SizedBox(
                      width: 4,
                    ),
                    CustomText(
                      text: "(Event Name)",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlue,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 8,
                ),

                Row(
                  children: [

                    CustomText(
                      text: "Empower Tomorrow",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_80,
                    ),

                    SizedBox(
                      width: 4,
                    ),
                    CustomText(
                      text: "(Mission Name)",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlue,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                Row(
                  children: [

                    CustomText(
                      text: "Global Horizons Foundation",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_80,
                    ),

                    SizedBox(
                      width: 4,
                    ),
                    CustomText(
                      text: "(Organization)",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlue,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),


                CustomText(
                  text: "Rohingya refugee camp",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_80,
                ),

                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      size: 18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    CustomText(
                      text: "3500",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_80,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
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
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_80,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height:isTablet?32.h: 24.h,
                      width:isTablet?32.w: 24.w,
                      boxShape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    Text.rich(
                      TextSpan(
                          text: 'Mehedi Bin',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: ' Leader',
                              style: TextStyle(
                                  fontSize:  12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightBlue),
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height:isTablet?32.h: 24.h,
                      width:isTablet?32.w: 24.w,
                      boxShape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text.rich(
                      TextSpan(
                          text: 'Sujon',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: ' Food Delivery',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightBlue),
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const CustomText(
                  text: "Description",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black_80,
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomText(
                  text:
                  "The Rohingya have faced decades of discrimination \n and repression under successive Myanmar authorities. denied citizenship \n under the 1982 Citizenship Law, they are one of \n the largest stateless populations in the world.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_80,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 16,
                ),
                const CustomText(
                  text: "Time & Date",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black_80,
                ),

                const SizedBox(
                  height: 8,
                ),

                const CustomText(
                  text: "22 December, 2024, 8.00 am-12.00 pm",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_80,
                ),

                const SizedBox(
                  height: 16,
                ),

                CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.adminstratorMember);
                  },
                  title: "Details",
                  width: 80.w,
                  height: 32.h,
                  textColor: AppColors.black,
                  fillColor: AppColors.primary,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ),

      );
    });
  }
}
