
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_images/app_images.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';

class OrganizerActiveMissionDetails extends StatefulWidget {
  const OrganizerActiveMissionDetails({super.key});

  @override
  State<OrganizerActiveMissionDetails> createState() => _OrganizerActiveMissionDetailsState();
}

class _OrganizerActiveMissionDetailsState extends State<OrganizerActiveMissionDetails>{

  final storage = GetStorage();

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
         appBar: const CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Mission Details",
        ),
        body:RefreshIndicator(child:
        ListView(
          children: [

                Obx(() {

                  var hours = administratorController.missionDetailsShowList.value.report?.hours;

                  var mileage = administratorController.missionDetailsShowList.value.report?.mileage;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 16),
                    child:administratorController.missionDetailsShowList.toString().isEmpty?
                    SizedBox(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: CustomText(
                          text: "No mission details yet!!",
                          fontSize:isTablet?12.sp: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightRed,
                        ),
                      ),
                    ):
                    administratorController.missionDetailsShowLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(
                          height: 24,
                        ),

                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Organizations",
                          fontSize:isTablet?6.sp: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          bottom: 5,
                        ),

                        ListView.builder(
                            itemCount: administratorController.missionDetailsShowList.value.connectedOrganizations?.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final connectedOrganizations =administratorController.missionDetailsShowList.value.connectedOrganizations?[index];

                              return  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "${connectedOrganizations?.name}",
                                    fontSize:isTablet?6.sp: 16.sp,
                                    color: AppColors.black_80,
                                    fontWeight: FontWeight.w600,
                                    bottom: 6.h,
                                    textAlign: TextAlign.start,
                                  ),

                                  CustomText(
                                    text: "${connectedOrganizations?.description}",
                                    fontSize: 12,
                                    color: AppColors.black_02,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                    bottom: 4.h,// Add ellipsis at the end if the text overflows.
                                  ),
                                ],
                              );
                            }),
                        SizedBox(
                          height: 4.h,
                        ),
                        const Divider(
                          color: Colors.black54,
                          // height: 16.h,
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Mission",
                          fontSize:isTablet?6.sp: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          bottom: 5,
                        ),

                        CustomText(
                          text: "${administratorController.missionDetailsShowList.value.name}",
                          fontSize:isTablet?6.sp: 16.sp,
                          color: AppColors.black_80,
                          fontWeight: FontWeight.w600,
                          bottom: 6.h,
                        ),


                        CustomText(
                          text: "${administratorController.missionDetailsShowList.value.description}",
                          fontSize: 12,
                          color: AppColors.black_02,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          bottom: 8.h,// Add ellipsis at the end if the text overflows.
                        ),

                        const Divider(
                          color: Colors.black54,
                        ),

                        SizedBox(
                          height: 4.h,
                        ),

                        if((administratorController.missionDetailsShowList.value.connectedOrganizers?.isNotEmpty ??true)  && (administratorController.missionDetailsShowList.value.requestedOrganizers?.isNotEmpty ??true))
                          CustomText(
                            textAlign: TextAlign.start,
                            text: "Organizers",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                            bottom: 8.h,
                          ),

                        ///Organizers connectedOrganizers
                        ListView.builder(
                            itemCount: administratorController.missionDetailsShowList.value.connectedOrganizers?.length,
                            shrinkWrap: true, //
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final connectedOrganizers =administratorController.missionDetailsShowList.value.connectedOrganizers?[index];

                              return  Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  children: [

                                    connectedOrganizers?.image==""? CustomNetworkImage(
                                      imageUrl: AppConstants.profileImage,
                                      height:isTablet?64.h: 60.h,
                                      width:isTablet?64.w: 60.w,
                                      boxShape: BoxShape.circle,
                                    ):CustomNetworkImage(
                                      imageUrl: "${ApiUrl.imageUrl}${connectedOrganizers?.image}",
                                      height:isTablet?64.h: 60.h,
                                      width:isTablet?64.w: 60.w,
                                      boxShape: BoxShape.circle,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: "${connectedOrganizers?.fullName}",
                                                fontSize:isTablet?8.sp:12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.black,
                                              ),
                                              CustomText(
                                                text: "${connectedOrganizers?.profession}",
                                                fontSize:isTablet?6.sp: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.black_80,
                                              ),
                                            ],
                                          ),

                                          administratorController.specificOrganizerDeleteLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(10.r),
                                              // border: Border.all(color: AppColors.primary,width: 2),
                                            ),
                                            child:  GestureDetector(
                                              onTap: (){
                                                administratorController.removeSpecificOrganizer(connectedOrganizers!.id.toString(),missionId);

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
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),

                        SizedBox(
                          height: 4.h,
                        ),

                        ///Organizers requestedOrganizers
                        ListView.builder(
                            itemCount: administratorController.missionDetailsShowList.value.requestedOrganizers?.length,
                            shrinkWrap: true, //
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final requestedOrganizers =administratorController.missionDetailsShowList.value.requestedOrganizers?[index];

                              return  Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [

                                        requestedOrganizers?.image==""? CustomNetworkImage(
                                          imageUrl: AppConstants.profileImage,
                                          height:isTablet?64.h: 60.h,
                                          width:isTablet?64.w: 60.w,
                                          boxShape: BoxShape.circle,
                                        ):CustomNetworkImage(
                                          imageUrl: "${ApiUrl.imageUrl}${requestedOrganizers?.image}",
                                          height:isTablet?64.h: 60.h,
                                          width:isTablet?64.w: 60.w,
                                          boxShape: BoxShape.circle,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Row(
                                          children: [

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: "${requestedOrganizers?.fullName}",
                                                  fontSize:isTablet?8.sp:12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.black,
                                                ),
                                                CustomText(
                                                  text: "${requestedOrganizers?.profession}",
                                                  fontSize:isTablet?6.sp: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.black_80,
                                                ),
                                              ],
                                            ),

                                          ],),
                                      ],
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
                                          child: Center(
                                              child: CustomText(
                                                text: "Invited",
                                                color: AppColors.white,
                                                fontSize:isTablet?6.sp: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),

                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        administratorController.specificOrganizerDeleteLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(10.r),
                                            // border: Border.all(color: AppColors.primary,width: 2),
                                          ),
                                          child:  GestureDetector(
                                            onTap: (){
                                              administratorController.removeSpecificOrganizer(requestedOrganizers!.id.toString(),missionId);

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
                              );
                            }),

                        administratorController.missionDetailsShowList.value.connectedOrganizers==""?
                        const Divider(
                          color: Colors.black54,
                        ):const SizedBox(),

                        const Divider(
                          color: Colors.black54,
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                        Card(
                          color: Colors.white,
                          elevation: 0.2,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ExpansionTile(
                              shape: Border(),
                              title:  CustomText(
                                textAlign: TextAlign.start,
                                text: "volunteers",
                                fontSize:isTablet?6.sp: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                                bottom: 8.h,
                              ),
                              children:  [

                                /// connectedVolunteers list
                                ListView.builder(
                                    itemCount: administratorController.missionDetailsShowList.value.connectedVolunteers?.length,
                                    shrinkWrap: true, //
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {

                                      final connectedVolunteers =administratorController.missionDetailsShowList.value.connectedVolunteers?[index];

                                      return  Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Row(
                                              children: [
                                                connectedVolunteers?.image==""?
                                                CustomNetworkImage(
                                                  imageUrl: AppConstants.profileImage,
                                                  height:isTablet?64.h: 60.h,
                                                  width:isTablet?64.w: 60.w,
                                                  boxShape: BoxShape.circle,
                                                ):CustomNetworkImage(
                                                  imageUrl: "${ApiUrl.imageUrl}${connectedVolunteers?.image}",
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
                                                      text: "${connectedVolunteers?.fullName}",
                                                      fontSize:isTablet?8.sp:12.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.black,
                                                    ),
                                                    CustomText(
                                                      text: "${connectedVolunteers?.profession}",
                                                      fontSize:isTablet?6.sp: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.black_80,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      );
                                    }),

                                SizedBox(
                                  height: 12.h,
                                ),

                                /// requestedVolunteers list
                                ListView.builder(
                                    itemCount: administratorController.missionDetailsShowList.value.requestedVolunteers?.length,
                                    shrinkWrap: true, //
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, index) {

                                      final requestedVolunteersModel = administratorController.missionDetailsShowList.value.requestedVolunteers?[index];

                                      return  Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Row(

                                              children: [

                                                requestedVolunteersModel?.image==""?
                                                CustomNetworkImage(
                                                  imageUrl: AppConstants.profileImage,
                                                  height:isTablet?64.h: 60.h,
                                                  width:isTablet?64.w: 60.w,
                                                  boxShape: BoxShape.circle,
                                                ):CustomNetworkImage(
                                                  imageUrl: "${ApiUrl.imageUrl}${requestedVolunteersModel?.image}",
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
                                                      text: "${requestedVolunteersModel?.fullName}",
                                                      fontSize:isTablet?8.sp:12.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.black,
                                                    ),
                                                    CustomText(
                                                      text: "${requestedVolunteersModel?.profession}",
                                                      fontSize:isTablet?6.sp: 12.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.black_80,
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),

                                            Container(
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: AppColors.black_04,
                                                borderRadius: BorderRadius.circular(10.r),
                                                // border: Border.all(color: AppColors.primary,width: 2),
                                              ),
                                              child: Center(
                                                  child: CustomText(
                                                    text: "Invited",
                                                    color: AppColors.white,
                                                    fontSize:isTablet?6.sp: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            )

                                          ],
                                        ),
                                      );
                                    }),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                        const Divider(
                          color: Colors.black54,
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CustomButton(
                              onTap: () {

                                Get.toNamed(AppRoutes.missionToVolunteersInviteScreen,arguments: [
                                  {
                                    /// "missionName":"${administratorController.missionDetailsShowList.value.name}",
                                    /// "missionDescription":"${administratorController.missionDetailsShowList.value.description}",
                                    "missionOrganization":"${administratorController.missionDetailsShowList.value}",
                                  }
                                ]);
                              },
                              title: "Invite volunteers",
                              height:isTablet?40.h: 35.h,
                              width: 120.w,
                              textColor: AppColors.white,
                              fillColor: AppColors.primary,
                              fontSize: 12,
                            ),

                            CustomButton(
                              onTap: () {

                                Get.toNamed(AppRoutes.missionEventReportScreen,arguments: [
                                  {
                                    "missionId":"${administratorController.missionDetailsShowList.value.id}",
                                  }
                                ]);
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
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.neutral02,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomText(
                                text: "Hours: ${hours != null ? hours.round() : 0} H",
                                fontSize: isTablet ? 6 : 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.neutral02,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CustomText(
                                text: "Mileage: ${mileage != null ? mileage.round() : 0} km",
                                fontSize: isTablet ? 6 : 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),

                        Row(
                          children: [

                            CustomText(
                              text:  "Mission mode:",
                              fontSize:isTablet?6.sp: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),

                            SizedBox(
                              width: 8.w,
                            ),
                            CustomText(
                              text:  "${administratorController.missionDetailsShowList.value.mode}",
                              fontSize:isTablet?6.sp: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.cardBarClr,
                            )
                          ],

                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        const Divider(
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Events",
                          fontSize:isTablet?6.sp: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          bottom: 8.h,
                        ),

                        administratorController.missionEventShowLoading.value?const Center(child: CircularProgressIndicator(color: Colors.orange,)):
                        administratorController.missionEventShowList.isEmpty?
                        SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          child: Center(
                            child: CustomText(
                              text: "No Events yet!!",
                              fontSize:isTablet?12.sp: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightRed,
                            ),
                          ),
                        ):
                        ListView.builder(
                            itemCount: administratorController.missionEventShowList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final model = administratorController.missionEventShowList[index];

                              return  Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Row(
                                  children: [

                                    model.images?.isNotEmpty??true?
                                    CustomNetworkImage(
                                      /// imageUrl: AppConstants.eventImage,
                                      imageUrl:"${ApiUrl.imageUrl}${model.images?[0]}",
                                      height: isTablet ? 200.h : 170.h,
                                      width: isTablet ? 160.w : 160.w,
                                      borderRadius: BorderRadius.circular(10),
                                    ):Image.asset("assets/images/event_image.png",
                                      height: isTablet ? 200.h : 170.h,
                                      width: isTablet ? 160.w : 160.w,fit: BoxFit.fill,),

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
                                            text: "${model.name}",
                                            maxLines: 3,
                                            fontSize:isTablet?8.sp: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            bottom: 5,
                                          ),
                                        ),
                                        /// Location
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: AppColors.black,
                                              size: 20,
                                            ),
                                            CustomText(
                                              text: "${model.address?.state},${model.address?.city},${model.address?.zip}",//,
                                              ///  text: "${administratorController.getAddressFromLatLng(model.cords?.lat??0.0,model.cords?.lng??0.0)}",
                                              fontSize: 8,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w400,
                                              maxLines: 8,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
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
                                              text: "${model.creator?.name}",
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
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            GestureDetector(
                                              onTap: () {

                                                Get.toNamed(AppRoutes.organizationEventdetailsScreen,arguments: [
                                                  {
                                                    "eventId":model.id
                                                  }
                                                ]);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: const CustomText(
                                                  text:  "Explore",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 6.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {

                                                 Get.toNamed(AppRoutes.organizerEventCreateScreen,arguments: [
                                                  {
                                                    "eventModel":model
                                                  }
                                                ]);

                                                debugPrint("duplicate:${model.id}");
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: const CustomText(
                                                  text:  "Duplicate",
                                                  fontSize: 12,
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
                            }),


                      ],
                    ),
                  );
                }
            )
          ],
        ), onRefresh: ()async {

          await administratorController.retriveSpecificMissionByMissionShow(missionId);
          await administratorController.retriveAllEventByMissionShow(missionId);
        }),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.organizerEventCreateScreen,
                      arguments: [
                        {
                          "missionOrganization":"${administratorController.missionDetailsShowList.value}",
                        }
                      ]
                  );
                },
                title: "Create Event",
                height: 45.h,
                textColor: AppColors.black,
                fillColor: AppColors.primary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    });
  }
}
