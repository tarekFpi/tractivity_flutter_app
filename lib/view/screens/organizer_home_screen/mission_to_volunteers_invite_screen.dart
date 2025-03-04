
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
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_missionby_mission_model/RetriveSpecificMissionByMissionResponeModel.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/mission_to_volunteer_controller.dart';
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

  final missionToVoluntController = Get.put(MissionToVolunteerController());

 //  RetriveSpecificMissionByMissionResponeModel? missionByMissionResponeModel;

  final queryEditingController = TextEditingController();

  String query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["missionOrganization"]!=null){

   //   missionByMissionResponeModel = Get.arguments[0]["missionOrganization"];
    }

    missionToVoluntController.retrieveVolunteersToMissionsInvite(administratorController.missionDetailsShowList.value.id.toString());
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
                  padding: EdgeInsets.all(12.0),
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

                      CustomTextField(
                        textEditingController:queryEditingController,
                        fillColor: AppColors.neutral02,
                        //  hintText: AppStrings.search,
                        hintText: "Search for name...",
                        onChanged: (value){
                          setState(() {
                            query = value;
                          });
                          missionToVoluntController.searchVolunteersList(query);
                        },

                        suffixIcon: query.isBlank == true || query.isEmpty
                            ? Icon(
                          FluentIcons.search_24_regular,
                          size: 24,
                        )
                            : IconButton(
                            icon: Icon(Icons.close,size: 24,),
                            onPressed: () {
                              setState(() {
                                query = "";
                              });
                              queryEditingController.clear();
                              FocusScope.of(context).unfocus();

                              missionToVoluntController.searchVolunteersList("");

                            }),

                      ),


                      const SizedBox(
                        height: 12,
                      ),
                        SizedBox(
                        height: 12.h,
                      ),

                      missionToVoluntController.obx((state){

                        if (state == null || state.isEmpty) {

                          return SizedBox(
                            height: MediaQuery.of(context).size.height/2,
                            child: Center(
                              child: CustomText(
                                text: "No volunteers yet!!",
                                fontSize:isTablet?12.sp: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.lightRed,
                              ),
                            ),
                          );

                        }else{
                          return ListView.builder(
                              itemCount:state?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {

                                final model =state?[index];

                                return Card(
                                  elevation: 0.5,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10.h,left: 8,right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: (){},
                                          child: Row(
                                            children: [

                                              model?.image==""? CustomNetworkImage(
                                                imageUrl: AppConstants.profileImage,
                                                height:isTablet?64.h: 60.h,
                                                width:isTablet?64.w: 60.w,
                                                boxShape: BoxShape.circle,
                                              ):CustomNetworkImage(
                                                imageUrl: "${ApiUrl.imageUrl}${model?.image}",
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
                                                    text: "${model?.fullName}",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.black,
                                                  ),
                                                  CustomText(
                                                    text: "${model?.profession}",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.black_80,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Obx(()=> Checkbox(
                                          checkColor: AppColors.white,
                                          activeColor: AppColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(3.0),
                                          ),
                                          side: const BorderSide(
                                            // ======> CHANGE THE BORDER COLOR HERE <======
                                            color: AppColors.primary,
                                            // Give your checkbox border a custom width
                                            width: 1.4,
                                          ),
                                          ///value: administratorController.selectedOranization.value,
                                          value: missionToVoluntController.volunteersIdList.contains(model?.id),
                                          onChanged: (bool? value) {

                                            missionToVoluntController.selectedVolunteers.value = value!;

                                            if(missionToVoluntController.selectedVolunteers.value){

                                              missionToVoluntController.volunteersIdList.add(model!.id.toString());

                                            }else{
                                              missionToVoluntController.volunteersIdList.remove(model?.id.toString());
                                            }

                                          },
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }

                      }),

                    ],
                  ),
                );
              }
            ),
          ),

          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              missionToVoluntController.obx((state){

                 if(state?.isEmpty??true){

                   return SizedBox();
                 }else{

                   return Padding(
                     padding: const EdgeInsets.all(12.0),
                     child:missionToVoluntController.voluteersLoading.value?CircularProgressIndicator():
                     CustomButton(onTap: (){

                       if(missionToVoluntController.volunteersIdList.isEmpty){

                         Toast.errorToast("please select volunteers..!!");
                       }else{

                         missionToVoluntController.inviteVolunteerToMission(administratorController.missionDetailsShowList.value.id.toString());

                         if(missionToVoluntController.voluteersLoading.value){
                           Navigator.of(context).pop();
                         }
                       }

                     }, title: "Submit",fontSize:isTablet?8.sp: 14.sp,),
                   );
                 }

              })

            ],
          ),
        );
      });
  }
}
