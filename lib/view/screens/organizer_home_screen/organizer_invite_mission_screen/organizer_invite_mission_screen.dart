// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/nav_bar/organizer_navbar.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/inner_widget/custom_explore_container.dart';
import 'package:tractivity_app/view/screens/home_screen/salon_homepage_drawer.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_invite_mission_screen/%20inner_widget/custom_invite_mission_container.dart';

class OrganizerInviteMissionScreen extends StatefulWidget {
  const OrganizerInviteMissionScreen({super.key});

  @override
  State<OrganizerInviteMissionScreen> createState() =>
      _OrganizerInviteMissionScreenState();
}

class _OrganizerInviteMissionScreenState
    extends State<OrganizerInviteMissionScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final OrganizerController organizerController =
      Get.find<OrganizerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomRoyelAppbar(
        titleName: "Mission",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
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

            ///=============== Invite Mission Event List Tab Bar ===============
            SizedBox(
              height: 20,
            ),
            CustomTabSingleText(
                tabs: organizerController.inviteMissionNameList,
                selectedIndex: organizerController.currentIndex.value,
                onTabSelected: (value) {
                  organizerController.currentIndex.value = value;
                  setState(() {});
                },
                selectedColor: AppColors.primary,
                unselectedColor: AppColors.grey_1),
            SizedBox(
              height: 20,
            ),

            ///============ Recent Event ========
            Expanded(
              child: ListView(
                children: [
                  if (organizerController.currentIndex.value == 0)
                    Column(
                      children: List.generate(3, (index){
                        return CustomInviteMissionContainer();
                      })
                    ),
                  ///============ Complete Event ========
                  if(organizerController.currentIndex.value ==1)
                    Column(
                        children: List.generate(5, (index) {
                          return CustomExploreContainer(
                            showDeliveryButtton: true,
                            image: AppConstants.profileImage,
                            title: "Cox’s Bazar Beach Helping Peolple",
                            location: "Cox’s Bazar, Bangladesh",
                            leaderName: "Mehedi",
                          );
                        })
                    ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: OrganizerNavbar(
        currentIndex: 1,
      ),
    );
  }
}
