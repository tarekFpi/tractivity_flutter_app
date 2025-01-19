import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/auth_screen/controller/auth_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';

import 'view/components/custom_tab_selected/custom_tab_single_text.dart';

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({super.key});

  @override
  State<MyTestScreen> createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
// drawerScrimColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                Icons.menu,
                color: AppColors.primary,
              ));
        }),
        title: Text(
          "JoinUp",
          style: TextStyle(
              color: AppColors.black, fontSize: 30, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.notificationScreen);
            },
            icon: Icon(
              Icons.notifications_active_outlined,
              color: AppColors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),

                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.eventsProfileScreen);
                  },
                  child: Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: AppConstants.profileImage,
                        height: 100,
                        width: 100,
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
                ),

                SizedBox(
                  height: 12.h,
                ),

                ///============ search ======================================
                CustomTextField(
                    hintText: AppStrings.searchEvent,
                    fillColor: AppColors.neutral02,
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColors.black_60,
                    )),

                SizedBox(
                  height: 12.h,
                ),

                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(
                                text: 'Complete Event',
                                style: TextStyle(
                                    fontSize: 24.sp, fontWeight: FontWeight.w600),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '\nDetails',
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600),
                                  )
                                ])),
                            Row(
                              children: [
                                CustomButton(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.exoloreEventCompletedScreen);
                                  },
                                  title: "Explore",
                                  width: 90.w,
                                  height: 32.h,
                                  textColor: AppColors.black,
                                  fillColor: AppColors.white,
                                  isBorder: true,
                                  fontSize: 14,
                                  borderWidth: .6,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                CustomButton(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.donationScreen);
                                  },
                                  title: "Donation",
                                  width: 90.w,
                                  height: 32.h,
                                  textColor: AppColors.black,
                                  fillColor: AppColors.white,
                                  isBorder: true,
                                  fontSize: 14,
                                  borderWidth: .5,
                                ),
                              ],
                            )
                          ],
                        ),
                        SvgPicture.asset(
                          AppIcons.icon1,
                          height: 100,
                          width: 70,
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          );
        }),
      ),

      bottomNavigationBar: NavBar(
        currentIndex: 0,
      ),
    );
  }
}
