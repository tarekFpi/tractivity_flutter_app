
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_missionby_mission_model/RetriveSpecificMissionByMissionResponeModel.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';


class MissionToVolunteersInviteScreen extends StatefulWidget {
  const MissionToVolunteersInviteScreen({super.key});

  @override
  State<MissionToVolunteersInviteScreen> createState() => _MissionToVolunteersInviteScreenState();
}

class _MissionToVolunteersInviteScreenState extends State<MissionToVolunteersInviteScreen> {

  String missionName="";

  String missionDescription="";

  final  organizerController = Get.find<OrganizerController>();

  final administratorController = Get.put(AdministratiorController());

   RetriveSpecificMissionByMissionResponeModel? missionByMissionResponeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["missionId"]!=null){

   //   missionName = Get.arguments[0]["missionName"];

     // missionDescription = Get.arguments[0]["missionDescription"];

      missionByMissionResponeModel = Get.arguments[0]["missionOrganization"];

    }
  }

  @override
  Widget build(BuildContext context) {
      return LayoutBuilder(builder: (context,constraints){

        final isTablet = constraints.maxWidth > 600;

        return Scaffold(
          appBar: CustomRoyelAppbar(
            titleName: "Invite Volunteers",
            leftIcon: true,
          ),
          body:SingleChildScrollView(
            child: Obx(
              () {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

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
                        height: 12.h,
                      ),
                      const Divider(
                        color: Colors.black54,
                        // height: 16.h,
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

                      SizedBox(
                        height: 8.h,
                      ),
                      ///============ search ======================================
                      const CustomTextField(
                          hintText: "Search for volunteer",
                          fillColor: AppColors.neutral02,
                          suffixIcon: Icon(
                            Icons.search,
                            color: AppColors.black_60,
                          )),

                        SizedBox(
                        height: 8.h,
                      ),

                      Column(
                          children: List.generate(3, (index) {
                            return GestureDetector(
                              onTap: (){

                              },
                              child: CustomFriendsList(
                                image: AppConstants.profileImage,
                                name: "Mehedi Hassan",
                                userName: "Single",
                                reversText: "Select",
                              ),
                            );
                          })
                      )
                    ],
                  ),
                );
              }
            ),
          ),

          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomButton(onTap: (){

                }, title: "Done",fontSize:isTablet?8.sp: 14.sp,),
              ),

            ],
          ),
        );
      });
  }
}
