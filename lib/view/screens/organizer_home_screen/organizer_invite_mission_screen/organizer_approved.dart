
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class OrganizerEventCreateScreen extends StatefulWidget {
  const OrganizerEventCreateScreen({super.key});

  @override
  State<OrganizerEventCreateScreen> createState() => _OrganizerEventCreateScreenState();
}

class _OrganizerEventCreateScreenState extends State<OrganizerEventCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: const CustomRoyelAppbar(
          titleName: "Create Event",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height: 100,
                      width: 100,
                      boxShape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Mehedi Bin Ab. Salam",
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
                              text: "Bushwick Brooklyn, NY, USA",
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Container(
                      height:isTablet?90.h: 100.h,
                      width:isTablet? 110.w:140.w,
                      decoration: BoxDecoration(
                        color: AppColors.grey_5.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [

                          CustomImage(imageSrc: AppIcons.uploadIcon,width: 45,height: 45,),

                          SizedBox(
                            height: 4,
                          ),
                          CustomText(
                            text: "Upload Image",
                            fontSize: 12,
                            color: AppColors.black_80,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      height:isTablet?90.h: 100.h,
                      width:isTablet? 110.w:140.w,
                      decoration: BoxDecoration(
                        color: AppColors.grey_5.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [

                          CustomImage(imageSrc: AppIcons.dowanload,width: 45,height: 45,),

                          SizedBox(
                            height: 4,
                          ),
                          CustomText(
                            text: "Upload PDF",
                            fontSize: 12,
                            color: AppColors.black_80,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),
                ///============ Event Name ============
                CustomFormCard(
                    fontSize: isTablet?16:16,
                    title: "Event Name",
                    hintText: "Event Name",
                    hasBackgroundColor: true,
                    controller: TextEditingController()),

                ///============ Event Name ============
                CustomFormCard(
                    fontSize: isTablet?16:16,
                    title: "Description",
                    hintText: "Description",
                    hasBackgroundColor: true,
                    controller: TextEditingController()),

                Row(
                  ///mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    const Icon(
                      Icons.location_on,
                      size: 24,
                    ),

                    CustomButton(onTap: (){
                      Get.toNamed(AppRoutes.organizeMapScreen);

                    }, title: "Map",height:isTablet?30.h: 25.h,width: 60.w,fontSize:isTablet?6.sp: 12.sp,),


                    const SizedBox(
                      width: 8,
                    ),

                    Row(
                      children: [
                        const Icon(
                          Icons.lock_clock,
                          size: 24,
                        ),

                        SizedBox(
                          width: 4,
                        ),
                        CustomText(
                          text: "start",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),

                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 24,
                        ),
                      ],
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    Row(
                      children: [
                        CustomText(
                          text: "end",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),

                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 24,
                        ),
                      ],
                    ),


                    const SizedBox(
                      width: 8,
                    ),

                    const Expanded(
                      child: Row(
                        children: [

                          Icon(
                            Icons.calendar_month_outlined,
                            size: 24,
                          ),

                          CustomText(
                            text: "00/00/0000",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                  SizedBox(
                  height:isTablet?16.h: 12.h,
                ),

                Row(
                  children: [
                    CustomButton(onTap: (){

                    }, title: "Private",height: 30.h,width:isTablet?60.w:70.w,fontSize:isTablet?6.sp:14.sp,
                      textColor: AppColors.black,
                      fillColor: AppColors.white,
                      isBorder: true,
                      borderWidth: .5,
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    CustomButton(onTap: (){

                    }, title: "Public",height: 30.h,width: isTablet?60.w:70.w,fontSize:isTablet? 6.sp:14.sp,),

                    const SizedBox(
                      width: 12,
                    ),
                    CustomButton(onTap: (){

                    }, title: "Organization",height: 30.h,width:isTablet?90.w: 100.w,fontSize:isTablet? 6.sp:14.sp,
                      textColor: AppColors.black,
                      fillColor: AppColors.white,
                      isBorder: true,
                      borderWidth: .5,
                    ),
                  ],
                ),

                  SizedBox(
                  height:isTablet?16.h: 12.h,
                ),

                CustomButton(onTap: (){

                  Get.toNamed(AppRoutes.addMemberScreen);

                }, title: "Add Member",height: 30.h,width: 90.w,fontSize: 12,
                  textColor: AppColors.black,
                ),

                  SizedBox(
                  height:isTablet?16.h: 12.h,
                ),

                CustomButton(onTap: (){
                  Get.toNamed(AppRoutes.memberScreen);
                }, title: "View All Members",height: 30.h,width:isTablet?120.w: 140.w,fontSize:isTablet? 6.sp:14.sp,
                  textColor: AppColors.black,
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(onTap: (){
              }, title: "Submit",fontSize: 12, height: isTablet?70:60,),
            ),



          ],
        ),
      );
    });
  }
}
