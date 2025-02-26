
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';


class OrganizeDetailsScreen extends StatefulWidget {
  const OrganizeDetailsScreen({super.key});

  @override
  State<OrganizeDetailsScreen> createState() => _OrganizeDetailsScreenState();
}

class _OrganizeDetailsScreenState extends State<OrganizeDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: const CustomRoyelAppbar(
          titleName: "Organization Details",
          leftIcon: true,
        ),

        body: Padding(
          padding:   EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                SizedBox(
                  height: 16.h,
                ),

                Column(
                    children: List.generate(1, (index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.neutral02,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Empower Tomorrow",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      bottom: 8.h,
                                    ),
                                    CustomText(
                                      text:
                                      "Fostering opportunities for underprivileged communities through education and skill development programs.",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      bottom: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        CustomNetworkImage(
                                          imageUrl: AppConstants.profileImage,
                                          height: 40.h,
                                          width: 40.w,
                                          boxShape: BoxShape.circle,
                                        ),
                                        CustomText(
                                          text: "Mehedi",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          left: 8.h,
                                          right: 8.h,
                                        ),
                                        const CustomText(
                                          text: "(Adminstrator)",
                                          fontSize: 14,
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    })
                ),

                const SizedBox(
                  height: 26,
                ),

                  CustomText(
                  text: "Mission",
                  fontSize:isTablet?12.sp: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),

                SizedBox(
                  height: 16.h,
                ),

                Column(
                    children: List.generate(3, (index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.neutral02,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Empower Tomorrow",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      bottom: 8.h,
                                    ),
                                    CustomText(
                                      text:
                                      "Fostering opportunities for underprivileged communities through education and skill development programs.",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      maxLines: 5,
                                      textAlign: TextAlign.start,
                                      bottom: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        CustomNetworkImage(
                                          imageUrl: AppConstants.profileImage,
                                          height: 40.h,
                                          width: 40.w,
                                          boxShape: BoxShape.circle,
                                        ),
                                        CustomText(
                                          text: "Mehedi",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          left: 8.h,
                                          right: 8.h,
                                        ),
                                        CustomText(
                                          text: "(Adminstrator)",
                                          fontSize: 14,
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [

                                  CustomText(
                                    text: "17-12-2024",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    bottom: 8.h,
                                  ),

                                  CustomButton(onTap: (){
                                    ///OrganizerApprovedScreen

                                    Get.toNamed(AppRoutes.organizationEventListScreen);
                                  }, title: "Details",
                                    height:isTablet?40.h: 30.h,
                                    width:isTablet?70.w: 70.w
                                    ,fontSize: 12,),

                                ],
                              )


                            ],
                          ),
                        ),
                      );
                    })
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
