// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_selected.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/home_screen/join_event_screen/controller/join_event_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/join_event_screen/controller/running_complete_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/user_profile_screen.dart';

class JoinEventScreen extends StatefulWidget {
  const JoinEventScreen({super.key});

  @override
  State<JoinEventScreen> createState() => _JoinEventScreenState();
}

class _JoinEventScreenState extends State<JoinEventScreen> {

  final   eventsController = Get.find<EventsController>();

  final joinEventController =Get.put(JoinEventController());

  final runningController =Get.put(RunningCompleteController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    joinEventController.notificationInvitationEventShow();

    runningController.runningCompleteEventShow();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            "Join Event",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Obx(
                  () {
                return RefreshIndicator(child: ListView(
                  children: [

                    Column(
                      children: [
                        ///================= Profile Image , Name and Location
                        UserProfileScreen(),


                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 22),
                          child: CustomTabSelector(
                              fontSize: isTablet?24:16,
                              tabs: eventsController.joinEvenNameList,
                              selectedIndex: eventsController.currentIndex.value,
                              onTabSelected: (value) {
                                eventsController.currentIndex.value = value;

                              },
                              selectedColor: AppColors.primary,
                              unselectedColor: AppColors.black),
                        ),

                        SizedBox(
                          height: 22.h,
                        ),

                        ///============ invitation Event ========
                        if(eventsController.currentIndex.value ==0)
                          Column(
                            children: [

                              ///Search Bar invitation Event
                              CustomTextField(
                                textEditingController:joinEventController.queryInviteEventController.value,
                                fillColor: AppColors.neutral02,
                                //  hintText: AppStrings.search,
                                hintText: "Search for event name...",
                                onChanged: (value){

                                  joinEventController.queryevent.value = value;

                                  joinEventController.searchNotificationInvitaionEventList(joinEventController.queryevent.value);
                                },

                                suffixIcon: joinEventController.queryevent.value.isBlank == true || joinEventController.queryevent.value.isEmpty
                                    ? Icon(
                                  FluentIcons.search_24_regular,
                                  size: 24,
                                )
                                    : IconButton(
                                    icon: Icon(Icons.close,size: 24,),
                                    onPressed: () {

                                      joinEventController.queryevent.value = "";

                                      joinEventController.queryInviteEventController.value.clear();
                                      FocusScope.of(context).unfocus();

                                      joinEventController.searchNotificationInvitaionEventList("");

                                    }),

                              ),
                              SizedBox(
                                height: 12.h,
                              ),

                              joinEventController.notificationInvitaionEventList.isEmpty?
                              SizedBox(
                                height: MediaQuery.of(context).size.height/4,
                                child: Center(
                                  child: CustomText(
                                    text: "No event invitation  yet!!",
                                    fontSize:isTablet?12.sp: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lightRed,
                                  ),
                                ),
                              ):
                              joinEventController.obx((state){

                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state?.length,
                                    itemBuilder: (BuildContext context,index){

                                      final invitedEventModel =state?[index];

                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            invitedEventModel?.contentId?.images?.isNotEmpty??true?
                                            CustomNetworkImage(
                                              /// imageUrl: AppConstants.eventImage,
                                              imageUrl:"${ApiUrl.imageUrl}${invitedEventModel?.contentId?.images?[0]}",
                                              height: isTablet ? 200.h : 170.h,
                                              width: isTablet ? 170.w : 170.w,
                                              borderRadius: BorderRadius.circular(10),
                                            ):Image.asset("assets/images/event_image.png",
                                              height: isTablet ? 200.h : 170.h,
                                              width: isTablet ? 170.w : 170.w,fit: BoxFit.fill,),

                                            SizedBox(
                                              width: 10.w,
                                            ),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                CustomText(
                                                  textAlign: TextAlign.start,
                                                  text: "${invitedEventModel?.contentId?.name}",
                                                  maxLines: 3,
                                                  fontSize:isTablet?8.sp: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  bottom: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                ),

                                                /// Location
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.location_on,
                                                      color: AppColors.black,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 150.w,
                                                      child: CustomText(
                                                        text: "${invitedEventModel?.contentId?.address?.state},${invitedEventModel?.contentId?.address?.city},${invitedEventModel?.contentId?.address?.zip}",
                                                        ///  text: "${administratorController.getAddressFromLatLng(model.cords?.lat??0.0,model.cords?.lng??0.0)}",
                                                        fontSize:isTablet?6.sp: 8.sp,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w400,
                                                        maxLines: 4,
                                                        textAlign: TextAlign.start,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),
                                                // Leader
                                                /// Leader
                                                Row(
                                                  children: [
                                                    CustomNetworkImage(
                                                      imageUrl: AppConstants.profileImage,
                                                      height: 30,
                                                      width: 30,
                                                      boxShape: BoxShape.circle,
                                                    ),
                                                    SizedBox(
                                                      width: 100.w,
                                                      child: CustomText(
                                                        text: "${invitedEventModel?.contentId?.creator?.name}",
                                                        fontSize:isTablet?6.sp: 12.sp,
                                                        color: AppColors.black,
                                                        fontWeight: FontWeight.w600,
                                                        overflow: TextOverflow.ellipsis, // Show "..." for overflowing text
                                                        maxLines: 3,
                                                        textAlign: TextAlign.start,
                                                        left: 4,
                                                      ),
                                                    ),

                                                    CustomText(
                                                      text: "Leader",
                                                      fontSize:isTablet?6.sp: 12.sp,
                                                      color: AppColors.blue,
                                                      fontWeight: FontWeight.w600,
                                                      left: 4),
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
                                                        Get.toNamed(AppRoutes.joinDetailsScreen,arguments: [
                                                          {
                                                            "eventId":invitedEventModel?.contentId?.id,
                                                            "inviationId":invitedEventModel?.id
                                                          }
                                                        ]);

                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.primary,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: CustomText(
                                                          text: "Explore",
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.black,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(width: 5.w),

                                                    InkWell(
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
                                                                        text:"Are you sure you want to \n Decline this Event?",
                                                                        fontSize: 22,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: AppColors.black_80,
                                                                      ),

                                                                      SizedBox(
                                                                        height: 8.h,
                                                                      ),

                                                                      joinEventController.eventInvitationDeleteLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                                                                      CustomButton(onTap: (){

                                                                        joinEventController.eventDelete(invitedEventModel?.id.toString()??"");

                                                                        if(joinEventController.eventInvitationDeleteLoading.value){
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
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.primary,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: CustomText(
                                                          text: "Decline",
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.black,
                                                        ),
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }),

                            ],
                          ),


                        if(eventsController.currentIndex.value ==1)
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [

                             ///Search Bar running complete Event
                             CustomTextField(
                               textEditingController:runningController.queryRunningCompleteEventController.value,
                               fillColor: AppColors.neutral02,
                               //  hintText: AppStrings.search,
                               hintText: "Search for event name...",
                               onChanged: (value){

                                 runningController.queryEvent.value = value;

                                 runningController.searchEventList(runningController.queryEvent.value);
                               },

                               suffixIcon: runningController.queryEvent.value.isBlank == true || runningController.queryEvent.value.isEmpty
                                   ? Icon(
                                 FluentIcons.search_24_regular,
                                 size: 24,
                               )
                                   : IconButton(
                                   icon: Icon(Icons.close,size: 24,),
                                   onPressed: () {

                                     runningController.queryEvent.value = "";

                                     runningController.queryRunningCompleteEventController.value.clear();
                                     FocusScope.of(context).unfocus();

                                     runningController.searchEventList("");
                                   }),
                             ),

                             SizedBox(
                               height: 12.h,
                             ),
                             runningController.runningCompleteEventList.isEmpty?
                             SizedBox(
                               height: MediaQuery.of(context).size.height/4,
                               child: Center(
                                 child: CustomText(
                                   text: "No event yet!!",
                                   fontSize:isTablet?12.sp: 24.sp,
                                   fontWeight: FontWeight.w700,
                                   color: AppColors.lightRed,
                                 ),
                               ),
                             ):
                             runningController.obx((state){

                               return ListView.builder(
                                   shrinkWrap: true,
                                   physics: NeverScrollableScrollPhysics(),
                                   itemCount: state?.length,
                                   itemBuilder: (BuildContext context,index){

                                     final eventModel =state?[index];

                                     return Padding(
                                       padding: const EdgeInsets.only(bottom: 20.0),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [

                                           eventModel?.images?.isNotEmpty??true?
                                           CustomNetworkImage(
                                             /// imageUrl: AppConstants.eventImage,
                                             imageUrl:"${ApiUrl.imageUrl}${eventModel?.images?[0]}",
                                             height: isTablet ? 200.h : 170.h,
                                             width: isTablet ? 160.w : 160.w,
                                             borderRadius: BorderRadius.circular(10),
                                           ):Image.asset("assets/images/event_image.png",
                                             height: isTablet ? 200.h : 170.h,
                                             width: isTablet ? 160.w : 160.w,fit: BoxFit.fill,),

                                           SizedBox(
                                             width: 10.w,
                                           ),

                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [

                                               CustomText(
                                                 textAlign: TextAlign.start,
                                                 text: "${eventModel?.name}",
                                                 maxLines: 3,
                                                 fontSize:isTablet?8.sp: 14.sp,
                                                 fontWeight: FontWeight.w600,
                                                 bottom: 5,
                                                 overflow: TextOverflow.ellipsis,
                                               ),

                                               /// Location
                                               Row(
                                                 children: [
                                                   const Icon(
                                                     Icons.location_on,
                                                     color: AppColors.black,
                                                     size: 20,
                                                   ),
                                                   SizedBox(
                                                     width: 150.w,
                                                     child: CustomText(
                                                       text: "${eventModel?.address?.state},${eventModel?.address?.city},${eventModel?.address?.zip}",
                                                       ///  text: "${administratorController.getAddressFromLatLng(model.cords?.lat??0.0,model.cords?.lng??0.0)}",
                                                       fontSize:isTablet?6.sp: 8.sp,
                                                       color: AppColors.black_80,
                                                       fontWeight: FontWeight.w400,
                                                       maxLines: 4,
                                                       textAlign: TextAlign.start,
                                                       overflow: TextOverflow.ellipsis,
                                                     ),
                                                   ),
                                                 ],
                                               ),

                                               SizedBox(
                                                 height: 5,
                                               ),
                                               // Leader
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
                                                     text: "${eventModel?.creator?.name}",
                                                     fontSize:isTablet?6.sp: 9.sp,
                                                     color: AppColors.black,
                                                     fontWeight: FontWeight.w600,
                                                     overflow: TextOverflow.ellipsis, // Show "..." for overflowing text
                                                     maxLines: 1,
                                                     textAlign: TextAlign.start,
                                                     left: 4,
                                                   ),

                                                   CustomText(
                                                     text: "Leader",
                                                     fontSize:isTablet?6.sp: 9.sp,
                                                     color: AppColors.blue,
                                                     fontWeight: FontWeight.w600,
                                                     left: 4,                                        ),
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
                                                     /*  Get.toNamed(AppRoutes.joinDetailsScreen,arguments: [
                                                         {
                                                           "eventId":eventModel?.id,
                                                           "inviationId":eventModel?.id
                                                         }
                                                       ]);*/

                                                       Get.toNamed(AppRoutes.recentEventExploreDetails,arguments: [
                                                         {
                                                           "eventId":eventModel?.id
                                                         }
                                                       ]);
                                                     },
                                                     child: Container(
                                                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                       decoration: BoxDecoration(
                                                         color: AppColors.primary,
                                                         borderRadius: BorderRadius.circular(10),
                                                       ),
                                                       child: CustomText(
                                                         text: "Explore",
                                                         fontSize: 14,
                                                         fontWeight: FontWeight.w500,
                                                         color: AppColors.black,
                                                       ),
                                                     ),
                                                   ),

                                                   SizedBox(width: 5.w),


                                                 ],
                                               ),
                                             ],
                                           )
                                         ],
                                       ),
                                     );
                                   });
                             }),
                           ],
                         )
                      ],
                    )
                  ],
                ), onRefresh: ()async {
                  if(eventsController.currentIndex.value ==0)
                   await joinEventController.notificationInvitationEventShow();

                  if(eventsController.currentIndex.value ==1)
                    await runningController.runningCompleteEventShow();

                });
              }
          ),
        ),
        bottomNavigationBar: NavBar(currentIndex: 3),
      );
    });
  }
}
