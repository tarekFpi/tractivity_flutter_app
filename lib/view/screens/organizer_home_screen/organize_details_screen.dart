
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/organization_model/OrganizationResponeModel.dart';


class OrganizeDetailsScreen extends StatefulWidget {
  const OrganizeDetailsScreen({super.key});

  @override
  State<OrganizeDetailsScreen> createState() => _OrganizeDetailsScreenState();
}

class _OrganizeDetailsScreenState extends State<OrganizeDetailsScreen> {

  final administratorController = Get.put(AdministratiorController());

  String organizationId="";

  late final OrganizationResponeModel organizationResponeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["organizationId"]!=null && Get.arguments[0]["organizationShowList"]!=null){

      organizationId = Get.arguments[0]["organizationId"];

      administratorController.retriveAllMissionByOrganization(organizationId);

      organizationResponeModel = Get.arguments[0]["organizationShowList"];

    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: const CustomRoyelAppbar(
          titleName: "Organization Details",
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


                    SizedBox(
                      height: 16.h,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.neutral02,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "${organizationResponeModel.name}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    bottom: 8.h,
                                  ),
                                  CustomText(
                                    text:
                                    "${organizationResponeModel.description}",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    maxLines: 4,
                                    textAlign: TextAlign.start,
                                    bottom: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      CustomNetworkImage(
                                        imageUrl: AppConstants.profileImage,
                                        height: 40.h,
                                        width: 40.w,
                                        boxShape: BoxShape.circle,
                                      ),
                                      CustomText(
                                        text: "${organizationResponeModel.creator?.name}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        left: 8.h,
                                        right: 8.h,
                                      ),
                                      CustomText(
                                        text: "(Adminstrator)",
                                        fontSize: 14,
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 26,
                    ),

                    const CustomText(
                      text: "Missions",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.amber,
                    ),

                    SizedBox(
                      height: 16.h,
                    ),




                    administratorController.organizationMissionDetailsShow.isEmpty?
                    SizedBox(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: CustomText(
                          text: "No mission yet!!",
                          fontSize:isTablet?12.sp: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightRed,
                        ),
                      ),
                    ):
                    administratorController.organizationMissionDetailsShowLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                    ListView.builder(
                        itemCount: administratorController.organizationMissionDetailsShow.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {

                          final modelmission = administratorController.organizationMissionDetailsShow[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.neutral02,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "${modelmission.name}",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          bottom: 8.h,
                                        ),
                                        CustomText(
                                          text:
                                          "${modelmission.description}",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          maxLines: 5,
                                          textAlign: TextAlign.start,
                                          bottom: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            CustomNetworkImage(
                                              imageUrl: AppConstants.profileImage,
                                              height: 40.h,
                                              width: 40.w,
                                              boxShape: BoxShape.circle,
                                            ),
                                            CustomText(
                                              text: "${modelmission.creator?.name}",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              left: 8.h,
                                              right: 8.h,
                                            ),
                                            CustomText(
                                              text: "(Adminstrator)",
                                              fontSize: 14,
                                              color: AppColors.blue,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [

                                      CustomText(
                                        text: "${DateConverter.timeFormetString2(modelmission.createdAt.toString())}",
                                        fontSize: 12,
                                        color: AppColors.black_80,
                                        fontWeight: FontWeight.w400,
                                      ),

                                      CustomButton(onTap: (){
                                        ///OrganizerApprovedScreen

                                        Get.toNamed(AppRoutes.organizationEventListScreen,
                                            arguments: [
                                          {
                                            "missionId":modelmission.id,
                                          }
                                        ]);


                                      }, title: "Details",
                                        height:isTablet?40.h: 30.h,
                                        width:isTablet?70.w: 70.w
                                        ,fontSize: 12,),
                                    ],
                                  )
                                ],
                              ),
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
