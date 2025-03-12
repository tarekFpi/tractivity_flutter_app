import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';


class JoinDetailsScreen extends StatefulWidget {
  const JoinDetailsScreen({super.key});

  @override
  State<JoinDetailsScreen> createState() => _JoinDetailsScreenState();
}

class _JoinDetailsScreenState extends State<JoinDetailsScreen> {

  String eventId="";

  String inviationId="";

  final administratorController = Get.put(AdministratiorController());

  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["eventId"]!=null && Get.arguments[0]["inviationId"]!=null){

      eventId = Get.arguments[0]["eventId"];

      inviationId = Get.arguments[0]["inviationId"];

      administratorController.retriveSpecificByEventShow(eventId);

    }
  }

  @override
  Widget build(BuildContext context) {

        return LayoutBuilder(builder: (context,constraints){

          final isTablet = constraints.maxWidth > 600;

          return Scaffold(
            appBar: const CustomRoyelAppbar(
              leftIcon: true,
              titleName: "Join Event",
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Obx(
                        () {

                      var connectedOrgs = administratorController.retriveSpecificByEventShowList.value.missionId?.connectedOrganizations;

                      var connectedOrgsLeader = administratorController.retriveSpecificByEventShowList.value.missionId?.connectedOrganizers;


                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          CarouselSlider.builder(
                            options: CarouselOptions(
                              initialPage: administratorController.sliderCurrentIndex.value,
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              height: MediaQuery.sizeOf(context).height / 5,
                              onPageChanged: (index, reason) {

                                administratorController.sliderCurrentIndex.value = index;
                              },
                            ),
                            itemCount: administratorController.retriveSpecificByEventShowList.value.images?.length??0,
                            itemBuilder: (context, index, realIndex) {

                              return  CustomNetworkImage(
                                //imageUrl: AppConstants.profileImage,
                                imageUrl:"${ApiUrl.imageUrl}${administratorController.retriveSpecificByEventShowList.value.images?[index]}",
                                height:isTablet?200.h: 180.h,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(10),
                              );
                            },
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          ///======== Dots ===========
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              administratorController.retriveSpecificByEventShowList.value.images?.length??0,
                                  (index) => buildDot(index, context),
                            ),
                          ),

                          SizedBox(
                            height: 12.h,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child:
                            CustomButton(
                              onTap: () {
                                Get.toNamed(AppRoutes.organizeMapScreen,arguments: [
                                  {
                                    "lat":administratorController.retriveSpecificByEventShowList.value.cords?.lat,
                                    "lng":administratorController.retriveSpecificByEventShowList.value.cords?.lng,
                                  }
                                ]);
                              },
                              title: "Map",
                              width: 80.w,
                              height: 32.h,
                              textColor: AppColors.black,
                              fillColor: AppColors.primary,
                              fontSize: 12,
                            ),

                          ),

                          SizedBox(
                            height: 12.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                administratorController.retriveSpecificByEventShowList.value.documents?.length??0,
                                    (index) {

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: AppColors.primary, spreadRadius: 1),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              CustomImage(imageSrc: AppIcons.dowanload),

                                              SizedBox(width: 4,),

                                              CustomText(
                                                text: "${administratorController.retriveSpecificByEventShowList.value.documents?[index].split("\\").last}",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black_80,
                                              ),

                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: GestureDetector(
                                                    onTap: (){

                                                      administratorController.startDownload("${ApiUrl.baseUrl}/${administratorController.retriveSpecificByEventShowList.value.documents?[index]}","${administratorController.retriveSpecificByEventShowList.value.documents?[index].split("\\").last}");
                                                    },
                                                    child: const CustomText(
                                                      text: "Download",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.lightBlue,
                                                      top: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),

                          SizedBox(
                            height: 12.h,
                          ),

                          CustomText(
                            text: "Organization",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          if (connectedOrgs != null)
                            for (int i = 0; i < connectedOrgs.length; i++)
                            // Your logic here
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  CustomText(
                                    text: "${connectedOrgs[i].name}",
                                    fontSize: isTablet?6.sp:14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_80,
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                ],
                              ),


                          SizedBox(
                            height: 8.h,
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CustomText(
                                text: "Mission Name",
                                fontSize:isTablet?6.sp: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),

                              SizedBox(
                                height: 4.h,
                              ),

                              CustomText(
                                text: "${administratorController.retriveSpecificByEventShowList.value.missionId?.name}",
                                fontSize:isTablet?6.sp: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_80,
                                bottom: 6,
                              ),

                            ],
                          ),

                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          SizedBox(
                            height: 12.h,
                          ),

                          CustomText(
                            text: "Event",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),

                          SizedBox(
                            height: 4.h,
                          ),
                          CustomText(
                            text: "${administratorController.retriveSpecificByEventShowList.value.name}",
                            fontSize:isTablet?6.sp: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_80,
                            bottom: 6,
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          SizedBox(
                            height: 8.h,
                          ),
                          //connectedOrgsLeader
                          CustomText(
                            text: "Organizers",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          if (connectedOrgsLeader != null)
                            for (int i = 0; i < connectedOrgsLeader.length; i++)
                              Row(
                                children: [

                                  CustomNetworkImage(
                                    imageUrl: connectedOrgsLeader[i].image==""? AppConstants.profileImage:"${ApiUrl.imageUrl}/${connectedOrgsLeader[i].image}",
                                    height:isTablet?42.h: 32.h,
                                    width:isTablet?42.w: 32.w,
                                    boxShape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primary, width: 3),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    text: "${connectedOrgsLeader[i].fullName}",
                                    fontSize:isTablet?6.sp: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black_80,
                                    bottom: 6,
                                  ),

                                ],
                              ),

                          SizedBox(
                            height: 8.h,
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CustomText(
                            text: "Description",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomText(
                            text: "${administratorController.retriveSpecificByEventShowList.value.description}",
                            fontSize:isTablet?6.sp: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_80,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomText(
                            text: "Time & Date",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            textAlign: TextAlign.start,
                          ),

                          SizedBox(
                            height: 8.h,
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          CustomText(
                            text:administratorController.retriveSpecificByEventShowList.value.date==""?"2025-01-25": "${DateConverter.timeFormetString("${administratorController.retriveSpecificByEventShowList.value.date}")}, ${administratorController.retriveSpecificByEventShowList.value.startTime} - ${administratorController.retriveSpecificByEventShowList.value.endTime}",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_80,
                          ),

                          SizedBox(
                            height: 8.h,
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "City",
                                fontSize:isTablet?6.sp: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              CustomText(
                                text: "${administratorController.retriveSpecificByEventShowList.value.address?.city}",
                                fontSize:isTablet?6.sp: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black_80,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 4.h,
                          ),

                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          SizedBox(
                            height: 8.h,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "State",
                                fontSize:isTablet?6.sp: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              CustomText(
                                text: "${administratorController.retriveSpecificByEventShowList.value.address?.state}",
                                fontSize:isTablet?6.sp: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black_80,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 4.h,
                          ),

                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          SizedBox(
                            height: 8.h,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Zip",
                                  fontSize:isTablet?6.sp: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                CustomText(
                                  text: "${administratorController.retriveSpecificByEventShowList.value.address?.zip}",
                                  fontSize:isTablet?6.sp: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black_80,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 4.h,
                          ),

                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [

                              CustomText(
                                text: "working Time:${administratorController.retriveSpecificByEventShowList.value.report?.hours}",
                                fontSize:isTablet?8.sp: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),

                              SizedBox(
                                width: 8.w,
                              ),
                              CustomText(
                                text: "Millage:${administratorController.retriveSpecificByEventShowList.value.report?.mileage}",
                                fontSize:isTablet?8.sp: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ],
                          ),

                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          CustomText(
                            text: "Role",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          if (administratorController.retriveSpecificByEventShowList.value.invitedVolunteer != null)
                            for (int i = 0; i < administratorController.retriveSpecificByEventShowList.value.invitedVolunteer!.length; i++)
                              Column(
                                children: [

                               /*   CustomNetworkImage(
                                    imageUrl:  AppConstants.profileImage,
                                    height:isTablet?42.h: 32.h,
                                    width:isTablet?42.w: 32.w,
                                    boxShape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primary, width: 3),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),*/
                                  CustomText(
                                    text: "${administratorController.retriveSpecificByEventShowList.value.invitedVolunteer?[i].workTitle}",
                                    fontSize:isTablet?6.sp: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black_80,
                                    bottom: 6,
                                  ),

                                ],
                              ),

                          const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),

                          SizedBox(
                            height: 8.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16,left: 8,right: 8),
                            child:homeController.notificationInvitationEventAcceptLodding.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                            CustomButton(
                              onTap: () {

                             homeController.acceptSpecificEvent(inviationId,true,eventId);
                              },
                              title: "Join",
                              height: 45.h,
                              textColor: AppColors.black,
                              fillColor: AppColors.primary,
                              fontSize: 14,
                            ),
                          )
                        ],
                      );
                    }
                ),
              ),
            ),
          );
        });
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4,
      width: administratorController.sliderCurrentIndex.value == index ? 30 : 15,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: administratorController.sliderCurrentIndex.value == index
            ? AppColors.lightRed
            : AppColors.grey_1,
      ),
    );
  }
}
