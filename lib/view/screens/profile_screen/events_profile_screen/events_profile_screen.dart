// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_selected.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/inner_widget/custom_container_row.dart';

class EventsProfileScreen extends StatefulWidget {
  EventsProfileScreen({super.key});

  @override
  State<EventsProfileScreen> createState() => _EventsProfileScreenState();
}

class _EventsProfileScreenState extends State<EventsProfileScreen> {
  final EventsController eventsController = Get.find<EventsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        rightIcon: AppIcons.setting,
        titleName: "mehedi",
      rightOnTap: (){Get.toNamed(AppRoutes.settingScreen);},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            ///================= Profile Image , Name and Location

            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.unkown,
                  height: 70,
                  width: 70,
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

            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: CustomTabSelector(
                  tabs: eventsController.nameList,
                  selectedIndex: eventsController.currentIndex.value,
                  onTabSelected: (value) {
                    eventsController.currentIndex.value = value;
                    setState(() {});
                  },
                  selectedColor: AppColors.primary,
                  unselectedColor: AppColors.black),
            ),
            SizedBox(
              height: 20,
            ),
            if (eventsController.currentIndex.value == 0)
              Column(
                  children: List.generate(2, (index) {
                return CustomContainerRow();
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
    );
  }
}
