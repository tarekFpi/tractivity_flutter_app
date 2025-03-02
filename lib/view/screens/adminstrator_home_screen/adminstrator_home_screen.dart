// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_images/app_images.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';

class AdminstratorHomeScreen extends StatefulWidget {
  const AdminstratorHomeScreen({super.key});

  @override
  State<AdminstratorHomeScreen> createState() => _AdminstratorHomeScreenState();
}

class _AdminstratorHomeScreenState extends State<AdminstratorHomeScreen> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final OrganizerController organizerController = Get.find<OrganizerController>();

  final administratorController = Get.put(AdministratiorController());

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        key: _scaffoldKey,
        drawer: HomeSideDrawer(),
        //drawerScrimColor: Colors.black,
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                    Icons.menu,
                    color: AppColors.primary,
                    size: isTablet?28.w:24.w
                ));
          }),
          title: Text("Adminstratior",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(
                  () {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(

                    children: [

                      ///=============== Recemt Events Tab Bar ===============
                      SizedBox(height: 8.h,),

                      CustomTabSingleText(
                          fontSize: isTablet?24:16,
                          tabs: administratorController.adminstratiorNameList,
                          selectedIndex: administratorController.adminstratior_currentIndex.value,
                          onTabSelected: (value) {
                            administratorController.adminstratior_currentIndex.value = value;
                            setState(() {

                            });
                          },
                          selectedColor: AppColors.primary,
                          unselectedColor: AppColors.grey_1
                      ),

                      const SizedBox(height: 20,),

                      ///============  organization show  Event ==============================
                      if(administratorController.adminstratior_currentIndex.value==0)

                        administratorController.organizationShowList.isEmpty?
                        SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          child: Center(
                            child: CustomText(
                              text: "No organization  yet!!",
                              fontSize:isTablet?12.sp: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightRed,
                            ),
                          ),
                        ):
                        administratorController.organizationShowLoading.value?CustomLoader():
                        Column(
                            children: List.generate(administratorController.organizationShowList.length, (index) {

                              final model = administratorController.organizationShowList[index];

                              return GestureDetector(
                                onTap: (){

                               Get.toNamed(AppRoutes.adminstratorOrganizationDetailsScreen, arguments: [
                                 {
                                   "organizationId":model.id,
                                   "organizationShowList":model,
                                 }
                               ]);

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height:isTablet?150.h: 140.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey_3.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: const EdgeInsets.only(top: 12,left: 8,right: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            CustomText(
                                              text: "${index+1}.${model.name}",
                                              fontSize: 16,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w600,
                                            ),

                                            CustomText(
                                              text: DateConverter.timeFormetString("${model.createdAt}"),
                                              fontSize: 12,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 6,
                                        ),

                                        Flexible(
                                          child: CustomText(
                                            text: "${model.description}",
                                            fontSize:isTablet?6.sp: 12.sp,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),


                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [


                                                CustomButton(
                                                  onTap: () {

                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (ctx) => AlertDialog(
                                                        backgroundColor: Colors.white,
                                                        insetPadding: EdgeInsets.all(8),
                                                        contentPadding: EdgeInsets.all(8),
                                                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        title:Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [

                                                            const CustomText(
                                                              text: "Create Mission",
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

                                                                    administratorController.createLeaderIdList.clear();
                                                                    administratorController.missionNameController.value.clear();
                                                                    administratorController.missionDescriptionController.value.clear();

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
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                        width: double.infinity,
                                                                        padding: EdgeInsets.all(8),
                                                                        decoration: BoxDecoration(
                                                                          color: AppColors.grey_3.withOpacity(0.5),
                                                                          borderRadius: BorderRadius.circular(15),
                                                                        ),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [

                                                                            CustomText(
                                                                              text: "${model.name}",
                                                                              fontSize: 16,
                                                                              color: AppColors.black_80,
                                                                              fontWeight: FontWeight.w600,
                                                                              textAlign: TextAlign.start,
                                                                              left: 8,
                                                                            ),

                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 8,right: 8),
                                                                              child: CustomText(
                                                                                text: "${model.description}",
                                                                                fontSize:isTablet?6.sp: 12.sp,
                                                                                color: AppColors.black_80,
                                                                                fontWeight: FontWeight.w400,
                                                                                textAlign: TextAlign.start,
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis, // Add ellipsis at the end if the text overflows.
                                                                                // maxLines: 3,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                        SizedBox(
                                                                        height: 12.h,
                                                                      ),

                                                                      Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: CustomText(
                                                                          text: "Add Organizer",
                                                                          fontSize:isTablet?6.sp: 16.sp,
                                                                          color: AppColors.black,
                                                                          fontWeight: FontWeight.bold,
                                                                          bottom: 8,
                                                                        ),
                                                                      ),

                                                                      Container(
                                                                        ///    padding: EdgeInsets.only(left: 8,right: 8),
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
                                                                            children: [

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
                                                                                              height:isTablet?130.h: 120.h,
                                                                                              decoration: BoxDecoration(
                                                                                                color: AppColors.grey_3.withOpacity(0.5),
                                                                                                borderRadius: BorderRadius.circular(15),
                                                                                              ),
                                                                                              padding: EdgeInsets.all(12),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                                                                            ///value: administratorController.selectedOranization.value,
                                                                                                            value: administratorController.createLeaderIdList.contains(model.id),
                                                                                                            onChanged: (bool? value) {

                                                                                                              administratorController.selectedLeader.value = value!;

                                                                                                              if(administratorController.selectedLeader.value){

                                                                                                                administratorController.createLeaderIdList.add(model.id.toString());
                                                                                                              }else{
                                                                                                                administratorController.createLeaderIdList.remove(model.id.toString());
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
                                                                      administratorController.createLeaderIdList.value.isNotEmpty? Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Flexible(
                                                                          child: CustomText(
                                                                            text: "${jsonEncode(administratorController.createLeaderIdList.value)}",
                                                                            fontSize:isTablet? 6.sp:12.sp,
                                                                            color: AppColors.black,
                                                                            fontWeight: FontWeight.w400,
                                                                            textAlign: TextAlign.start,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            maxLines: administratorController.createLeaderIdList.length,
                                                                          ),
                                                                        ),
                                                                      ):SizedBox(),

                                                                      const SizedBox(
                                                                        height: 12,
                                                                      ),
                                                                      CustomFormCard(
                                                                          title: "Name",
                                                                          hintText: "Name",
                                                                          fontSize: isTablet?16:16,
                                                                          hasBackgroundColor: true,
                                                                          controller: administratorController.missionNameController.value),

                                                                      const SizedBox(
                                                                        height: 12,
                                                                      ),

                                                                      CustomFormCard(
                                                                          title: "Description",
                                                                          hintText: "Description",
                                                                          fontSize: isTablet?16:16,
                                                                          hasBackgroundColor: true,
                                                                          controller: administratorController.missionDescriptionController.value),

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
                                                                        child:administratorController.createMissionLoading.value?CustomLoader():
                                                                        CustomButton(
                                                                          onTap: () {

                                                                              if(administratorController.createLeaderIdList.isEmpty){

                                                                              Toast.errorToast("Select Oranizer name is Empty!!");

                                                                            }else if(administratorController.missionNameController.value.text==""){

                                                                                Toast.errorToast("Mission name is Empty!!");

                                                                           }else if(administratorController.missionDescriptionController.value.text==""){

                                                                                Toast.errorToast("Mission description is Empty!!");
                                                                           }else{

                                                                                administratorController.organizationIdList.add(model.id.toString());

                                                                                administratorController.createMission();

                                                                                if(administratorController.createMissionLoading.value){
                                                                                  Navigator.of(context).pop();
                                                                                }
                                                                              }

                                                                          },
                                                                          title: "create",
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
                                                  title: "Create Mission",
                                                  width: 120.w,
                                                  height: 32.h,
                                                  textColor: AppColors.black,
                                                  fillColor: AppColors.primary,
                                                  fontSize: 12,
                                                ),

                                                SizedBox(
                                                  width: 8.h,
                                                ),

                                                /// edit Organization
                                                CustomButton(
                                                  onTap: () {

                                                    administratorController.editOrganizationNameController.value.text=model.name.toString();
                                                    administratorController.editOrganizationDescriptionController.value.text=model.description.toString();

                                                    showDialog(
                                                      context: context,
                                                      builder: (ctx) => AlertDialog(
                                                        backgroundColor: Colors.white,
                                                        insetPadding: EdgeInsets.all(8),
                                                        contentPadding: EdgeInsets.all(8),
                                                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        title:Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [

                                                            Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: CustomText(
                                                                text: "Edit Organization",
                                                                fontSize: 24,
                                                                color: AppColors.black,
                                                                fontWeight: FontWeight.w500,
                                                                bottom: 8,
                                                              ),
                                                            ),

                                                            Align(
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
                                                            )
                                                          ],
                                                        ),
                                                        content: SingleChildScrollView(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: SizedBox(
                                                              width: MediaQuery.sizeOf(context).width,
                                                              child: Column(
                                                                children: [

                                                                  CustomFormCard(
                                                                    title: "Organization Name",
                                                                    hintText: "Organization Name",
                                                                    hasBackgroundColor: true,
                                                                    fontSize: isTablet?16:16,
                                                                    controller: administratorController.editOrganizationNameController.value,
                                                                  ),

                                                                  CustomFormCard(
                                                                      title: "Description",
                                                                      hintText: "Description",
                                                                      hasBackgroundColor: true,
                                                                      fontSize: isTablet?16:16,
                                                                      controller: administratorController.editOrganizationDescriptionController.value),

                                                                  Obx(()=> Padding(
                                                                    padding: const EdgeInsets.only(left: 12,right: 12),
                                                                    child:administratorController.editOrganLoading.value?CustomLoader(): CustomButton(
                                                                      onTap: () {

                                                                        if(administratorController.editOrganizationNameController.value.text==""){

                                                                          Toast.errorToast("name cannot be empty!");

                                                                        }else if(administratorController.editOrganizationDescriptionController.value.text==""){

                                                                          Toast.errorToast("description cannot be empty!");
                                                                        }else{

                                                                          administratorController.editOrganization(model.id.toString());

                                                                          if(administratorController.editOrganLoading.value){
                                                                            Navigator.of(context).pop();
                                                                          }
                                                                        }
                                                                      },
                                                                      title: "Edit",
                                                                      height: 45.h,
                                                                      textColor: AppColors.black,
                                                                      fillColor: AppColors.primary,
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  title: "Edit",
                                                  width: 70.w,
                                                  height: 32.h,
                                                  textColor: AppColors.black,
                                                  fillColor: AppColors.primary,
                                                  fontSize: 12,
                                                ),

                                                SizedBox(
                                                  width: 8.h,
                                                ),
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
                                                                  text:"Are you sure you want to \n delete ?",
                                                                  fontSize: 22,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: AppColors.black_80,
                                                                ),

                                                                SizedBox(
                                                                  height: 8.h,
                                                                ),

                                                                administratorController.organizationDeleteLoading.value?CircularProgressIndicator(color: AppColors.primary,):
                                                                CustomButton(onTap: (){


                                                                  administratorController.organizationDelete("${model.id}");
                                                                  if(administratorController.organizationDeleteLoading.value){
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
                                                  width: 70.w,
                                                  height: 32.h,
                                                  textColor: AppColors.black,
                                                  fillColor: AppColors.primary,
                                                  fontSize: 12,
                                                ),

                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),

                      ///============  Mission show  Event ==============================
                      if(administratorController.adminstratior_currentIndex.value==1)

                        administratorController.missionShowList.isEmpty?
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
                        ):administratorController.missionShowLoading.value?CustomLoader():
                        Column(
                            children: List.generate(administratorController.missionShowList.length, (index) {

                              final modelmission = administratorController.missionShowList[index];


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
                                    height:isTablet?140.h: 130.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey_3.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              CustomText(
                                                text: "${index+1}.${modelmission.name}",
                                                fontSize: 16,
                                                color: AppColors.black_80,
                                                fontWeight: FontWeight.w600,
                                              ),

                                              CustomText(
                                                text: DateConverter.timeFormetString("${modelmission.updatedAt}"),
                                                fontSize: 12,
                                                color: AppColors.black_80,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),

                                            SizedBox(
                                            height: 6.h,
                                          ),
                                          CustomText(
                                            text: "${modelmission.description}",
                                            fontSize: 12,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,// Add ellipsis at the end if the text overflows.
                                          ),

                                          Expanded(
                                            child: Row(
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
                                                  width:isTablet?16.w: 12.w,
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

                                                        //  administratorController.presentLeaderIdList.refresh();

                                                          administratorController.exitingLeaderIdList.add(element.id.toString());

                                                          debugPrint("exitingLeaderIdList:${administratorController.exitingLeaderIdList.value}");
                                                        }

                                                        /// example: Print the name of the organizer
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
                                                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                                  width: 80.w,
                                                  height: 32.h,
                                                  textColor: AppColors.black,
                                                  fillColor: AppColors.primary,
                                                  fontSize: 12,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),


                    ],
                  ),
                );
              }
          ),
        ),
        bottomNavigationBar:Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            if(administratorController.adminstratior_currentIndex.value==0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onTap: () {

                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.white,
                        insetPadding: EdgeInsets.all(8),
                        contentPadding: EdgeInsets.all(8),
                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                        title:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                text: "Create Organization",
                                fontSize: 24,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                bottom: 8,
                              ),
                            ),

                            Align(
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
                            )
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: Column(
                                children: [

                                  CustomFormCard(
                                    title: "Organization Name",
                                    hintText: "Organization Name",
                                    hasBackgroundColor: true,
                                    fontSize: isTablet?16:16,
                                    controller: administratorController.organizationNameController.value,
                                  ),

                                  CustomFormCard(
                                      title: "Description",
                                      hintText: "Description",
                                      hasBackgroundColor: true,
                                      fontSize: isTablet?16:16,
                                      controller: administratorController.organizationDescriptionController.value),

                                  Obx(()=> Padding(
                                    padding: const EdgeInsets.only(left: 12,right: 12),
                                    child:administratorController.createOrganLoading.value?CustomLoader(): CustomButton(
                                      onTap: () {

                                        if(administratorController.organizationDescriptionController.value.text==""){

                                          Toast.errorToast("name cannot be empty!");

                                        }else if(administratorController.organizationDescriptionController.value.text==""){

                                          Toast.errorToast("description cannot be empty!");
                                        }else{

                                          administratorController.createOrganization();

                                          if(administratorController.createOrganLoading.value){
                                            Navigator.of(context).pop();
                                          }

                                        }
                                      },
                                      title: "Done",
                                      height: 45.h,
                                      textColor: AppColors.black,
                                      fillColor: AppColors.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  title: "Create Organization",
                  height: 45.h,
                  textColor: AppColors.black,
                  fillColor: AppColors.primary,
                  fontSize: 12,
                ),
              ),

            if(administratorController.adminstratior_currentIndex.value==1)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomButton(
                  onTap: () {

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

                            const CustomText(
                              text: "Create Mission",
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
                                    administratorController.organizationIdList.clear();
                                    administratorController.createLeaderIdList.clear();
                                    administratorController.organizationShow();
                                    administratorController.leaderShow();
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
                                          text: "Add Organization",
                                          fontSize:isTablet?10.sp: 14.sp,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          bottom: 4.sp,
                                        ),
                                      ),

                                      Container(
                                          padding: EdgeInsets.only(left: 4.sp,right: 4.sp),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(color: Colors.black, spreadRadius: 1),
                                            ],
                                          ),
                                          // height: 70.h,
                                          child: ExpansionTile(
                                            title: CustomText(
                                              text: "Select Organization",
                                              fontSize:isTablet? 6.sp:14.sp,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.start,
                                            ),
                                            children: [

                                              ///======== Organization Search Bar ==============
                                              CustomTextField(
                                                hintText: "Search organization name",
                                                fillColor: AppColors.neutral02,
                                                suffixIcon:const Icon(
                                                  FluentIcons.search_24_regular,
                                                  size: 24,
                                                ),
                                                onChanged: (String value){
                                                  if(value.isEmpty){

                                                    FocusScope.of(context).unfocus();

                                                    administratorController.searchOragizationLoading.value?CircularProgressIndicator(color: AppColors.primary,):
                                                    administratorController.searchOrganizationList("");

                                                  }else{

                                                    Future.delayed(Duration(seconds: 1), () {

                                                      administratorController.searchOragizationLoading.value?CircularProgressIndicator(color: AppColors.primary,):
                                                      administratorController.searchOrganizationList(value);
                                                    });

                                                  }
                                                },

                                              ),

                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Obx(
                                                ()=> Column(
                                                  children:  List.generate(
                                                      administratorController.organizationShowList.length,
                                                          (index) {

                                                        final model = administratorController.organizationShowList[index];

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
                                                                              text: "${index+1}.",
                                                                              fontSize: isTablet?6.sp:14.sp,
                                                                              color: AppColors.black_80,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),

                                                                            CustomText(
                                                                              text: "${model.name}",
                                                                              fontSize:isTablet?6.sp: 14.sp,
                                                                              color: AppColors.black_80,
                                                                              fontWeight: FontWeight.w600,
                                                                              overflow: TextOverflow.clip,
                                                                              textAlign: TextAlign.start,
                                                                            ),
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),

                                                                    const SizedBox(
                                                                      height: 4,
                                                                    ),

                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    //  crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [

                                                                        Expanded(
                                                                          child: CustomText(
                                                                            text: "${model.description}",
                                                                            fontSize: 12,
                                                                            color: AppColors.black_80,
                                                                            fontWeight: FontWeight.w400,
                                                                            textAlign: TextAlign.start,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            maxLines: 3,
                                                                          ),
                                                                        ),

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
                                                                          ///value: administratorController.selectedOranization.value,
                                                                          value: administratorController.organizationIdList.contains(model.id),
                                                                          onChanged: (bool? value) {

                                                                            administratorController.selectedOranization.value = value!;

                                                                            if(administratorController.selectedOranization.value){

                                                                              administratorController.organizationIdList.add(model.id.toString());
                                                                            }else{
                                                                              administratorController.organizationIdList.remove(model.id.toString());
                                                                            }

                                                                          },
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
                                                ),
                                              )
                                            ],
                                          )
                                      ),

                                        SizedBox(
                                        height: 12.h,
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
                                        ///    padding: EdgeInsets.only(left: 8,right: 8),
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
                                              text: "Select Leader",
                                              fontSize:isTablet? 6.sp:14.sp,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500,
                                              textAlign: TextAlign.start,
                                            ),
                                            children:  [

                                              ///======== Search Bar ==============
                                              CustomTextField(
                                                hintText: "Search Leader name",
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
                                                              height:isTablet?130.h: 120.h,
                                                              decoration: BoxDecoration(
                                                                color: AppColors.grey_3.withOpacity(0.5),
                                                                borderRadius: BorderRadius.circular(15),
                                                              ),
                                                              padding: EdgeInsets.all(12),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                                            ///value: administratorController.selectedOranization.value,
                                                                            value: administratorController.createLeaderIdList.contains(model.id),
                                                                            onChanged: (bool? value) {

                                                                              administratorController.selectedLeader.value = value!;

                                                                              if(administratorController.selectedLeader.value){

                                                                                administratorController.createLeaderIdList.add(model.id.toString());
                                                                              }else{
                                                                                administratorController.createLeaderIdList.remove(model.id.toString());
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
                                      administratorController.createLeaderIdList.value.isNotEmpty? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Flexible(
                                          child: CustomText(
                                            text: "${jsonEncode(administratorController.createLeaderIdList.value)}",
                                            fontSize:isTablet? 6.sp:12.sp,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: administratorController.createLeaderIdList.length,
                                          ),
                                        ),
                                      ):SizedBox(),

                                      const SizedBox(
                                        height: 12,
                                      ),
                                      CustomFormCard(
                                          title: "Name",
                                          hintText: "Name",
                                          fontSize: isTablet?16:16,
                                          hasBackgroundColor: true,
                                          controller: administratorController.missionNameController.value),

                                      const SizedBox(
                                        height: 12,
                                      ),

                                      CustomFormCard(
                                          title: "Description",
                                          hintText: "Description",
                                          fontSize: isTablet?16:16,
                                          hasBackgroundColor: true,
                                          controller: administratorController.missionDescriptionController.value),


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
                                        child:administratorController.createMissionLoading.value?CustomLoader(): CustomButton(
                                          onTap: () {

                                            if(administratorController.organizationIdList.isEmpty){
                                              Toast.errorToast("Select oranization name is Empty!!");
                                            }else if(administratorController.createLeaderIdList.isEmpty){
                                              Toast.errorToast("Select leader name is Empty!!");

                                            }else if(administratorController.missionNameController.value.text==""){
                                              Toast.errorToast("Mission name is Empty!!");

                                            }else if(administratorController.missionDescriptionController.value.text==""){
                                              Toast.errorToast("Mission Description is Empty!!");
                                            }else{

                                              administratorController.createMission();

                                              if(administratorController.createMissionLoading.value){
                                                Navigator.of(context).pop();
                                              }
                                            }

                                          },
                                          title: "Create",
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
                  title: "Create Mission",
                  height: 45.h,
                  textColor: AppColors.black,
                  fillColor: AppColors.primary,
                  fontSize: 12,
                ),
              ),

            SizedBox(
              height: 12.h,
            )
          ],
        ),
      );
    });
  }
}
