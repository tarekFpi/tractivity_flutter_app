// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/inner_widget/custom_setting_row.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  //final SettingController settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
          appBar: CustomRoyelAppbar(
            leftIcon: true,
            titleName: AppStrings.setting,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                /// height: MediaQuery.sizeOf(context).height / 2.5,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: AppColors.white_50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 40),
                  child: Column(
                    children: [

                      ///======= Profile Person====
                      CustomSettingRow(
                          onTap: (){
                            Get.toNamed(AppRoutes.userEventProfile);
                          },
                          text: AppStrings.profileSetting,
                          isTablet: isTablet,
                          icon: Icons.person),

                      ///======= about ====

                      CustomSettingRow(
                          onTap: (){
                            Get.toNamed(AppRoutes.aboutUsScreen);
                          },
                          text: AppStrings.aboutus,
                          isTablet: isTablet,
                          icon: Icons.info_outline),

                      ///======= privacyPolicy ====

                      CustomSettingRow(
                          onTap: (){
                            Get.toNamed(AppRoutes.privacyPolicyScreen);
                          },
                          text: AppStrings.privacyPolicy,
                          isTablet: isTablet,
                          icon: Icons.privacy_tip_outlined),

                      ///======= termsAndConditions ====

                      CustomSettingRow(
                          onTap: (){
                            Get.toNamed(AppRoutes.termsConditionScreen);
                          },
                          text: AppStrings.termsAndConditions,
                          isTablet: isTablet,
                          icon: Icons.align_vertical_bottom_outlined),

                      ///======= termsAndConditions ====

                      CustomSettingRow(
                          onTap: (){
                            Get.toNamed(AppRoutes.loginScreen);
                          },
                          text: AppStrings.logOut,
                          isTablet: isTablet,
                          icon: Icons.logout),

                      SizedBox(height: 30.h,),

                      ///======= termsAndConditions ==============

                      CustomSettingRow(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: Colors.white,
                                insetPadding: EdgeInsets.all(8),
                                contentPadding: EdgeInsets.all(8),
                                title: SizedBox(),
                                content: SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: AlertDialogEvent(title: "Are you sure you want to \n delete ?",discription: "",),
                                ),
                              ),
                            );
                          },
                          text: AppStrings.deleteAccount,
                          color: AppColors.primary,
                          textColor: AppColors.primary,
                          isTablet: isTablet,
                          icon: Icons.delete_sweep_outlined),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
