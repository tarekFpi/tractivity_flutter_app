// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/view/screens/chat_screen/massage_list_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/create_team_screen.dart';
import 'package:tractivity_app/view/screens/friend_screen/friend_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/exolore_event_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/home_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/join_event_screen/join_event_screen.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_icons/app_icons.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../custom_text/custom_text.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<NavBar> {

  late int bottomNavIndex;

  final List<String> selectedIcon = [
    AppIcons.home,
    AppIcons.users,
    AppIcons.mail,
    AppIcons.pencilalt,
  ];

  final List<String> unselectedIcon = [
    AppIcons.home,
    AppIcons.users,
    AppIcons.mail,
    AppIcons.pencilalt,
  ];

  final List<String> userNavText = [
    AppStrings.home,
    AppStrings.friend,
    AppStrings.messages,
    AppStrings.team,
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
         ),
      height: 95.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          selectedIcon.length,
              (index) => GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                index == bottomNavIndex
                    ? Card(
                  elevation: 85,
                 shadowColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)
                    ),
                  ),
                  color: Colors.transparent,
                  child: Container(
                    height: 85.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                     color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          selectedIcon[index],
                          height: 24.h,
                          width: 24.w,
                          color: AppColors.white,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        CustomText(
                          text: userNavText[index],
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.w,
                        ),
                      ],
                    ),
                  ),
                )
                    : Column(
                  children: [
                    SvgPicture.asset(
                      unselectedIcon[index],
                      height: 24.h,
                      width: 24.w,
                      color: AppColors.primary,
                    ),

                    SizedBox(
                      height: 4,
                    ),
                    CustomText(
                      text: userNavText[index],
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.w,
                    ),
                  ],
                ),


                /*index == bottomNavIndex
                    ? CustomText(
                  text: userNavText[index],
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.w,
                )
                    : CustomText(
                  text: userNavText[index],
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.w,
                ),*/
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
        Get.offAll(() => HomeScreen());
          break;
        case 1:
          Get.to(() => FriendScreen());
          break;
        case 2:
          Get.to(() => MassageListScreen());
          break;
        case 3:
          Get.to(() => JoinEventScreen());
          break;
      }
    }
  }
}