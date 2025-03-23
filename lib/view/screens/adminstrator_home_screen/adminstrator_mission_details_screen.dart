/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';

class AdminstratorMissionDetailsScreen extends StatefulWidget {
  const AdminstratorMissionDetailsScreen({super.key});

  @override
  State<AdminstratorMissionDetailsScreen> createState() => _AdminstratorMissionDetailsScreenState();
}

class _AdminstratorMissionDetailsScreenState extends State<AdminstratorMissionDetailsScreen> {


  String missionId="";

  final administratorController = Get.put(AdministratiorController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["missionId"]!=null){

      missionId = Get.arguments[0]["missionId"];

      administratorController.retriveSpecificMissionByMissionShow(missionId);
      administratorController.retriveAllEventByMissionShow(missionId);

    }
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
     appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Mission Details",
       ),
        body: RefreshIndicator(child:
        ListView(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomText(
                    textAlign: TextAlign.start,
                    text: "Organization",
                    fontSize:isTablet?6.sp: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    bottom: 5,
                  ),

                  CustomText(
                    text: "Mission Horizons Foundation",
                    fontSize:isTablet?6.sp: 16.sp,
                    color: AppColors.black_80,
                    fontWeight: FontWeight.w600,
                    bottom: 6.h,
                  ),

                  CustomText(
                    text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                    fontSize: 12,
                    color: AppColors.black_02,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    maxLines: 3,
                    bottom: 4.h,// Add ellipsis at the end if the text overflows.
                  ),

                  Divider(
                    color: Colors.black54,
                    // height: 16.h,
                  ),

                  CustomText(
                    textAlign: TextAlign.start,
                    text: "Organizer",
                    fontSize:isTablet?6.sp: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    bottom: 8.h,
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Row(
                            children: [

                              CustomNetworkImage(
                                imageUrl: AppConstants.profileImage,
                                height:isTablet?64.h: 60.h,
                                width:isTablet?64.w: 60.w,
                                boxShape: BoxShape.circle,
                              ),

                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Mehedi Hassan",
                                    fontSize:isTablet?8.sp:12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                  CustomText(
                                    text: "Student",
                                    fontSize:isTablet?6.sp: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black_80,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10.r),
                            // border: Border.all(color: AppColors.primary,width: 2),
                          ),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Center(
                                child: CustomText(
                                  text: "Remove",
                                  color: AppColors.white,
                                  fontSize:isTablet?6.sp: 12.sp,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),


                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl: AppConstants.profileImage,
                                height:isTablet?64.h: 60.h,
                                width:isTablet?64.w: 60.w,
                                boxShape: BoxShape.circle,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Farhad Hossain",
                                    fontSize:isTablet?8.sp:12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                  CustomText(
                                    text: "Student",
                                    fontSize:isTablet?6.sp: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black_80,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),


                        Row(

                          children: [

                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.black_04,
                                borderRadius: BorderRadius.circular(10.r),
                                // border: Border.all(color: AppColors.primary,width: 2),
                              ),
                              child: GestureDetector(
                                onTap: (){

                                },
                                child:  Center(
                                    child: CustomText(
                                      text: "Invited",
                                      color: AppColors.white,
                                      fontSize:isTablet?6.sp: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ),

                            SizedBox(
                              width: 8.w,
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10.r),
                                // border: Border.all(color: AppColors.primary,width: 2),
                              ),
                              child: GestureDetector(
                                onTap: (){

                                },
                                child:  Center(
                                    child: CustomText(
                                      text: "Remove",
                                      color: AppColors.white,
                                      fontSize:isTablet?6.sp: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),



                  const Divider(
                    color: Colors.black54,
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      CustomText(
                        textAlign: TextAlign.start,
                        text: "Events List",
                        fontSize:isTablet?6.sp: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        bottom: 8.h,
                      ),

                      CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.missionEventReportScreen);
                        },
                        title: "Report",
                        height:isTablet?40.h: 35.h,
                        width: 100.w,
                        textColor: AppColors.white,
                        fillColor: AppColors.primary,
                        fontSize: 12,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 16.h,
                  ),
                  Column(
                      children: List.generate(3, (index) {

                        return  Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            children: [

                              CustomNetworkImage(
                                imageUrl: AppConstants.eventImage,
                                height: isTablet ? 200.h : 170.h,
                                width: isTablet ? 180.w : 170.w,
                                borderRadius: BorderRadius.circular(10),
                              ),

                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(
                                    width: 150.w,
                                    child: CustomText(
                                      textAlign: TextAlign.start,
                                      text: "Cox’s Bazar Beach Helping Peolple"!,
                                      maxLines: 3,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      bottom: 5,
                                    ),
                                  ),
                                  /// Location
                                  const Row(
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  /// Leader
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
                                      const CustomText(
                                        text: "Leader",
                                        fontSize: 14,
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),

                                  CustomText(
                                    text: "working Time:18:30 Hours \n Millage:18:30 Hours",
                                    fontSize:isTablet?6.sp: 8.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                    textAlign: TextAlign.start,
                                  ),

                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      GestureDetector(
                                        onTap: () {

                                          Get.toNamed(AppRoutes.adminstratorEventDetailsScreen);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child:  CustomText(
                                            text:  "Explore",
                                            fontSize:isTablet?6.sp: 12.sp,
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
                  )
                ],
              ),
            )
          ],
        ), onRefresh: ()async{
          await administratorController.retriveSpecificMissionByMissionShow(missionId);
          await  administratorController.retriveAllEventByMissionShow(missionId);
        })
      );
    });
  }
}
*/
