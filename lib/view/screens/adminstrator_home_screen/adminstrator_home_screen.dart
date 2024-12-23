// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_images/app_images.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/nav_bar/adminstrator_navbar.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';
class AdminstratorHomeScreen extends StatefulWidget {
  const AdminstratorHomeScreen({super.key});

  @override
  State<AdminstratorHomeScreen> createState() => _AdminstratorHomeScreenState();
}

class _AdminstratorHomeScreenState extends State<AdminstratorHomeScreen> {
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
          "JoinUp",
          style: TextStyle(
              color: AppColors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
     actions: [
         GestureDetector(
           onTap: (){
             Get.toNamed(AppRoutes.eventCompleteScreen);
           },
           child: Padding(
             padding: const EdgeInsets.only(right: 12),
             child: CustomImage(imageSrc: AppIcons.bookmark),
           ),
         )
    ],
      ),
      body: Obx(
        () {
          return SingleChildScrollView(
            child: Padding(
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
                      tabs: organizerController.adminstratiorNameList,
                      selectedIndex: organizerController.adminstratior_currentIndex.value,
                      onTabSelected: (value) {
                        organizerController.adminstratior_currentIndex.value = value;
                        setState(() {});
                      },
                      selectedColor: AppColors.primary,
                      unselectedColor: AppColors.grey_1
                  ),

                  SizedBox(height: 20,),


                  ///============ Recent  Event ========
                  if(organizerController.adminstratior_currentIndex.value==0)
                  Column(
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.grey_5.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.only(top: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    CustomText(
                                      text: "${index+1} .",
                                      fontSize: 16,
                                      color: AppColors.black_80,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    CustomText(
                                      text: "Global Horizons Foundation",
                                      fontSize: 16,
                                      color: AppColors.black_80,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    CustomText(
                                      text: "22-12-2025",
                                      fontSize: 12,
                                      color: AppColors.black_80,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 4,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 12,right: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Flexible(
                                        child: SizedBox(
                                          width: 250,
                                          child: CustomText(
                                            text: "Empowering communities  worldwide \n through education, healthcare,\n and sustainable development initiatives.",
                                            fontSize: 12,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),

                                      CustomButton(
                                        onTap: () {

                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              backgroundColor: Colors.white,
                                              insetPadding: EdgeInsets.all(8),
                                              contentPadding: EdgeInsets.all(8),
                                              title: SizedBox(),
                                              content: SizedBox(
                                                width: MediaQuery.sizeOf(context).width,
                                                child: AlertDialogEvent(title: "Are you sure you want to \n delete ?",discription: "",),
                                              ),
                                            ),
                                          );

                                        },
                                        title: "Delete",
                                        width: 60.w,
                                        height: 32.h,
                                        textColor: AppColors.black,
                                        fillColor: AppColors.primary,
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })),

                  if(organizerController.adminstratior_currentIndex.value==1)
                    Column(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: AppColors.grey_5.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.only(top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      CustomText(
                                        text: "${index+1} .",
                                        fontSize: 16,
                                        color: AppColors.black_80,
                                        fontWeight: FontWeight.w600,
                                      ),

                                      CustomText(
                                        text: "Global Horizons Foundation",
                                        fontSize: 16,
                                        color: AppColors.black_80,
                                        fontWeight: FontWeight.w600,
                                      ),

                                      CustomText(
                                        text: "22-12-2025",
                                        fontSize: 12,
                                        color: AppColors.black_80,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 4,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 12,right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Flexible(
                                          child: SizedBox(
                                            width: 250,
                                            child: CustomText(
                                              text: "Empowering communities  worldwide \n through education, healthcare,\n and sustainable development initiatives.",
                                              fontSize: 12,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),

                                        Column(
                                          children: [

                                            CustomButton(
                                              onTap: () {

                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    insetPadding: EdgeInsets.all(8),
                                                    contentPadding: EdgeInsets.all(8),
                                                    //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    title: SizedBox(),
                                                    content: SizedBox(
                                                      width: MediaQuery.sizeOf(context).width,
                                                      child: AlertDialogEvent(title: "Are you sure you want to \n delete ?",discription: "",),
                                                    ),
                                                  ),
                                                );
                                              },
                                              title: "Delete",
                                              width: 60.w,
                                              height: 32.h,
                                              textColor: AppColors.black,
                                              fillColor: AppColors.primary,
                                              fontSize: 12,
                                            ),

                                            SizedBox(
                                              height: 8,
                                            ),

                                            CustomButton(
                                              onTap: () {

                                                storage.write("status","report_page");

                                             ///   Get.toNamed(AppRoutes.exploreEventScreen);
                                              },
                                              title: "Report",
                                              width: 60.w,
                                              height: 32.h,
                                              textColor: AppColors.black,
                                              fillColor: AppColors.primary,
                                              fontSize: 12,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                     })),
                ],
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: AdminstratorNavbar(currentIndex: 0,),
    );
  }
}
