
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_images/app_images.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';

class OrganizerActiveMissionDetails extends StatefulWidget {
  const OrganizerActiveMissionDetails({super.key});

  @override
  State<OrganizerActiveMissionDetails> createState() => _OrganizerActiveMissionDetailsState();
}

class _OrganizerActiveMissionDetailsState extends State<OrganizerActiveMissionDetails> {

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
         appBar: const CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Mission Details",
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomText(
                  textAlign: TextAlign.start,
                  text: "Organization",
                  fontSize:isTablet?6.sp: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  bottom: 5,
                ),

                CustomText(
                  text: "Organization Horizons Foundation",
                  fontSize:isTablet?6.sp: 16.sp,
                  color: AppColors.black_80,
                  fontWeight: FontWeight.w600,
                  bottom: 6.h,
                ),
                CustomText(
                  text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                  fontSize: 12,
                  color: AppColors.black_02,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  bottom: 4.h,// Add ellipsis at the end if the text overflows.
                ),

                const Divider(
                  color: Colors.black54,
                  // height: 16.h,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  text: "Mission",
                  fontSize:isTablet?6.sp: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  bottom: 5,
                ),
                CustomText(
                  text: "Mission Horizons Foundation",
                  fontSize:isTablet?6.sp: 16.sp,
                  color: AppColors.black_80,
                  fontWeight: FontWeight.w600,
                  bottom: 6.h,
                ),
                CustomText(
                  text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                  fontSize: 12,
                  color: AppColors.black_02,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  bottom: 4.h,// Add ellipsis at the end if the text overflows.
                ),

                const Divider(
                  color: Colors.black54,
                  // height: 16.h,
                ),

