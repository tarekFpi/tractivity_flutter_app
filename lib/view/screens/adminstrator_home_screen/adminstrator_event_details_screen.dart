
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
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
            child: SingleChildScrollView(
              child: Obx(
                () {


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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                        //  CustomImage(imageSrc: AppIcons.dowanload),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                        administratorController.retriveSpecificByEventShowList.value.documents?.length??0,
                                          (index) {


                                             return Container(
                                               padding: const EdgeInsets.all(8.0),
                                              /* decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(10),
                                                 color: Colors.white,
                                                 boxShadow: [
                                                   BoxShadow(color: Colors.green, spreadRadius: 1),
                                                 ],
                                               ),*/
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
                                                     ],
                                                   ),

                                                   SizedBox(height: 8.h,),

                                                   GestureDetector(
                                                     onTap: (){

                                                     administratorController.downloadPdf("${administratorController.retriveSpecificByEventShowList.value.documents?[index]}");
                                                     },
                                                     child: CustomText(
                                                       text: "Download",
                                                       fontSize: 12,
                                                       fontWeight: FontWeight.w600,
                                                       color: AppColors.lightBlue,
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             );
                                      }
                                    ),
                                  ),


                                ],
                              ),

                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoutes.adminstratorMember);
                                },
                                child: Icon(Icons.menu,size: 24,)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CustomText(
                        text: "Rohingya refugee camp",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_80,
                      ),
                      const SizedBox(
                        height: 12,
                      ),


                      Row(
                        children: [

                          CustomText(
                            text: "Rohingya refugee camp",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_80,
                          ),

                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "(Event Name)",
                            fontSize: 12,
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
                            text: "Empower Tomorrow",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_80,
                          ),

                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "(Mission Name)",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightBlue,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Row(
                        children: [

                          CustomText(
                            text: "Global Horizons Foundation",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_80,
                          ),

                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "(Organization)",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightBlue,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 12,
                      ),


                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            size: 18,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "3500",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_80,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 18,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "Cox’s Bazar",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_80,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height:isTablet?32.h: 24.h,
                            width:isTablet?32.w: 24.w,
                            boxShape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary, width: 3),
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          Text.rich(
                            TextSpan(
                                text: 'Mehedi Bin',
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
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height:isTablet?32.h: 24.h,
                            width:isTablet?32.w: 24.w,
                            boxShape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary, width: 3),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text.rich(
                            TextSpan(
                                text: 'Sujon',
                                style: TextStyle(
                                    fontSize: 12.sp, fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                    text: ' Food Delivery',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.lightBlue),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
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
                      const CustomText(
                        text:
                        "The Rohingya have faced decades of discrimination \n and repression under successive Myanmar authorities. denied citizenship \n under the 1982 Citizenship Law, they are one of \n the largest stateless populations in the world.",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_80,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const CustomText(
                        text: "Time & Date",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black_80,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CustomText(
                        text: "22 December, 2024, 8.00 am-12.00 pm",
                        fontSize: 12,
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
