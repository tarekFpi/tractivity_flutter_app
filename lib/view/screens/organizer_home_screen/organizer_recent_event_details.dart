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
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';


class OrganizerRecentEventDetails extends StatefulWidget {

  const OrganizerRecentEventDetails({super.key});

  @override
  State<OrganizerRecentEventDetails> createState() => _OrganizerRecentEventDetailsState();
}

class _OrganizerRecentEventDetailsState extends State<OrganizerRecentEventDetails> {

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
          titleName: "Organizer Event Details",
          fontSize:isTablet?8.sp:16.sp,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Obx(
                    () {

                  var connectedOrgs = administratorController.retriveSpecificByEventShowList.value.missionId?.connectedOrganizations;

                  var connectedOrgsLeader = administratorController.retriveSpecificByEventShowList.value.missionId?.connectedOrganizers;

                  administratorController.getAddressFromLatLng(administratorController.retriveSpecificByEventShowList.value.cords?.lat??0.0, administratorController.retriveSpecificByEventShowList.value.cords?.lng??0.0);

                  return  Column(
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
                        height: 24.h,
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [

                          GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoutes.messageScreen);
                              },
                              child: CustomImage(imageSrc: AppIcons.chart,width: 32.w,height: 32.h,)),

                          SizedBox(
                            width: 24.w,
                          ),

                          Padding(
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
                          )
                        ],
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

                      const SizedBox(
                        height: 8,
                      ),

                      Row(
                        children: [

                          CustomText(
                            text: "${administratorController.retriveSpecificByEventShowList.value.name}",
                            fontSize: isTablet?6.sp:14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_80,
                          ),

                          const SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "(Event Name)",
                            fontSize: isTablet?6.sp:14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightBlue,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Row(
                        children: [

                          CustomText(
                            text: "${administratorController.retriveSpecificByEventShowList.value.missionId?.name}",
                            fontSize: isTablet?6.sp:14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_80,
                          ),

                          const SizedBox(
                            width: 4,
                          ),

                          CustomText(
                            text: "(Mission Name)",
                            fontSize: isTablet?6.sp:14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightBlue,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      if (connectedOrgs != null)
                        for (int i = 0; i < connectedOrgs.length; i++)
                        // Your logic here

                          Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [

                                  CustomText(
                                    text: "${connectedOrgs[i].name}",
                                    fontSize: isTablet?6.sp:14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_80,
                                  ),

                                  const SizedBox(
                                    width: 4,
                                  ),
                                  CustomText(
                                    text: "(Organization)",
                                    fontSize: isTablet?6.sp:14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.lightBlue,
                                  ),
                                ],
                              ),
                            ],
                          ),

                      const SizedBox(
                        height: 12,
                      ),


                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "${administratorController.getSingladdress.value}",
                            fontSize: isTablet?6.sp:12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_80,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      //connectedOrgsLeader

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
                              const SizedBox(
                                width: 10,
                              ),

                              Text.rich(
                                TextSpan(
                                    text: '${connectedOrgsLeader[i].fullName}',
                                    style: TextStyle(
                                        fontSize: 12.sp, fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                        text: ' Leader',
                                        style: TextStyle(
                                            fontSize:  12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.lightBlue),
                                      ),
                                    ]),
                              ),
                            ],
                          ),


                      SizedBox(
                        height: 16.h,
                      ),
                      const CustomText(
                        text: "Description",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_80,
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
                        fontSize:isTablet?6.sp: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_80,
                        textAlign: TextAlign.start,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      CustomText(
                        text:administratorController.retriveSpecificByEventShowList.value.date==""?"2025-01-25 ,${administratorController.retriveSpecificByEventShowList.value.startTime} - ${administratorController.retriveSpecificByEventShowList.value.endTime}": "${DateConverter.timeFormetString(administratorController.retriveSpecificByEventShowList.value.date.toString())}, ${administratorController.retriveSpecificByEventShowList.value.startTime} - ${administratorController.retriveSpecificByEventShowList.value.endTime}",
                        fontSize:isTablet?6.sp: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_80,
                      ),

                      const SizedBox(
                        height: 16,
                      ),

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