                CustomText(
                  textAlign: TextAlign.start,
                  text: "Organizers",
                  fontSize:isTablet?6.sp: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  bottom: 8.h,
                ),


                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: [

                            CustomNetworkImage(
                              imageUrl: AppConstants.profileImage,
                              height:isTablet?64.h: 60.h,
                              width:isTablet?64.w: 60.w,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Farhad Hossain",
                                  fontSize:isTablet?6.sp:12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                                CustomText(
                                  text: "Student",
                                  fontSize:isTablet?6.sp: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black_80,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: [

                            CustomNetworkImage(
                              imageUrl: AppConstants.profileImage,
                              height:isTablet?64.h: 60.h,
                              width:isTablet?64.w: 60.w,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Jamal Hasan",
                                  fontSize:isTablet?6.sp:12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                                CustomText(
                                  text: "worker",
                                  fontSize:isTablet?6.sp: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black_80,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                      Row(

                        children: [

                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.black_04,
                              borderRadius: BorderRadius.circular(10.r),
                              // border: Border.all(color: AppColors.primary,width: 2),
                            ),
                            child: GestureDetector(
                              onTap: (){

                              },
                              child:  Center(
                                  child: CustomText(
                                    text: "Invited",
                                    color: AppColors.white,
                                    fontSize:isTablet?6.sp: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),

                const Divider(
                  color: Colors.black54,
                ),

                SizedBox(
                  height: 8.h,
                ),

                Card(
                  color: Colors.white,
                  elevation: 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ExpansionTile(
                      shape: Border(),
                      title:  CustomText(
                        textAlign: TextAlign.start,
                        text: "volunteers",
                        fontSize:isTablet?6.sp: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                        bottom: 8.h,
                      ),
                      children:  [


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: [

                                Container(
                                  height: 60.h,
                                  width:60.w,
                                 decoration: BoxDecoration(
                                  shape: BoxShape.circle,  // Circle shape
                                   color: Colors.grey,
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.userImage), // Your image path
                                    fit: BoxFit.cover,  // Ensures the image fills the circle
                                  ),
                                ),
                                ),


                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Farhad Hossain",
                                        fontSize:isTablet?6.sp:12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                      CustomText(
                                        text: "Student",
                                        fontSize:isTablet?6.sp: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black_80,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),

                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: [

                                  CustomNetworkImage(
                                    imageUrl: AppConstants.profileImage,
                                    height:isTablet?64.h: 60.h,
                                    width:isTablet?64.w: 60.w,
                                    boxShape: BoxShape.circle,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Jamal Hasan",
                                        fontSize:isTablet?6.sp:12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                      CustomText(
                                        text: "worker",
                                        fontSize:isTablet?6.sp: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black_80,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),


                            Row(

                              children: [

                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.black_04,
                                    borderRadius: BorderRadius.circular(10.r),
                                    // border: Border.all(color: AppColors.primary,width: 2),
                                  ),
                                  child: GestureDetector(
                                    onTap: (){

                                    },
                                    child:  Center(
                                        child: CustomText(
                                          text: "Invited",
                                          color: AppColors.white,
                                          fontSize:isTablet?6.sp: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),


                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 8.h,
                ),

                const Divider(
                  color: Colors.black54,
                ),

                SizedBox(
                  height: 8.h,
                ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      CustomButton(
                        onTap: () {

                         Get.toNamed(AppRoutes.missionToVolunteersInviteScreen);
                        },
                        title: "Invite volunteers",
                        height:isTablet?40.h: 35.h,
                        width: 120.w,
                        textColor: AppColors.white,
                        fillColor: AppColors.primary,
                        fontSize: 12,
                      ),

                      CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.missionEventReportScreen);
                        },
                        title: "Report",
                        height:isTablet?40.h: 35.h,
                        width: 100.w,
                        textColor: AppColors.white,
                        fillColor: AppColors.primary,
                        fontSize: 12,
                      ),
                    ],
                  ),

                  SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.neutral02,
                        borderRadius: BorderRadius.circular(10),
                      ),child: CustomText(text: "Hours: 4:30 Hours",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                    ),

                    SizedBox(
                      width: 8.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.neutral02,
                        borderRadius: BorderRadius.circular(10),
                      ),child: CustomText(text: "Millage: 8Km",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                    ),
                  ],
                ),


                SizedBox(
                  height: 12.h,
                ),

                Row(
                  children: [
                    CustomText(
                      text:  "Mission mode:",
                      fontSize:isTablet?6.sp: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    CustomText(
                      text:  "Public",
                      fontSize:isTablet?6.sp: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cardBarClr,
                    )
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
                  textAlign: TextAlign.start,
                  text: "Events List",
                  fontSize:isTablet?6.sp: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  bottom: 8.h,
                ),

                Column(
                    children: List.generate(3, (index) {

                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [

                            CustomNetworkImage(
                              imageUrl: AppConstants.eventImage,
                              height: isTablet ? 200.h : 170.h,
                              width: isTablet ? 180.w : 170.w,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(
                                  width: 150.w,
                                  child: const CustomText(
                                    textAlign: TextAlign.start,
                                    text: "Cox’s Bazar Beach Helping Peolple",
                                    maxLines: 3,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    bottom: 5,
                                  ),
                                ),
                                /// Location
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColors.black,
                                      size: 20,
                                    ),
                                    CustomText(
                                      text: "Cox’s Bazar, Bangladesh",
                                      fontSize: 12,
                                      color: AppColors.black_80,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                /// Leader
                                Row(
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: AppConstants.profileImage,
                                      height: 30,
                                      width: 30,
                                      boxShape: BoxShape.circle,
                                    ),
                                    CustomText(
                                      text: "Mehedi",
                                      fontSize: 14,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                      right: 10.w,
                                      left: 10.w,
                                    ),
                                    const CustomText(
                                      text: "Leader",
                                      fontSize: 14,
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    GestureDetector(
                                      onTap: () {

                                        Get.toNamed(AppRoutes.organizerRecentEventDetails);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child:  CustomText(
                                          text:  "Explore",
                                          fontSize:isTablet?6.sp: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),


                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.organizerEventCreateScreen);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child:  CustomText(
                                          text:  "Duplicate",
                                          fontSize:isTablet?6.sp: 12.sp,
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
                    })
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.organizerEventCreateScreen);
                },
                title: "Create Event",
                height: 45.h,
                textColor: AppColors.black,
                fillColor: AppColors.primary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    });
  }
}
