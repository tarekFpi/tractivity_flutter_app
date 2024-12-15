// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class HomeSideDrawer extends StatelessWidget {
  const HomeSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
        color: AppColors.white,
      ),
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
        children: [
          ///================================ APP LOGO ==============================///
          Container(
            height: 122,
            alignment: Alignment.bottomCenter,
            color: AppColors.white,
            child: CustomImage(
              imageSrc: AppIcons.userIcons,
              // imageColor: AppColors.white,
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///====================== myProfile ======================>
                         customRow(
                        title: "Profile",
                        icon: Icons.person,
                        onTap: () {
                          Navigator.pop(context);
                        //  Get.toNamed(AppRoutes.salonProfileScreen);
                        }),




                    ///====================== settings ======================>
                    customRow(
                        title: "settings",
                        icon: Icons.settings,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.settingScreen);
                        }),



                    const SizedBox(
                      height: 12,
                    ),

                    const Divider(
                      height: 2,
                    ),

                    ///====================== aboutUs ======================>
                    customRow(
                        title: "About Us",
                        icon: Icons.info_outline,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.aboutUsScreen);
                        }),

                    ///====================== privacyPolicy ======================>
                    customRow(
                        title: AppStrings.privacyPolicy,
                        icon: Icons.privacy_tip,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.privacyPolicyScreen);
                        }),

                    ///====================== termsAndConditions ======================>
                    customRow(
                        title: AppStrings.termsAndConditions,
                        icon: Icons.task_rounded,
                        onTap: () {
                          Navigator.pop(context);
                       //   Get.toNamed(AppRoutes.termsConditionsScreen);
                        }),

                    const Divider(
                      height: 2,
                    ),

                    ///====================== Log Out======================>
                    customRow(
                        title: AppStrings.logOut,
                        icon: Icons.logout,
                        onTap: () {
                          Navigator.pop(context);
                          Get.offNamed(AppRoutes.loginScreen);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customRow(
          {required String title,
          // required String icon,
          IconData? icon,
          String? imageSrc,
          required VoidCallback onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //  Icon(icon,color: AppColors.black_50,),
                    icon != null
                        ? Icon(
                            icon,
                            color: AppColors.black,
                          )
                        : SvgPicture.asset(
                            imageSrc ?? "",
                            height: 20,
                            width: 20,
                          ),

                    CustomText(
                      color: AppColors.black_80,
                      left: 16.w,
                      text: title,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                )
              ],
            )),
      );
}
