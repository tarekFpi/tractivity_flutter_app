
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_mission_model/SpecificIdEventsResponeModel.dart';

class AdminstratorMember extends StatefulWidget {
  const AdminstratorMember({super.key});

  @override
  State<AdminstratorMember> createState() => _AdminstratorMemberState();
}

class _AdminstratorMemberState extends State<AdminstratorMember> {

    SpecificIdEventsResponeModel? joinedVolunteer;

  final administratorController = Get.put(AdministratiorController());

    final TextEditingController workingTimeController = TextEditingController();

    final TextEditingController workingDistanceController = TextEditingController();

    final TextEditingController workingRoleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["joinedVolunteer"]!=null){

      joinedVolunteer  = Get.arguments[0]["joinedVolunteer"];

    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true,titleName: AppStrings.member,fontSize:isTablet?6.sp: 22.sp,),
        body: SingleChildScrollView(
          child: Obx(
           () {

             var invitedVolunteer = administratorController.retriveSpecificByEventShowList.value.joinedVolunteer;

             return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                child: Column(
                  children: [

                    SizedBox(height: 20.h,),

                    if (invitedVolunteer != null)

                    Column(
                        children: List.generate(invitedVolunteer.length, (index) {


                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){},
                                  child: Row(
                                    children: [

                                  if (invitedVolunteer[index].volunteer == null)
                                    CustomNetworkImage(
                                      imageUrl:  AppConstants.profileImage,
                                      height:isTablet?64.h: 60.h,
                                      width:isTablet?64.w: 60.w,
                                      boxShape: BoxShape.circle,
                                    ),

                                      if (invitedVolunteer[index].volunteer != null)
                                      CustomNetworkImage(
                                        imageUrl: invitedVolunteer[index].volunteer?.image==""?AppConstants.profileImage:"${ApiUrl.imageUrl}/${invitedVolunteer[index].volunteer?.image}",
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
                                            text: "${invitedVolunteer[index].volunteer?.fullName}",
                                            fontSize:isTablet?8.sp:16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black,
                                          ),
                                            CustomText(
                                            text: "${invitedVolunteer[index].volunteer?.profession}",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.black_80,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10.r),
                                    // border: Border.all(color: AppColors.primary,width: 2),
                                  ),
                                  child: GestureDetector(
                                    onTap: (){

                                      workingTimeController.text =invitedVolunteer[index].totalWorkedHour.toString();

                                      workingRoleController.text =invitedVolunteer[index].mileage.toString();

                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          backgroundColor: Colors.white,
                                          insetPadding: EdgeInsets.all(16),
                                          contentPadding: EdgeInsets.all(16),
                                          //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                          title: Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 32,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          content: SizedBox(
                                            width: MediaQuery.sizeOf(context).width,
                                            height:MediaQuery.sizeOf(context).height/2.2,
                                            child:Column(
                                              children: [

                                                ///============ Working Time ============
                                                CustomFormCard(
                                                    fontSize: isTablet?16:16,
                                                    title: "Hours",
                                                    hintText:"04:30 Hours",
                                                    readOnly: true,
                                                    hasBackgroundColor: true,
                                                    controller: workingTimeController),



                                                ///============ Working Role ============
                                                CustomFormCard(
                                                    fontSize: isTablet?16:16,
                                                    title: "Millage",
                                                    hintText:"Millage",
                                                    hasBackgroundColor: true,
                                                    readOnly: true,
                                                    controller: workingRoleController),


                                              ],
                                            ),
                                          ),
                                        ),
                                      );

                                    },
                                    child: const Center(
                                        child: CustomText(
                                          text: "Details",
                                          color: AppColors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),


                              ],
                            ),
                          );
                        })
                    ),
                  ],
                ),
              );
            }
          ),
        ),

      );
    });
  }
}
