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
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/inner_widget/custom_explore_container.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_invite_mission_screen/%20inner_widget/custom_invite_mission_container.dart';

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
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeSideDrawer(),
      // drawerScrimColor: Colors.black,
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
          "JoinUp",
          style: TextStyle(
              color: AppColors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600),
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
        child: Obx(
            () {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 12.h,
                  ),

                  GestureDetector(
                    onTap: (){
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

                              CustomText(
                                text: "Complete Event \n Details",
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blue,
                                textAlign: TextAlign.start,
                              ),

                              Row(
                                children: [
                                  CustomButton(
                                    onTap: () {
                                       Get.toNamed(AppRoutes.exoloreEventCompletedScreen);
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

                  SizedBox(
                    height: 12.h,
                  ),


                  ///=============== Recemt Events Tab Bar ===============
                  SizedBox(height: 20,),

                  CustomTabSingleText(
                      tabs: homeController.nameList,
                      selectedIndex: homeController.home_currentIndex.value,
                      onTabSelected: (value) {
                        homeController.home_currentIndex.value = value;
                        setState(() {});
                      },
                      selectedColor: AppColors.primary,
                      unselectedColor: AppColors.grey_1
                  ),


                  SizedBox(
                    height: 12.h,
                  ),

                  if(homeController.home_currentIndex.value ==0)
                  Column(
                      children: List.generate(1, (index) {
                  /*  return CustomExploreContainer(
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

                  if(homeController.home_currentIndex.value ==1)
                    Column(
                        children: List.generate(3, (index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
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

                                      CustomButton(onTap: (){
                                        ///OrganizerApprovedScreen

                                        Get.toNamed(AppRoutes.organizeDetailsScreen);
                                      }, title: "Details",height: 30,width: 70,fontSize: 12,),

                                    ],
                                  )


                                ],
                              ),
                            ),
                          );
                        })
                    )

                ],
              ),
            );
          }
        ),
      ),

      bottomNavigationBar: NavBar(
        currentIndex: 0,
      ),
    );
  }
}
