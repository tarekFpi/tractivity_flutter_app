// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_images/app_images.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/nav_bar/adminstrator_navbar.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
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

  final administratorController = Get.put(AdministratiorController());

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

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
                  size: isTablet?28.w:24.w
                ));
          }),
          title: Text(
            AppStrings.serveOut,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600),
          ),
          actions: [

            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.eventCompleteScreen);
              },
              child: Padding(
                padding:  EdgeInsets.only(right: 16.h,),
                child: CustomImage(imageSrc: AppIcons.bookmark,width: isTablet?28.h:24.h,height:isTablet?28.h:24.h,),
              ),
            )
          ],
        ),
        body: Obx(
                () {
              return SingleChildScrollView(
                child: Padding(
                  padding:   EdgeInsets.symmetric(horizontal: 8,vertical: isTablet?28:0),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 100.h,
                            width: 100.w,
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
                          fontSize: isTablet?24:16,
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

                        administratorController.organizationShowLoading.value?CustomLoader():
                        Column(
                            children: List.generate(administratorController.organizationShowList.length, (index) {

                              final model = administratorController.organizationShowList[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:isTablet?140.h: 130.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey_5.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            CustomText(
                                              text: "${index+1}.${model.name}",
                                              fontSize: 16,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w600,
                                            ),

                                            CustomText(
                                              text: DateConverter.timeFormetString("${model.createdAt}"),
                                              fontSize: 12,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 6,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Flexible(
                                              child: SizedBox(
                                                width:isTablet?300.w: 250.w,
                                                child: CustomText(
                                                  text: "${model.description}",
                                                  fontSize: 12,
                                                  color: AppColors.black_80,
                                                  fontWeight: FontWeight.w400,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                            ),

                                            administratorController.organizationDeleteLoading.value?CircularProgressIndicator(color: AppColors.primary,):
                                            CustomButton(
                                              onTap: () {

                                                administratorController.organizationDelete("${model.id}");
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
                            children: List.generate(administratorController.missionShowList.length, (index) {

                              final model =administratorController.missionShowList[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:isTablet?140.h: 130.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey_5.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            CustomText(
                                              text: "${index+1}.${model.name}",
                                              fontSize: 16,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w600,
                                            ),

                                            CustomText(
                                              text: DateConverter.timeFormetString("${model.createdAt}"),
                                              fontSize: 12,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            SizedBox(
                                              width:isTablet?300.w: 250.w,
                                              child: CustomText(
                                                text: "${model.description}",
                                                fontSize: 12,
                                                color: AppColors.black_80,
                                                fontWeight: FontWeight.w400,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,// Add ellipsis at the end if the text overflows.
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
                                                        title: SizedBox(),
                                                        content: SizedBox(
                                                          width: MediaQuery.sizeOf(context).width,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [

                                                                const CustomText(
                                                                  text:"Are you sure you want to \n delete ?",
                                                                  fontSize: 22,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: AppColors.black_80,
                                                                ),

                                                                SizedBox(
                                                                  height: 8.h,
                                                                ),

                                                                administratorController.missionDeleteLoading.value?CustomLoader():
                                                                CustomButton(onTap: (){

                                                                  administratorController.missionDelete(model.id.toString());

                                                                  if(administratorController.missionDeleteLoading.value){
                                                                    Navigator.of(context).pop();
                                                                  }

                                                                },title:"Yes",height:isTablet?70.h: 45.h,fontSize: 12.sp,),

                                                                SizedBox(
                                                                  height: 12.h,
                                                                ),
                                                                CustomButton(onTap: (){
                                                                  Navigator.of(context).pop();
                                                                },title:"NO",height:isTablet?70.h: 45.h,
                                                                  fontSize: 12.sp,fillColor: AppColors.white,
                                                                  textColor: AppColors.primary,
                                                                  isBorder: true,borderWidth: 1,)
                                                              ],
                                                            ),
                                                          ),
                                                          //  child: AlertDialogEvent(title: "Are you sure you want to \n delete ?",discription: "",),
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
                                                  height:isTablet?12.h: 8.h,
                                                ),

                                                CustomButton(
                                                  onTap: () {

                                                    Get.toNamed(AppRoutes.adminstratiorEventListScreen,arguments: [
                                                      {
                                                        "missionId":model.id,
                                                      }
                                                    ]);
                                                  },
                                                  title: "Details",
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
    });
  }
}
