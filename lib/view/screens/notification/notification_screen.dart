
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/main.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';
import 'package:tractivity_app/view/screens/notification/notification_alert.dart';

import '../../components/custom_button/custom_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final   homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homeController.notificationInvitationEventShow();

    homeController.notificationInvitationMissionShow();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: const CustomRoyelAppbar(
          titleName: "Notifications",
          leftIcon: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Obx(
                () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                      text: "Event invitation",
                      fontSize:isTablet?12.sp: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),

                    SizedBox(
                      height: 16.h,
                    ),


                   /// event notification list
                   homeController.notificationInvitationEventLodding.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                    homeController.notificationInvitaionEventList.isEmpty?
                    SizedBox(
                      height: MediaQuery.of(context).size.height/8,
                      child: Center(
                        child: CustomText(
                          text: "No event invitation  yet!!",
                          fontSize:isTablet?12.sp: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightRed,
                        ),
                      ),
                    ):
                    RefreshIndicator(child:ListView.builder(
                       itemCount: homeController.notificationInvitaionEventList.value.length,
                       shrinkWrap: true, //
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {

                         final notificationModel = homeController.notificationInvitaionEventList?[index];

                         return  GestureDetector(
                           onTap: (){
                             Get.toNamed(AppRoutes.joinDetailsScreen,arguments: [
                               {
                                 "eventId":notificationModel?.contentId?.id,
                                 "inviationId":notificationModel?.id
                               }
                             ]);
                           },
                           child: Padding(
                             padding: const EdgeInsets.only(bottom: 12),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [

                                 SvgPicture.asset(
                                   AppIcons.userIcons,
                                   width: isTablet?60.w:45.w,
                                   height: isTablet?60.h:45.h,
                                 ),

                                 SizedBox(
                                     width: 8.w
                                 ),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [

                                     CustomText(
                                       text: "${notificationModel?.contentId?.creator?.name} invite you for a event.",
                                       fontSize: 14,
                                       fontWeight: FontWeight.w600,
                                     ),

                                     const SizedBox(
                                       height: 8,
                                     ),
                                     CustomText(
                                       text: "${DateConverter.timeFormetString2(notificationModel?.contentId?.date.toString())}",
                                       fontSize: 12,
                                       fontWeight: FontWeight.w600,
                                     ),

                                     const SizedBox(
                                       height: 8,
                                     ),

                                     Row(
                                       children: [
                                         homeController.notificationInvitationEventAcceptLodding.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                                         CustomButton(
                                           onTap: () {
                                             /// last parameter id event
                                             homeController.acceptSpecificEvent(notificationModel?.id.toString()??"",false,notificationModel?.contentId?.id.toString()??"");
                                           },
                                           title: "Join",
                                           width: 70.w,
                                           height: 32.h,
                                           textColor: AppColors.black,
                                           fillColor: AppColors.primary,
                                           isBorder: true,
                                           fontSize: 14,
                                         ),

                                         const SizedBox(
                                           width: 12,
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
                                                   ///child: AlertDialogEvent(title: "Are you sure you want to \n Delete this Event?",discription: "",),
                                                   child: SingleChildScrollView(
                                                     child: Padding(
                                                       padding: const EdgeInsets.all(8.0),
                                                       child: Column(
                                                         mainAxisSize: MainAxisSize.min,
                                                         children: [


                                                           CustomText(
                                                             text:"Are you sure you want to \n Delete this Event?",
                                                             fontSize: 22,
                                                             fontWeight: FontWeight.w600,
                                                             color: AppColors.black_80,
                                                           ),

                                                           SizedBox(
                                                             height: 8.h,
                                                           ),

                                                           homeController.eventInvitationDeleteLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                                                           CustomButton(onTap: (){

                                                             homeController.organizationDelete(notificationModel?.id.toString()??"");

                                                             if(homeController.eventInvitationDeleteLoading.value){
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
                                                   ),
                                                 ),
                                               ),
                                             );
                                           },
                                           title: "Delete",
                                           width: 70.w,
                                           height: 32.h,
                                           textColor: AppColors.black,
                                           fillColor: AppColors.white_50,
                                           isBorder: true,
                                           fontSize: 14,
                                         ),
                                       ],
                                     )
                                   ],
                                 )
                               ],
                             ),
                           ),
                         );
                       }), onRefresh: ()async {
                      await  homeController.notificationInvitationEventShow();
                       await   homeController.notificationInvitationMissionShow();
                    }),


                  ///mission invitation details
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomText(
                      text: "Mission invitation",
                      fontSize:isTablet?12.sp: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    homeController.notificationInvitationMissionLodding.value?
                    Center(child: CircularProgressIndicator(color: Colors.orange,)):
                    homeController.notificationInvitaionMissionList.isEmpty?
                    SizedBox(
                      height: MediaQuery.of(context).size.height/8,
                      child: Center(
                        child: CustomText(
                          text: "No mission invitation  yet!!",
                          fontSize:isTablet?12.sp: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightRed,
                        ),
                      ),
                    ):
                    ListView.builder(
                        itemCount: homeController.notificationInvitaionMissionList.value.length,
                        shrinkWrap: true, //
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {

                          final missionModel = homeController.notificationInvitaionMissionList?[index];

                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                SvgPicture.asset(
                                  AppIcons.userIcons,
                                  width: isTablet?60.w:45.w,
                                  height: isTablet?60.h:45.h,
                                ),

                                SizedBox(
                                    width: 8.w
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    CustomText(
                                      text: "${missionModel?.contentId?.creator?.name} invite you for a mission.",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    const SizedBox(
                                      height: 8,
                                    ),
                                      CustomText(
                                      text: "${DateConverter.timeFormetString2(missionModel?.createdAt.toString())}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    const SizedBox(
                                      height: 8,
                                    ),

                                    Row(
                                      children: [
                                        CustomButton(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.joinDetailsScreen);
                                          },
                                          title: "Join",
                                          width: 70.w,
                                          height: 32.h,
                                          textColor: AppColors.black,
                                          fillColor: AppColors.primary,
                                          isBorder: true,
                                          fontSize: 14,
                                        ),

                                        const SizedBox(
                                          width: 12,
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
                                                  child: AlertDialogEvent(title: "Are you sure you want to \n Delete this Event?",discription: "",),
                                                ),
                                              ),
                                            );
                                          },
                                          title: "Delete",
                                          width: 70.w,
                                          height: 32.h,
                                          textColor: AppColors.black,
                                          fillColor: AppColors.white_50,
                                          isBorder: true,
                                          fontSize: 14,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ],
                );
              }
            ),
          ),
        ),
      );
    });
  }
}

