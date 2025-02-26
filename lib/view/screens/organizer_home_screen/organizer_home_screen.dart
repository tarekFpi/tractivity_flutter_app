// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/nav_bar/organizer_navbar.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/inner_widget/custom_explore_container.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/user_profile_screen.dart';

class OrganizerHomeScreen extends StatefulWidget {
   OrganizerHomeScreen({super.key});

  @override
  State<OrganizerHomeScreen> createState() => _OrganizerHomeScreenState();
}

class _OrganizerHomeScreenState extends State<OrganizerHomeScreen> {

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
          title: Text(
           "Organizer",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding:   EdgeInsets.symmetric(horizontal: 16, vertical: isTablet?28:0),
          child: Obx(
             () {
              return Column(
                children: [

                  ///=============== Recemt Events Tab Bar ===============
                  SizedBox(height: 16,),

                  CustomTabSingleText(
                      fontSize: isTablet?24:16,
                      tabs: organizerController.nameList,
                      selectedIndex: organizerController.currentIndex.value,
                      onTabSelected: (value) {
                        organizerController.currentIndex.value = value;
                       setState(() {});
                      },
                      selectedColor: AppColors.primary,
                      unselectedColor: AppColors.grey_1
                  ),
                  SizedBox(height: 16,),
                  ///============ Invited Mission ==================
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [

                        if(organizerController.currentIndex.value ==0)
                          Column(
                              children: List.generate(3, (index) {
                                return InkWell(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.organizerMissionDetailsScreen);
                                    storage.write("status_charts", "Inactive");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:isTablet?150.h: 140.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.grey_3.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(left: 8,right: 8),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                CustomText(
                                                  text: "${index+1}.Mission Horizons Foundation",
                                                  fontSize: 16,
                                                  color: AppColors.black_80,
                                                  fontWeight: FontWeight.w600,
                                                ),

                                                const CustomText(
                                                  text: "22-12-2025",
                                                  fontSize: 12,
                                                  color: AppColors.black_80,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 12,right: 8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                CustomText(
                                                  text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                                                  fontSize:isTablet?6.sp: 12.sp,
                                                  color: AppColors.black_80,
                                                  fontWeight: FontWeight.w400,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 2,// Add ellipsis at the end if the text overflows.
                                                ),

                                                SizedBox(
                                                  height: 6.h,
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
                                                            title: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [

                                                                const CustomText(
                                                                  text: "",
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

                                                                      },
                                                                      child: const Icon(
                                                                        Icons.close,
                                                                        size: 32,
                                                                        color: Colors.black,
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                            content: SizedBox(
                                                              width: MediaQuery.sizeOf(context).width,
                                                              child: SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [

                                                                    SvgPicture.asset(
                                                                      'assets/images/join_mission.svg',
                                                                      semanticsLabel: 'My SVG Image',
                                                                      height:isTablet?200.h: 170.h,
                                                                      width: MediaQuery.of(context).size.width,
                                                                    ),

                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [

                                                                        Image.asset("assets/images/check.png",width: 24.w,height: 24.h,),

                                                                        CustomText(
                                                                          text: "Joined",
                                                                          fontSize: 24,
                                                                          color: AppColors.black,
                                                                          fontWeight: FontWeight.w500,
                                                                          bottom: 8,
                                                                        )
                                                                      ],
                                                                    ),

                                                                    CustomText(
                                                                      text: "Thanks for join the mission 🎉",
                                                                      fontSize:isTablet?8.sp: 18.sp,
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.w500,
                                                                      bottom: 8,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      title: "Accept",
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

                                                        showDialog(
                                                          context: context,
                                                          builder: (ctx) => AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            insetPadding: EdgeInsets.all(8),
                                                            contentPadding: EdgeInsets.all(8),
                                                            title: SizedBox(),
                                                            content: SizedBox(
                                                              width: MediaQuery.sizeOf(context).width,
                                                              child: AlertDialogEvent(title: "Are you sure you want to \n Reject this Mission?",discription: "",),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      title: "Reject",
                                                      width: 70.w,
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
                              })),

                        ///============ mission List ========
                        if(organizerController.currentIndex.value ==1)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [

                                      Radio<bool>(
                                        value:
                                        false, // Value for "No"
                                        fillColor:
                                        WidgetStateColor.resolveWith((states) =>
                                        AppColors.primary),
                                        groupValue: organizerController.missionActiveInactiveStatus.value,
                                        onChanged:(bool?value) {

                                          organizerController.missionActiveInactiveStatus.value = value!;

                                        },
                                      ),
                                      CustomText(
                                        text:
                                        "Active",
                                        fontSize:
                                        14,
                                        color: AppColors.primary,
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
                                        groupValue: organizerController.missionActiveInactiveStatus.value,
                                        onChanged:(bool? value) {

                                          organizerController.missionActiveInactiveStatus.value= value!;

                                        },
                                      ),

                                      const CustomText(
                                        text:
                                        "Inactive",
                                        fontSize:
                                        14,
                                        color: AppColors
                                            .primary,
                                        fontWeight:
                                        FontWeight
                                            .w600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              /// mission active list
                              if(organizerController.missionActiveInactiveStatus.value==false)
                                Column(
                                    children: List.generate(3, (index) {
                                      return InkWell(
                                        onTap: (){

                                          Get.toNamed(AppRoutes.organizerActiveMissionDetails);

                                          storage.write("status_charts", "active");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height:isTablet?150.h: 140.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey_3.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8,right: 8),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      CustomText(
                                                        text: "${index+1}.Mission Horizons Foundation",
                                                        fontSize: 16,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w600,
                                                      ),

                                                      const CustomText(
                                                        text: "22-12-2025",
                                                        fontSize: 12,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 12,right: 8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [

                                                      CustomText(
                                                        text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                                                        fontSize:isTablet?6.sp: 12.sp,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w400,
                                                        textAlign: TextAlign.start,
                                                        overflow: TextOverflow.clip,
                                                        maxLines: 2,// Add ellipsis at the end if the text overflows.
                                                      ),

                                                      SizedBox(
                                                        height: 6.h,
                                                      ),
                                                      Row(
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
                                                                      ///Edit Mission
                                                                      const CustomText(
                                                                        text: "Edit active mission",
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
                                                                                        text: "Donation Administrator",
                                                                                        fontSize: 16,
                                                                                        color: AppColors.black_80,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        textAlign: TextAlign.start,
                                                                                        left: 8,
                                                                                      ),

                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                                                                        child: CustomText(
                                                                                          text: "Empowering communities  worldwide  through education, healthcare.",
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

                                                                                const SizedBox(
                                                                                  height: 12,
                                                                                ),
                                                                                CustomFormCard(
                                                                                    title: "Name",
                                                                                    hintText: "Name",
                                                                                    fontSize: isTablet?16:16,
                                                                                    hasBackgroundColor: true,
                                                                                    controller: administratorController.missionNameController.value),

                                                                                SizedBox(
                                                                                  height: 12.h,
                                                                                ),

                                                                                CustomFormCard(
                                                                                    title: "Description",
                                                                                    hintText: "Description",
                                                                                    fontSize: isTablet?16:16,
                                                                                    hasBackgroundColor: true,
                                                                                    controller: administratorController.missionDescriptionController.value),

                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                                                      value: organizerController.missionActiveInactiveStatus.value,
                                                                                      onChanged: (bool? value) {
                                                                                        organizerController.missionActiveInactiveStatus.value = value!;
                                                                                      },
                                                                                    ),

                                                                                    CustomText(
                                                                                      text: "mark as Inactive",
                                                                                      fontSize:isTablet?8.sp: 14.sp,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      color: AppColors.primary,
                                                                                    ),

                                                                                  ],
                                                                                ),

                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12,top: 12),
                                                                                  child: CustomButton(
                                                                                    onTap: () {

                                                                                      if(administratorController.organizationIdList.isEmpty){
                                                                                        Toast.errorToast("Select Oranization is Empty!!");
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

                                                          SizedBox(
                                                            width:isTablet?12.h: 8.h,
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
                                                                    child: AlertDialogEvent(title: "Are you sure you want to \n Delete this Mission?",discription: "",),
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
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })),

                              /// mission Inactive list
                              if(organizerController.missionActiveInactiveStatus.value==true)
                                Column(
                                    children: List.generate(3, (index) {
                                      return InkWell(
                                        onTap: (){
                                          Get.toNamed(AppRoutes.organizerInactiveMissionDetails);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height:isTablet?150.h: 140.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey_3.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8,right: 8),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      CustomText(
                                                        text: "${index+1}.Mission Horizons Foundation",
                                                        fontSize: 16,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w600,
                                                      ),

                                                      const CustomText(
                                                        text: "22-12-2025",
                                                        fontSize: 12,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 12,right: 8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [

                                                      CustomText(
                                                        text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                                                        fontSize:isTablet?6.sp: 12.sp,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w400,
                                                        textAlign: TextAlign.start,
                                                        overflow: TextOverflow.clip,
                                                        maxLines: 2,// Add ellipsis at the end if the text overflows.
                                                      ),

                                                      SizedBox(
                                                        height: 6.h,
                                                      ),
                                                      Row(
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
                                                                      ///Edit Mission
                                                                      const CustomText(
                                                                        text: "Edit Inactive mission",
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
                                                                                  padding: EdgeInsets.all(8),
                                                                                  decoration: BoxDecoration(
                                                                                    color: AppColors.grey_5.withOpacity(0.5),
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [

                                                                                      CustomText(
                                                                                        text: "Donation Administrator",
                                                                                        fontSize: 16,
                                                                                        color: AppColors.black_80,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        textAlign: TextAlign.start,
                                                                                        left: 8,
                                                                                      ),

                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 8,right: 8),
                                                                                        child: CustomText(
                                                                                          text: "Empowering communities  worldwide  through education, healthcare.",
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

                                                                                const SizedBox(
                                                                                  height: 12,
                                                                                ),
                                                                                CustomFormCard(
                                                                                    title: "Name",
                                                                                    hintText: "Name",
                                                                                    fontSize: isTablet?16:16,
                                                                                    hasBackgroundColor: true,
                                                                                    controller: administratorController.missionNameController.value),

                                                                                SizedBox(
                                                                                  height: 12.h,
                                                                                ),

                                                                                CustomFormCard(
                                                                                    title: "Description",
                                                                                    hintText: "Description",
                                                                                    fontSize: isTablet?16:16,
                                                                                    hasBackgroundColor: true,
                                                                                    controller: administratorController.missionDescriptionController.value),

                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                                                      value: organizerController.missionMarkasActiveStatus.value,
                                                                                      onChanged: (bool? value) {
                                                                                        organizerController.missionMarkasActiveStatus.value = value!;
                                                                                      },
                                                                                    ),

                                                                                    CustomText(
                                                                                      text: "mark as Active",
                                                                                      fontSize:isTablet?6.sp: 14.sp,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      color: AppColors.primary,
                                                                                    ),

                                                                                  ],
                                                                                ),

                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12,top: 12),
                                                                                  child: CustomButton(
                                                                                    onTap: () {

                                                                                      if(administratorController.organizationIdList.isEmpty){
                                                                                        Toast.errorToast("Select Oranization is Empty!!");
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

                                                          SizedBox(
                                                            width:isTablet?12.h: 8.h,
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
                                                                    child: AlertDialogEvent(title: "Are you sure you want to \n Delete this Mission?",discription: "",),
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
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                            ],
                          ),

                      ],
                    ),
                  )
                ],
              );
            }
          ),
        ),

      );
    });
  }
}
