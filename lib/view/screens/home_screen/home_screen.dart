// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/main.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_selected.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/home_screen/salon_homepage_drawer.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/inner_widget/custom_container_row.dart';

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
      drawerScrimColor: Colors.black,
      appBar: CustomRoyelAppbar(
        titleName: "ServeOut",
        rightIcon: AppIcons.notification,
        rightOnTap: (){
         Get.toNamed(AppRoutes.notificationScreen);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0,left: 12,right: 12),
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

              Card(
                elevation: 1.55,
                child: CustomTextField(
                    hintText: AppStrings.searchEvent,
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColors.black_60,
                    )),
              ),

              SizedBox(
                height: 12.h,
              ),

              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    border: Border.all(color: Colors.blueAccent,),
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
                          ),

                          CustomButton(
                            onTap: () {},
                            title: "Explore",
                            width: 90.w,
                            height: 32.h,
                            textColor: AppColors.black,
                            fillColor: AppColors.white,
                            isBorder: true,
                            fontSize: 14,
                            borderWidth: .5,
                          ),
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
                  children: List.generate(2, (index) {
                return CustomContainerRow();
              })),

              Row(
                children: [
                  CustomText(
                    text: "Complete Event",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.indigoAccent,
                  )
                ],
              ),

              SizedBox(
                height: 12.h,
              ),

              Column(
                  children: List.generate(2, (index) {
                return CustomContainerRow();
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
