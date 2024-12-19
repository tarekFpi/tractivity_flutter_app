// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/nav_bar/organizer_navbar.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/inner_widget/custom_explore_container.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/inner_widget/custom_container_row.dart';
class OrganizerHomeScreen extends StatefulWidget {
   OrganizerHomeScreen({super.key});

  @override
  State<OrganizerHomeScreen> createState() => _OrganizerHomeScreenState();
}

class _OrganizerHomeScreenState extends State<OrganizerHomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final OrganizerController organizerController = Get.find<OrganizerController>();

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeSideDrawer(),
      //drawerScrimColor: Colors.black,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                Icons.menu,
                color: AppColors.primary,
              ));
        }),
        title: Text(
          "ServeOut",
          style: TextStyle(
              color: AppColors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
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
            ///=============== Recemt Events Tab Bar ===============
            SizedBox(height: 20,),
            CustomTabSingleText(
                tabs: organizerController.nameList,
                selectedIndex: organizerController.currentIndex.value,
                onTabSelected: (value) {
                  organizerController.currentIndex.value = value;
                  setState(() {});
                },
                selectedColor: AppColors.primary,
                unselectedColor: AppColors.grey_1
            ),
            SizedBox(height: 20,),
            ///============ Recent Event ========
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                if(organizerController.currentIndex.value ==0)
                  Column(
                      children: List.generate(2, (index) {
                        /*return CustomExploreContainer(
                          image: AppConstants.profileImage,
                          title: "Cox’s Bazar Beach Helping Peolple",
                          location: "Cox’s Bazar, Bangladesh",
                          leaderName: "Mehedi",
                        );*/
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            children: [

                              CustomNetworkImage(
                                imageUrl: AppConstants.profileImage,
                                height: 170.h,
                                width: 170.h,
                                borderRadius: BorderRadius.circular(10),
                              ),

                              SizedBox(
                                width: 10,
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: CustomText(
                                      textAlign: TextAlign.start,
                                      text: "Cox’s Bazar Beach Helping Peolple",
                                      maxLines: 3,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      bottom: 5,
                                    ),
                                  ),
                                  /// Location
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: AppColors.black,
                                        size: 20,
                                      ),
                                      CustomText(
                                        text: "Cox’s Bazar, Bangladesh",
                                        fontSize: 12,
                                        color: AppColors.black_80,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Leader
                                  Row(
                                    children: [
                                      CustomNetworkImage(
                                        imageUrl: AppConstants.profileImage,
                                        height: 30,
                                        width: 30,
                                        boxShape: BoxShape.circle,
                                      ),
                                      CustomText(
                                        text: "Cox’s Bazar",
                                        fontSize: 12,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                        right: 10.w,
                                        left: 10.w,
                                      ),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.exploreEventScreen);
                                          storage.write("status","organize_page");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: CustomText(
                                            text:"Explore",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
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
      bottomNavigationBar: OrganizerNavbar(currentIndex: 0,),
    );
  }
}
