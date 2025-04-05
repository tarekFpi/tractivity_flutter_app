
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
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdminstratorEventDetailsScreen extends StatefulWidget {
  const AdminstratorEventDetailsScreen({super.key});

  @override
  State<AdminstratorEventDetailsScreen> createState() => _AdminstratorEventDetailsScreenState();
}

class _AdminstratorEventDetailsScreenState extends State<AdminstratorEventDetailsScreen> {

  String eventId="";

  final administratorController = Get.put(AdministratiorController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["eventId"]!=null){

      eventId = Get.arguments[0]["eventId"];

       administratorController.retriveSpecificByEventShow(eventId);

    }
  }


  @override
  Widget build(BuildContext context) {

      return LayoutBuilder(builder: (context,constraints){

        final isTablet = constraints.maxWidth > 600;

        return Scaffold(
          appBar: CustomRoyelAppbar(
            leftIcon: true,
            titleName: "Event Details",
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RefreshIndicator(child: ListView(
              children: [
                Obx(
                        () {

                      var connectedOrgs = administratorController.retriveSpecificByEventShowList.value.missionId?.connectedOrganizations;

                      var connectedOrgsLeader = administratorController.retriveSpecificByEventShowList.value.missionId?.connectedOrganizers;

                      var hours = administratorController.missionDetailsShowList.value.report?.hours;

                      var mileage = administratorController.missionDetailsShowList.value.report?.mileage;

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

                              return administratorController.retriveSpecificByEventShowList.value.images?.isNotEmpty??true? CustomNetworkImage(
                                //imageUrl: AppConstants.profileImage,
                                imageUrl:"${ApiUrl.imageUrl}${administratorController.retriveSpecificByEventShowList.value.images?[index]}",
                                height:isTablet?200.h: 180.h,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(10),
                              ):Image.asset("assets/images/event_image.png",
                                height:isTablet?200.h: 180.h,
                                width: MediaQuery.of(context).size.width,fit: BoxFit.fill,);
                            },
                          ),

                     /*  model.images?.isNotEmpty??true?
                      CustomNetworkImage(
                        /// imageUrl: AppConstants.eventImage,
                        imageUrl:"${ApiUrl.imageUrl}${model.images?[0]}",
                        height: isTablet ? 200.h : 170.h,
                        width: isTablet ? 180.w : 180.w,
                        borderRadius: BorderRadius.circular(10),
                      ):Image.asset("assets/images/event_image.png",
                        height: isTablet ? 200.h : 170.h,
                        width: isTablet ? 180.w : 180.w,fit: BoxFit.fill,),
                      */

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
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: GestureDetector(
                                  onTap: (){

                                    if (administratorController.retriveSpecificByEventShowList.value?.joinedVolunteer?.isEmpty ?? true) {

                                      Toast.errorToast("No joined Volunteer yet !!");

                                    }else{

                                      Get.toNamed(AppRoutes.adminstratorMember,arguments: [
                                        {
                                          "joinedVolunteer":administratorController.retriveSpecificByEventShowList.value
                                        }
                                      ]);
                                    }

                                  },
                                  child: Icon(Icons.menu,size: 24,)),
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
                                                text: "${administratorController.retriveSpecificByEventShowList.value.documents?[index].split("/").last}",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black_80,
                                              ),

                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: GestureDetector(
                                                    onTap: (){

                                                      administratorController.startDownload("${ApiUrl.baseUrl}/${administratorController.retriveSpecificByEventShowList.value.documents?[index]}","${administratorController.retriveSpecificByEventShowList.value.documents?[index].split("/").last}");
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
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [

                                    CustomNetworkImage(
                                      imageUrl: connectedOrgsLeader[i].image==""? AppConstants.profileImage:"${ApiUrl.imageUrl}${connectedOrgsLeader[i].image}",
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
                            fontSize:isTablet?6.sp: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_80,
                          ),

                          SizedBox(
                            height: 8.h,
                          ),

                          Column(
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
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
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
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.neutral02,
                                  borderRadius: BorderRadius.circular(10),
                                ),child: CustomText(text: "Hours: ${hours.round()} H",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                              ),

                              SizedBox(
                                width: 8.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.neutral02,
                                  borderRadius: BorderRadius.circular(10),
                                ),child: CustomText(text: "Millage: ${mileage.round()} km",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                )
              ],
            ), onRefresh: ()async{
             await administratorController.retriveSpecificByEventShow(eventId);
            }),
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
