// ignore_for_file: prefer_const_constructors

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class HomeSideDrawer extends StatefulWidget {
  const HomeSideDrawer({super.key});

  @override
  State<HomeSideDrawer> createState() => _HomeSideDrawerState();
}

class _HomeSideDrawerState extends State<HomeSideDrawer> {

  final storage = GetStorage();

  String status = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (storage.read("status") != null) {
      status = storage.read("status");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
          color: AppColors.white,
        ),
        width: MediaQuery.of(context).size.width / 1.3,
        child: Column(
          children: [

            SizedBox(
              height: 42,
            ),

            ///================================ APP LOGO ==============================///
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
                  height:isTablet?150:80,
                  width:isTablet?150: 80,
                  boxShape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
                SizedBox(
                  height: 12,
                ),
                CustomText(
                  text: "Mehedi Bin Ab. Salam",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ],
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
                          isTablet: isTablet,
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed(AppRoutes.userEventProfile);
                          }),

                      ///====================== Volunteer ======================>
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height:isTablet?45: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: status == "volunteer"
                              ? AppColors.primary
                              : AppColors.white,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Get.toNamed(AppRoutes.homeScreen);
                              storage.write("status", "volunteer");
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.volunteer_activism_outlined,
                                      color: AppColors.black,
                                      size: isTablet?42:24,
                                    ),
                                    CustomText(
                                      color: AppColors.black_80,
                                      left: 14.w,
                                      text: "Volunteer",
                                      fontSize: 14,
                                      fontWeight:status == "volunteer"? FontWeight.w600:FontWeight.w400,
                                    ),
                                  ],
                                ),

                                status == "volunteer"? Icon(
                                  Icons.check,
                                  color: AppColors.black,
                                ):SizedBox(),
                              ],
                            )),
                      ),

                      /*customRow(
                        title: "Volunteer",
                        icon: Icons.volunteer_activism_outlined,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.homeScreen);
                        })*/

                      SizedBox(
                        height: 12,
                      ),

                      ///====================== Organizer ======================>
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height:isTablet?45: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: status == "organizer"
                              ? AppColors.primary
                              : AppColors.white,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed(AppRoutes.organizerHomeScreen);
                            storage.write("status", "organizer");
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.opacity_rounded,
                                      color: AppColors.black,
                                      size: isTablet?42:24,
                                    ),

                                    CustomText(
                                      color: AppColors.black_80,
                                      left: 14.w,
                                      text: "Organizer",
                                      fontSize: 14,
                                      fontWeight:status == "organizer"? FontWeight.w600:FontWeight.w400,
                                    ),
                                  ],
                                ),

                                status == "organizer"? Icon(
                                  Icons.check,
                                  color: AppColors.black,
                                ):SizedBox(),


                              ],
                            ),
                          ),
                        ),
                      ),

                      /*       customRow(
                        title: "Organizer",
                        icon: Icons.opacity_rounded,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.organizerHomeScreen);
                        }),*/

                      ///====================== Administrator ======================>
                      /* customRow(
                        title: "Administrator",
                        icon: Icons.admin_panel_settings,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.adminstratorHomeScreen);
                        }),*/

                      SizedBox(
                        height: 12,
                      ),

                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height:isTablet?45: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: status == "administrator"
                              ? AppColors.primary
                              : AppColors.white,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed(AppRoutes.adminstratorHomeScreen);
                            storage.write("status", "administrator");
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.admin_panel_settings,
                                      color: AppColors.black,
                                      size: isTablet?42:24,
                                    ),

                                    CustomText(
                                      color: AppColors.black_80,
                                      left: 14.w,
                                      text: "Administrator",
                                      fontSize: 14,
                                      fontWeight:status == "administrator"? FontWeight.w600:FontWeight.w400,
                                    ),
                                  ],
                                ),

                                status == "administrator"? Icon(
                                  Icons.check,
                                  color: AppColors.black,
                                ):SizedBox(),

                              ],
                            ),
                          ),
                        ),
                      ),

                      ///====================== settings ======================>
                      customRow(
                          title: "settings",
                          icon: Icons.settings,
                          isTablet: isTablet,
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
                          isTablet: isTablet,
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed(AppRoutes.aboutUsScreen);
                          }),

                      ///====================== privacyPolicy ======================>
                      customRow(
                          title: AppStrings.privacyPolicy,
                          icon: Icons.privacy_tip,
                          isTablet: isTablet,
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed(AppRoutes.privacyPolicyScreen);
                          }),

                      ///====================== termsAndConditions ======================>
                      customRow(
                          title: AppStrings.termsAndConditions,
                          icon: Icons.task_rounded,
                          isTablet: isTablet,
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed(AppRoutes.termsConditionScreen);
                          }),

                      const Divider(
                        height: 2,
                      ),

                      ///====================== Log Out======================>
                      customRow(
                          title: AppStrings.logOut,
                          icon: Icons.logout,
                          isTablet: isTablet,
                          onTap: () {

                            Navigator.pop(context);

                            Get.offNamed(AppRoutes.loginScreen);

                            SharePrefsHelper.remove(AppConstants.bearerToken);
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget customRow(
          {
            required String title,
            IconData? icon,
            required bool isTablet,
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
                    ///Icon(icon,color: AppColors.black_50,),
                    icon != null
                        ? Icon(
                            icon,
                            color: AppColors.black,
                            size: isTablet ?42:24,
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
