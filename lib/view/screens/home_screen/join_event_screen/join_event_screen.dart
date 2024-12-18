// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_selected.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/inner_widget/custom_explore_container.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/inner_widget/custom_container_row.dart';
class JoinEventScreen extends StatefulWidget {
  const JoinEventScreen({super.key});

  @override
  State<JoinEventScreen> createState() => _JoinEventScreenState();
}

class _JoinEventScreenState extends State<JoinEventScreen> {
  final EventsController eventsController = Get.find<EventsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Mission",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            ///================= Profile Image , Name and Location
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
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
                    ),

                  ],
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.neutral02,
                    borderRadius: BorderRadius.circular(10),
                  ),child: CustomText(text: "Working Time : 6:30 hours",fontSize: 12,fontWeight: FontWeight.w400,),
                ),
                SizedBox(width: 8,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.neutral02,
                    borderRadius: BorderRadius.circular(10),
                  ),child: CustomText(text: "Millage : 8km",fontSize: 12,fontWeight: FontWeight.w400,),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomTabSelector(
                tabs: eventsController.joinEvenNameList,
                selectedIndex: eventsController.currentIndex.value,
                onTabSelected: (value) {
                  eventsController.currentIndex.value = value;
                  setState(() {});
                },
                selectedColor: AppColors.primary,
                unselectedColor: AppColors.black),
            SizedBox(
              height: 20,
            ),
            ///============ Recent Event ========
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  if(eventsController.currentIndex.value ==0)
                    Column(
                        children: List.generate(2, (index) {
                          return CustomExploreContainer(
                            image: AppConstants.profileImage,
                            title: "Cox’s Bazar Beach Helping Peolple",
                            location: "Cox’s Bazar, Bangladesh",
                            leaderName: "Mehedi",
                          );
                        })
                    ),
                  ///============ Complete Event ========
                  if(eventsController.currentIndex.value ==1)
                    Column(
                        children: List.generate(5, (index) {
                          return CustomExploreContainer(
                            showDeliveryButtton: true,
                            btnOne: "Approved",
                            btnTwo: "Delete",
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
      bottomNavigationBar: NavBar(currentIndex: 3),
    );
  }
}
