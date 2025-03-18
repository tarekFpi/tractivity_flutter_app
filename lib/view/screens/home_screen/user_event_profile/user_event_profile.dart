// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_selected.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/user_profile_screen.dart';

class UserEventProfile extends StatefulWidget {
  const UserEventProfile({super.key});

  @override
  State<UserEventProfile> createState() => _UserEventProfileState();
}

class _UserEventProfileState extends State<UserEventProfile> {

  final eventsController = Get.find<EventsController>();

  final eventController = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Profile",
        ),
        body: SingleChildScrollView(
          child: Obx(
            () {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [

                    ///================= Profile Image , Name and Location
                    UserProfileScreen(),

                    SizedBox(
                      height: 20.h,
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ///========== volunteer =========
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CustomText(
                              text:"Details",
                              fontSize: isTablet?9.sp: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),

                            CustomButton(
                              onTap: () {
                             Get.toNamed(AppRoutes.volunteerEventReportScreen);
                              },
                              title: "Report",
                              height:isTablet?40.h: 35.h,
                              width: 80.w,
                              textColor: AppColors.white,
                              fillColor: AppColors.primary,
                              fontSize: 12,
                            ),
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
                          text: "${eventController.userProfileShowList.value.fullName}",
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
                          text: "${eventController.userProfileShowList.value.profession}",
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
                          text: "${eventController.userProfileShowList.value.phone}",
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
                          text: "${eventController.userProfileShowList.value.email}",
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
                          text: "${eventController.userProfileShowList.value.address}",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          maxLines: eventController.userProfileShowList.value.address?.length,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          ),
        ),
      );
    });
  }
}
