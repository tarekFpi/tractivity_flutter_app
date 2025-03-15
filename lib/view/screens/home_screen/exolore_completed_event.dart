import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';


class ExoloreEventCompletedScreen extends StatefulWidget {

  ExoloreEventCompletedScreen({super.key});

  @override
  State<ExoloreEventCompletedScreen> createState() => _ExoloreEventCompletedScreenState();
}

class _ExoloreEventCompletedScreenState extends State<ExoloreEventCompletedScreen> {
  final  homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homeController.retriveCompletedEventShow();
    homeController.eventSelectedSearchDateController.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar:   CustomRoyelAppbar(
          titleName:"Completed Events",
          leftIcon: true,
          fontSize:isTablet?10.sp: 22.sp,
        ),
        body: LayoutBuilder(builder: (context,constraints){

          final isTablet = constraints.maxWidth > 600;

          return Obx(
           () {
              return RefreshIndicator(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        SizedBox(
                          height:isTablet?24: 12,
                        ),

                        ///======== Search Bar ==============
                        CustomTextField(
                          textEditingController: homeController.eventSelectedSearchDateController.value,
                          // readOnly: true,
                          hintText: "Search event date",
                          fillColor: AppColors.neutral02,
                          suffixIcon:const Icon(
                            FluentIcons.search_24_regular,
                            size: 24,
                          ),
                          onChanged: (String value){
                            if(value.isEmpty){
                              FocusScope.of(context).unfocus();

                              Future.delayed(Duration(seconds: 2), () {
                                homeController.searchVolunteerNameEventList("");
                              });

                            }else{

                              Future.delayed(Duration(seconds: 2), () {
                                homeController.searchVolunteerNameEventList(value);
                              });

                            }
                          },
                        ),


                        const SizedBox(
                          height: 20,
                        ),

                        ///========= Complete Events Row Date Time ===========
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            const CustomText(
                              text: "Completed Events",
                              color: AppColors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),

                            GestureDetector(
                              onTap: (){
                                homeController.eventSartSearchDate();
                              },
                              child: Row(
                                children: [
                                  CustomText(
                                    text: "${homeController.formattedStartDate.value==""?"00/00/0000":"${homeController.formattedStartDate.value}"}",
                                    color: AppColors.black_80,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  IconButton(
                                    onPressed: ()   {
                                    },
                                    icon: const Icon(
                                      Icons.calendar_month,
                                      color: AppColors.black_80,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        homeController.completedEventShowLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                        homeController.completedEventShowList.value.isEmpty?
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
                            itemCount: homeController.completedEventShowList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final model = homeController.completedEventShowList[index];

                              return  Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Row(
                                  children: [

                                    model.images?.isNotEmpty??true?
                                    CustomNetworkImage(
                                      /// imageUrl: AppConstants.eventImage,
                                      imageUrl:"${ApiUrl.imageUrl}${model.images?[0]}",
                                      height: isTablet ? 200.h : 170.h,
                                      width: isTablet ? 180.w : 180.w,
                                      borderRadius: BorderRadius.circular(10),
                                    ):Image.asset("assets/images/event_image.png",
                                      height: isTablet ? 200.h : 170.h,
                                      width: isTablet ? 180.w : 180.w,fit: BoxFit.fill,),

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
                                            SizedBox(
                                              width: 150.w,
                                              child: CustomText(
                                                text: "${model.address?.state},${model.address?.city},${model.address?.zip}",
                                                ///  text: "${administratorController.getAddressFromLatLng(model.cords?.lat??0.0,model.cords?.lng??0.0)}",
                                                fontSize: 12,
                                                color: AppColors.black_80,
                                                fontWeight: FontWeight.w400,
                                                maxLines: 3,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.clip,
                                              ),
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
                                              fontSize:isTablet?6.sp: 12.sp,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis, // Show "..." for overflowing text
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              left: 4,
                                            ),

                                            CustomText(
                                              text: "Leader",
                                              fontSize:isTablet?6.sp: 12.sp,
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

                                                Get.toNamed(AppRoutes.exoloreCompleteDetailsScreen,arguments: [
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
                                                  fontSize: 14,
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
                    )
                  ],
                ),
              ), onRefresh: ()async {
                await  homeController.retriveCompletedEventShow();
              });
            }
          );
        }),
      );
    });
  }
}
