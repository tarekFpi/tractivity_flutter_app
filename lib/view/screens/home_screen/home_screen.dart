// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/inner_widget/custom_explore_container.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          "ServeOut",
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 12.h,
              ),

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
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue,
                          ),
                          Row(
                            children: [
                              CustomButton(
                                onTap: () {
                                   Get.toNamed(AppRoutes.exoloreEventScreen);
                                },
                                title: "Explore",
                                width: 90.w,
                                height: 32.h,
                                textColor: AppColors.black,
                                fillColor: AppColors.white,
                                isBorder: true,
                                fontSize: 14,
                                borderWidth: .5,
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
              CustomText(
                text: "Recent Events",
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(
                height: 12.h,
              ),

              Column(
                  children: List.generate(1, (index) {
                return CustomExploreContainer(
                  image: AppConstants.profileImage,
                  title: "Cox’s Bazar Beach Helping Peolple",
                  location: "Cox’s Bazar, Bangladesh",
                  leaderName: "Mehedi",
                );
              })),

            ],
          ),
        ),
      ),

      bottomNavigationBar: NavBar(
        currentIndex: 0,
      ),
    );
  }
}
