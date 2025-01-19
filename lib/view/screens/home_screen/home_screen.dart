// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
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
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeController homeController = Get.find<HomeController>();

  final storage =   GetStorage();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    storage.write("status", "volunteer");
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        key: _scaffoldKey,
        drawer: HomeSideDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu, color: AppColors.primary,size: isTablet?28.w:24.w
                  ,),
              );
            },
          ),
          title: Text(
            AppStrings.serveOut,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.notificationScreen);
              },
              icon: Icon(Icons.notifications_active_outlined, color: AppColors.black),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 12),
          child: Obx(() {

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? 20 : 12),

                  /// Profile Section**
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.eventsProfileScreen);
                    },
                    child: Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: AppConstants.profileImage,
                          height: isTablet ? 120 : 100,
                          width: isTablet ? 120 : 100,
                          boxShape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 3),
                        ),
                        SizedBox(width: isTablet ? 15 : 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Mehedi Bin Ab. Salam",
                              fontSize: isTablet ? 24 : 20,
                              fontWeight: FontWeight.w500,
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: AppColors.primary, size: isTablet ? 24 : 20),
                                CustomText(
                                  text: "Bushwick Brooklyn, NY, USA",
                                  fontSize: isTablet ? 14 : 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: isTablet ? 20 : 12),

                  /// **Search Bar**
                  CustomTextField(
                    hintText: AppStrings.searchEvent,
                    fillColor: AppColors.neutral02,
                    suffixIcon: Icon(Icons.search, color: AppColors.black_60),
                  ),

                  SizedBox(height: isTablet ? 20 : 12),

                  /// **Event Banner**
                  Container(
                    width: double.infinity,
                    height: isTablet ? 230 : 140,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.2),
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Complete Event',
                                  style: TextStyle(fontSize: isTablet ? 28 : 24, fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: '\nDetails',
                                      style: TextStyle(fontSize: isTablet ? 28 : 24, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  CustomButton(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.exoloreEventCompletedScreen);
                                    },
                                    title: "Explore",
                                    width: isTablet ? 170 : 90,
                                    height: isTablet ? 60 : 32,
                                    fontSize: isTablet ? 16 : 14,
                                    textColor: AppColors.black,
                                    fillColor: AppColors.white,
                                    isBorder: true,
                                    borderWidth: .6,
                                  ),
                                  SizedBox(width: 10),

                                  CustomButton(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.donationScreen);
                                    },
                                    title: "Donation",
                                    width: isTablet ? 170 : 90,
                                    height: isTablet ? 60 : 32,
                                    fontSize: isTablet ? 16 : 14,
                                    textColor: AppColors.black,
                                    fillColor: AppColors.white,
                                    isBorder: true,
                                    borderWidth: .6,
                                  ),

                                ],
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            AppIcons.icon1,
                            height: isTablet ? 120 : 100,
                            width: isTablet ? 90 : 70,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: isTablet ? 20 : 12),

                  /// **Recent Events Tab Bar**
                  CustomTabSingleText(
                    fontSize: isTablet?24:16,
                    tabs: homeController.nameList,
                    selectedIndex: homeController.home_currentIndex.value,
                    onTabSelected: (value) {
                      homeController.home_currentIndex.value = value;
                      setState(() {});
                    },
                    selectedColor: AppColors.primary,
                    unselectedColor: AppColors.grey_1,
                  ),

                  SizedBox(height: isTablet ? 20 : 8),

                  /// Recent Events List

                  if(homeController.home_currentIndex.value ==0)
                    Column(
                        children: List.generate(6, (index) {

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children: [

                                CustomNetworkImage(
                                  imageUrl: AppConstants.eventImage,
                                  height: isTablet ? 200.h : 170.h,
                                  width: isTablet ? 180.w : 170.w,
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
                                          height: isTablet?45: 30,
                                          width: isTablet?45: 30,
                                          boxShape: BoxShape.circle,
                                        ),
                                        CustomText(
                                          text: "Mehedi",
                                          fontSize: 14,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                          right: 10.w,
                                          left: 10.w,
                                        ),
                                        CustomText(
                                          text: "Leader",
                                          fontSize: 14,
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600,
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

                                            Get.toNamed(AppRoutes.recentEventExploreDetails);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: CustomText(
                                              text:   "Explore",
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
                        })),


                  if (homeController.home_currentIndex.value == 1)
                    Column(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.neutral02,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "Empower Tomorrow",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          bottom: 8.h,
                                        ),
                                        CustomText(
                                          text:
                                          "Fostering opportunities for underprivileged communities through education and skill development programs.",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          maxLines: 5,
                                          textAlign: TextAlign.start,
                                          bottom: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            CustomNetworkImage(
                                              imageUrl: AppConstants.profileImage,
                                              height: 40,
                                              width: 40,
                                              boxShape: BoxShape.circle,
                                            ),
                                            CustomText(
                                              text: "Mehedi",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              left: 8.h,
                                              right: 8.h,
                                            ),
                                            CustomText(
                                              text: "(Adminstrator)",
                                              fontSize: 14,
                                              color: AppColors.blue,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      CustomText(
                                        text: "17-12-2024",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        bottom: 8.h,
                                      ),
                                      CustomButton(
                                        onTap: () {
                                          ///OrganizerApprovedScreen

                                          Get.toNamed(AppRoutes.organizeDetailsScreen);
                                        },
                                        title: "Details",
                                        height:isTablet?60: 30,
                                        width:isTablet?150: 70,
                                        fontSize: 12,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })),

                  SizedBox(height: isTablet ? 30 : 20),
                ],
              ),
            );
          },
          ),
        ),
        bottomNavigationBar: NavBar(currentIndex: 0),
      );
    });
  }
}

