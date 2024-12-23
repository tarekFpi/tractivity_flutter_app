// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/view/screens/friend_screen/friend_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/home_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_home_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_invite_mission_screen/organizer_invite_mission_screen.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_icons/app_icons.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../custom_text/custom_text.dart';
class OrganizerNavbar extends StatefulWidget {
  final int currentIndex;
  const OrganizerNavbar({required this.currentIndex, super.key});

  @override
  State<OrganizerNavbar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<OrganizerNavbar> {
  late int bottomNavIndex;

  final List<String> selectedIcon = [
    AppIcons.home,
    AppIcons.userAdd,

  ];
  final List<String> unselectedIcon = [
    AppIcons.home,
    AppIcons.userAdd,

  ];

  final List<String> userNavText = [
    AppStrings.home,
    AppStrings.organizer,

  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      // color: AppColors.dartBlue,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(40.r), topLeft: Radius.circular(40.r)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.lightWhite, AppColors.lightWhite])),
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          selectedIcon.length,
              (index) => InkWell(
            onTap: () => onTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                index == bottomNavIndex
                    ? Card(
                  elevation: 90,
                  shadowColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(50),
                        topRight: Radius.circular(50)
                    ),
                  ),
                  color: Colors.transparent,
                  child: Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(50),
                          topRight: Radius.circular(50)
                      ),
                    ),
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            selectedIcon[index],
                            height: 24.h,
                            width: 24.w,
                            color: AppColors.white,
                          ),
                        ),

                        CustomText(
                          text: userNavText[index],
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.w,
                        ),

                      ],
                    ),
                  ),
                )
                    : SvgPicture.asset(
                  unselectedIcon[index],
                  height: 24.h,
                  width: 24.w,
                  color: AppColors.primary,
                ),
                SizedBox(height: 4.h),
                index == bottomNavIndex
                    ? const SizedBox()
                    : CustomText(
                  text: userNavText[index],
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index != bottomNavIndex) {
      switch (index) {
        case 0:
          Get.offAll(() => OrganizerHomeScreen());
          break;
        case 1:
          Get.to(() => OrganizerInviteMissionScreen());
          break;
     /*   case 2:
          Get.to(() => MassageListScreen());
          break;
        case 3:
          Get.to(() => CreateTeamScreen());
          break;*/
      }
    }
  }
}