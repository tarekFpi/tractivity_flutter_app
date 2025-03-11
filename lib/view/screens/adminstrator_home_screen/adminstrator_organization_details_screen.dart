
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/organization_model/OrganizationResponeModel.dart';

class AdminstratorOrganizationDetailsScreen extends StatefulWidget {
  const AdminstratorOrganizationDetailsScreen({super.key});

  @override
  State<AdminstratorOrganizationDetailsScreen> createState() => _AdminstratorOrganizationDetailsScreenState();
}

class _AdminstratorOrganizationDetailsScreenState extends State<AdminstratorOrganizationDetailsScreen> {

  final administratorController = Get.put(AdministratiorController());

  String organizationId="";

  late final OrganizationResponeModel organizationResponeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["organizationId"]!=null){

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
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Organization Details",
          fontSize: 22,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
            child: Obx(
               () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(
                      textAlign: TextAlign.start,
                      text: "Organization",
                      fontSize:isTablet?6.sp: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      bottom: 5,
                    ),

                    CustomText(
                      text: "${organizationResponeModel.name}",
                      fontSize:isTablet?6.sp: 16.sp,
                      color: AppColors.black_80,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),

                    CustomText(
                      text: "${organizationResponeModel.description}",
                      fontSize: 12,
                      color: AppColors.black_02,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                      bottom: 4.h,// Add ellipsis at the end if the text overflows.
                    ),


                    const Divider(
                      color: Colors.black54,
                    ),

                  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                   CustomText(
                     textAlign: TextAlign.start,
                     text: "Mission",
                     fontSize:isTablet?8.sp: 18.sp,
                     fontWeight: FontWeight.w500,
                     color: AppColors.primary,
                   ),

                   CustomButton(
                     onTap: () {
                     //  Get.toNamed(AppRoutes.adminstratorOrganizationToReportScreen);

                     Get.toNamed(AppRoutes.adminstratorOrganizationToReportScreen,
                        arguments: [
                          {
                            "organizationId":organizationResponeModel.id,
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

                          return GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoutes.adminstratiorEventListScreen,
                                  arguments: [
                                    {
                                      "missionId":modelmission.id,
                                    }
                                  ]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:isTablet?140.h: 140.h,
                                decoration: BoxDecoration(
                                  color: AppColors.grey_3.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.only(top: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          CustomText(
                                            text: "${index+1}.${modelmission.name}",
                                            fontSize: 16,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w600,
                                          ),

                                            CustomText(
                                            text: "${DateConverter.timeFormetString2(modelmission.createdAt.toString())}",
                                            fontSize: 12,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                            CustomText(
                                            text: "${modelmission.description}",
                                            fontSize: 12,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,// Add ellipsis at the end if the text overflows.
                                          ),

                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Row(
                                            children: [

                                              CustomButton(
                                                onTap: () {

                                                  showDialog(
                                                    context: context,
                                                    builder: (ctx) => AlertDialog(
                                                      backgroundColor: Colors.white,
                                                      insetPadding: EdgeInsets.all(8),
                                                      contentPadding: EdgeInsets.all(8),
                                                      title: SizedBox(),
                                                      content: SizedBox(
                                                        width: MediaQuery.sizeOf(context).width,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [

                                                              const CustomText(
                                                                text:"Are you sure you want to \n delete mission?",
                                                                fontSize: 22,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.black_80,
                                                              ),

                                                              SizedBox(
                                                                height: 8.h,
                                                              ),

                                                              administratorController.missionDeleteLoading.value?CustomLoader():
                                                              CustomButton(onTap: (){

                                                                administratorController.missionDelete(modelmission.id.toString());

                                                                if(administratorController.missionDeleteLoading.value){
                                                                  Navigator.of(context).pop();
                                                                }

                                                              },title:"Yes",height:isTablet?70.h: 45.h,fontSize: 12.sp,),

                                                              SizedBox(
                                                                height: 12.h,
                                                              ),
                                                              CustomButton(onTap: (){
                                                                Navigator.of(context).pop();
                                                              },title:"NO",height:isTablet?70.h: 45.h,
                                                                fontSize: 12.sp,fillColor: AppColors.white,
                                                                textColor: AppColors.primary,
                                                                isBorder: true,borderWidth: 1,)
                                                            ],
                                                          ),
                                                        ),
                                                        //  child: AlertDialogEvent(title: "Are you sure you want to \n delete ?",discription: "",),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                title: "Delete",
                                                width: 80.w,
                                                height: 32.h,
                                                textColor: AppColors.black,
                                                fillColor: AppColors.primary,
                                                fontSize: 12,
                                              ),

                                              SizedBox(
                                                width:isTablet?12.h: 8.h,
                                              ),

                                              CustomButton(
                                                onTap: () {


                                                  administratorController.editMissionNameController.value.text=modelmission.name.toString();
                                                  administratorController.editOrganizationDescriptionController.value.text=modelmission.name.toString();

                                                  if(administratorController.presentLeaderIdList.isEmpty){
                                                    administratorController.missionShowList();
                                                  }

                                                  if(modelmission.connectedOrganizers!.isNotEmpty){

                                                    modelmission.connectedOrganizers?.forEach((element) {

                                                      if (!administratorController.presentLeaderIdList.contains(element.id.toString())) {

                                                        administratorController.presentLeaderIdList.add(element.id.toString());

                                                        debugPrint("presentLeaderIdList:${administratorController.presentLeaderIdList.value}");

                                                        administratorController.exitingLeaderIdList.add(element.id.toString());

                                                        debugPrint("exitingLeaderIdList:${administratorController.exitingLeaderIdList.value}");
                                                      }
                                                    });

                                                  }else{

                                                    administratorController.presentLeaderIdList.value.clear();
                                                    administratorController.exitingLeaderIdList.clear();
                                                  }


                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (ctx) => AlertDialog(
                                                      backgroundColor: Colors.white,
                                                      insetPadding: EdgeInsets.all(8),
                                                      contentPadding: EdgeInsets.all(8),
                                                      ///clipBehavior: Clip.antiAliasWithSaveLayer,
                                                      title:Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          ///Edit Mission
                                                          const CustomText(
                                                            text: "Edit Mission",
                                                            fontSize: 24,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.w500,
                                                            bottom: 8,
                                                          ),

                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  Navigator.of(context).pop();
                                                                  administratorController.presentLeaderIdList.clear();
                                                                  administratorController.exitingLeaderIdList.clear();
                                                                },
                                                                child: const Icon(
                                                                  Icons.close,
                                                                  size: 32,
                                                                  color: Colors.black,
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                      content: Obx(
                                                              () {
                                                            return SingleChildScrollView(
                                                              child: SizedBox(
                                                                width: MediaQuery.sizeOf(context).width,
                                                                ///height: MediaQuery.sizeOf(context).height/1.4,

                                                                child: Column(
                                                                  children: [

                                                                    Align(
                                                                      alignment: Alignment.topLeft,
                                                                      child: CustomText(
                                                                        text: "Organization",
                                                                        fontSize:isTablet?6.sp: 14.sp,
                                                                        color: AppColors.black,
                                                                        fontWeight: FontWeight.bold,
                                                                        bottom: 8,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      alignment: Alignment.centerLeft,
                                                                      padding: EdgeInsets.all(12),
                                                                      decoration: BoxDecoration(
                                                                        color: AppColors.grey_3.withOpacity(0.5),
                                                                        borderRadius: BorderRadius.circular(15),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [

                                                                          CustomText(
                                                                            text: "${modelmission.name}",
                                                                            fontSize: 16,
                                                                            color: AppColors.black_80,
                                                                            fontWeight: FontWeight.w600,
                                                                            textAlign: TextAlign.start,
                                                                            left: 8,
                                                                          ),

                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 8,right: 8),
                                                                            child: CustomText(
                                                                              text: "${modelmission.description}",
                                                                              fontSize:isTablet?6.sp: 12.sp,
                                                                              color: AppColors.black_80,
                                                                              fontWeight: FontWeight.w400,
                                                                              textAlign: TextAlign.start,
                                                                              maxLines: 3,
                                                                              overflow: TextOverflow.ellipsis, // Add ellipsis at the end if the text overflows.
                                                                              // maxLines: 3,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 12,
                                                                    ),

                                                                    const Align(
                                                                      alignment: Alignment.topLeft,
                                                                      child: CustomText(
                                                                        text: "Add Organizer",
                                                                        fontSize: 14,
                                                                        color: AppColors.black,
                                                                        fontWeight: FontWeight.w500,
                                                                        bottom: 8,
                                                                      ),
                                                                    ),

                                                                    Container(
                                                                      ///padding: EdgeInsets.only(left: 8,right: 8),
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          color: Colors.white,
                                                                          boxShadow: [
                                                                            const BoxShadow(color: Colors.black, spreadRadius: 1),
                                                                          ],
                                                                        ),
                                                                        /// height: 70.h,
                                                                        child: ExpansionTile(
                                                                          title: CustomText(
                                                                            text: "Select Organizer",
                                                                            fontSize:isTablet? 6.sp:14.sp,
                                                                            color: AppColors.black,
                                                                            fontWeight: FontWeight.w500,
                                                                            textAlign: TextAlign.start,
                                                                          ),
                                                                          children:  [

                                                                            ///======== Search Bar ==============
                                                                            CustomTextField(
                                                                              hintText: "Search Organizer name",
                                                                              fillColor: AppColors.neutral02,
                                                                              suffixIcon:const Icon(
                                                                                FluentIcons.search_24_regular,
                                                                                size: 24,
                                                                              ),
                                                                              onChanged: (String value){
                                                                                if(value.isEmpty){

                                                                                  FocusScope.of(context).unfocus();

                                                                                  Future.delayed(Duration(seconds: 2), () {

                                                                                    administratorController.searchLeaderList("");
                                                                                  });

                                                                                }else{

                                                                                  administratorController.searchLeaderList(value);
                                                                                }
                                                                              },

                                                                            ),

                                                                            const SizedBox(
                                                                              height: 12,
                                                                            ),
                                                                            Column(
                                                                              children:  List.generate(
                                                                                  administratorController.leaderShowList.length,
                                                                                      (index){

                                                                                    final model = administratorController.leaderShowList[index];

                                                                                    return Column(
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Container(
                                                                                            height:isTablet?130.h: 110.h,
                                                                                            decoration: BoxDecoration(
                                                                                              color: AppColors.grey_3.withOpacity(0.5),
                                                                                              borderRadius: BorderRadius.circular(15),
                                                                                            ),
                                                                                            padding: EdgeInsets.all(12),
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [

                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [

                                                                                                    Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [

                                                                                                        CustomText(
                                                                                                          text: "${index+1 }.",
                                                                                                          fontSize: isTablet?6.sp:14.sp,
                                                                                                          color: AppColors.black_80,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                        ),

                                                                                                        CustomText(
                                                                                                          text: "${model.fullName}",
                                                                                                          fontSize:isTablet?6.sp: 14.sp,
                                                                                                          color: AppColors.black_80,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          overflow: TextOverflow.clip,
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),

                                                                                                  ],
                                                                                                ),

                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                                                                  children: [

                                                                                                    CustomText(
                                                                                                      text: "${model.profession}",
                                                                                                      fontSize: 12,
                                                                                                      color: AppColors.black_80,
                                                                                                      fontWeight: FontWeight.w400,
                                                                                                      textAlign: TextAlign.start,
                                                                                                      overflow: TextOverflow.clip,
                                                                                                    ),

                                                                                                    Row(
                                                                                                      children: [

                                                                                                        Checkbox(
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
                                                                                                          value: administratorController.presentLeaderIdList.contains(model.id.toString()),
                                                                                                          onChanged: (bool? value) {

                                                                                                            administratorController.selectedLeader.value = value!;

                                                                                                            if (administratorController.selectedLeader.value) {

                                                                                                              administratorController.presentLeaderIdList.add(model.id.toString());
                                                                                                            } else {
                                                                                                              administratorController.presentLeaderIdList.remove(model.id.toString());

                                                                                                            }
                                                                                                          },
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),

                                                                                                  ],
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  height: 4,
                                                                                                ),

                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  }
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                    ),

                                                                    SizedBox(
                                                                      height: 4.h,
                                                                    ),

                                                                    /*       administratorController.presentLeaderIdList.value.isNotEmpty?Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: CustomText(
                                                                          text: "${jsonEncode(administratorController.presentLeaderIdList.value)}",
                                                                          fontSize:isTablet? 6.sp:12.sp,
                                                                          color: AppColors.black,
                                                                          fontWeight: FontWeight.w400,
                                                                          textAlign: TextAlign.start,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          maxLines: administratorController.presentLeaderIdList.length,
                                                                        ),
                                                                      ):SizedBox(),*/

                                                                    /* if (administratorController.exitingLeaderIdList.value.isNotEmpty) Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: ListView.builder(
                                                                          // Makes ListView take up only required space
                                                                          shrinkWrap: true, // Makes ListView take up only the required space
                                                                          physics: NeverScrollableScrollPhysics(),
                                                                          scrollDirection: Axis.horizontal,
                                                                          itemCount: administratorController.exitingLeaderIdList.length,
                                                                          itemBuilder: (context, index) {
                                                                            return ListTile(
                                                                              title: Text(
                                                                                administratorController.exitingLeaderIdList[index],
                                                                                style: TextStyle(fontSize: 16, color: Colors.blue),
                                                                              ),
                                                                              trailing: IconButton(
                                                                                icon: Icon(Icons.remove_circle, color: Colors.red), // Remove icon
                                                                                onPressed: () {
                                                                                 // _removeName(index);  // Call remove function when clicked
                                                                                },
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ) else SizedBox(),
*/


                                                                    const SizedBox(
                                                                      height: 12,
                                                                    ),
                                                                    CustomFormCard(
                                                                        title: "Name",
                                                                        hintText: "Name",
                                                                        fontSize: isTablet?16:16,
                                                                        hasBackgroundColor: true,
                                                                        controller: administratorController.editMissionNameController.value),

                                                                    SizedBox(
                                                                      height: 12.h,
                                                                    ),

                                                                    CustomFormCard(
                                                                        title: "Description",
                                                                        hintText: "Description",
                                                                        fontSize: isTablet?16:16,
                                                                        hasBackgroundColor: true,
                                                                        controller: administratorController.editMissionDescriptionController.value),


                                                                    SizedBox(
                                                                      height: 8.h,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      children: [

                                                                        CustomText(
                                                                          text:
                                                                          "Access mode:",
                                                                          fontSize:
                                                                          14,
                                                                          color: AppColors
                                                                              .primary,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                        ),

                                                                        Radio<bool>(
                                                                          value:
                                                                          false, // Value for "No"
                                                                          fillColor:
                                                                          WidgetStateColor.resolveWith((states) =>
                                                                          AppColors.primary),
                                                                          groupValue: administratorController
                                                                              .missionStatues
                                                                              .value,
                                                                          onChanged:
                                                                              (bool?
                                                                          value) {
                                                                            administratorController
                                                                                .missionStatues
                                                                                .value = value!;

                                                                          },
                                                                        ),
                                                                        const CustomText(
                                                                          text:
                                                                          "private",
                                                                          fontSize:
                                                                          14,
                                                                          color: AppColors
                                                                              .black,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                        ),
                                                                        Radio<bool>(
                                                                          value:
                                                                          true, // Value for "Yes"
                                                                          fillColor:
                                                                          WidgetStateColor.resolveWith((states) =>
                                                                          AppColors.primary),
                                                                          groupValue: administratorController
                                                                              .missionStatues
                                                                              .value,
                                                                          onChanged:(bool? value) {

                                                                            administratorController
                                                                                .missionStatues
                                                                                .value = value!;

                                                                          },
                                                                        ),

                                                                        const CustomText(
                                                                          text:
                                                                          "public",
                                                                          fontSize:
                                                                          14,
                                                                          color: AppColors
                                                                              .black,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                        ),
                                                                      ],
                                                                    ),

                                                                    SizedBox(
                                                                      height: 8.h,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                                                                      child:administratorController.updateMissionLoading.value?CustomLoader(): CustomButton(
                                                                        onTap: () {

                                                                          if(administratorController.presentLeaderIdList.isEmpty){

                                                                            Toast.errorToast("Select Oranizer is Empty!!");

                                                                          }else if(administratorController.editMissionNameController.value.text==""){

                                                                            Toast.errorToast("Mission Name is Empty!!");

                                                                          }else if(administratorController.editMissionDescriptionController.value.text==""){

                                                                            Toast.errorToast("Mission description is Empty!!");
                                                                          }else{

                                                                            administratorController.editMission(modelmission.id.toString());

                                                                            if(administratorController.updateMissionLoading.value){
                                                                              Navigator.of(context).pop();
                                                                            }

                                                                            /*   administratorController.newOrganizers.value = administratorController.presentLeaderIdList.where((id)=> !administratorController.exitingLeaderIdList.contains(id)).toList();
                                                                              administratorController.removedOrganizers.value = administratorController.exitingLeaderIdList.where((id)=> !administratorController.presentLeaderIdList.contains(id)).toList();
                                                                              print("New Organizer: ${administratorController.newOrganizers.value}");

                                                                              print("Removed Organizer: ${administratorController.removedOrganizers.value}");

                                                                              print("presentLeaderIdList1:${administratorController.presentLeaderIdList}");

                                                                              print("exitingLeaderIdList:${administratorController.exitingLeaderIdList}");*/

                                                                          }

                                                                        },
                                                                        title: "Edit",
                                                                        height: 60.h,
                                                                        textColor: AppColors.black,
                                                                        fillColor: AppColors.primary,
                                                                        fontSize: 12,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                      ),
                                                    ),
                                                  );
                                                },
                                                title: "Edit",
                                                width: 90.w,
                                                height: 32.h,
                                                textColor: AppColors.black,
                                                fillColor: AppColors.primary,
                                                fontSize: 12,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
