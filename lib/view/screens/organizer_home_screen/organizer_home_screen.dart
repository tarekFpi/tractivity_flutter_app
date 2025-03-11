// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';


class OrganizerHomeScreen extends StatefulWidget {
   OrganizerHomeScreen({super.key});

  @override
  State<OrganizerHomeScreen> createState() => _OrganizerHomeScreenState();
}

class _OrganizerHomeScreenState extends State<OrganizerHomeScreen> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final  organizerController = Get.find<OrganizerController>();

  final administratorController = Get.put(AdministratiorController());

  final storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //organizerController.retriveInvitedMissionsShow();
   // organizerController.retrieveMissionsActive();
   // organizerController.retrieveMissionsInActive();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        key: _scaffoldKey,
        drawer: HomeSideDrawer(),
        //drawerScrimColor: Colors.black,
        floatingActionButton: FloatingActionButton(onPressed: (){

         if(organizerController.currentIndex.value==0){
           organizerController.retriveInvitedMissionsShow();
         }

         if(organizerController.currentIndex.value==1){
           organizerController.retrieveMissionsActive();
           organizerController.retrieveMissionsInActive();
         }

        },child: Icon(Icons.refresh,color: Colors.white,),backgroundColor: AppColors.primary,),
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
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16, vertical: isTablet?28:0),
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
                        // setState(() {});
                        },
                        selectedColor: AppColors.primary,
                        unselectedColor: AppColors.grey_1
                    ),
                    SizedBox(height: 16,),

                    ///============ Invited Mission ==================
                    if(organizerController.currentIndex.value ==0)

                   /* organizerController.retriveInvitedMissionsList.isEmpty?
                    SizedBox(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: CustomText(
                          text: "No invited Mission yet!!",
                          fontSize:isTablet?12.sp: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightRed,
                        ),
                      ),
                    ):organizerController.retriveInvitedMissionsLoading.value?CircularProgressIndicator(color: Colors.amber,):*/

                    RefreshIndicator(child:organizerController.retriveInvitedMissionsList.isEmpty?
                    SizedBox(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: CustomText(
                          text: "No invited Mission yet!!",
                          fontSize:isTablet?12.sp: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightRed,
                        ),
                      ),
                    ):organizerController.retriveInvitedMissionsLoading.value?CircularProgressIndicator(color: Colors.amber,): ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: organizerController.retriveInvitedMissionsList.length,
                        itemBuilder: (BuildContext context,index){

                          final model = organizerController.retriveInvitedMissionsList[index];

                          return InkWell(
                            onTap: (){
                              Get.toNamed(AppRoutes.organizerMissionDetailsScreen,arguments: [
                                {
                                  "missionId":model.contentId?.id,
                                }
                              ]);
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          CustomText(
                                            text: "${index+1}.${model.contentId?.name}",
                                            fontSize: 16,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w600,
                                          ),

                                          CustomText(
                                            text: DateConverter.timeFormetString("${model.contentId?.createdAt}"),
                                            fontSize: 12,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 12,right: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          CustomText(
                                            text: "${model.contentId?.description}",
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

                                              organizerController.acceptMissionsInvitationLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                                              CustomButton(
                                                onTap: () {

                                                  organizerController.acceptMissionsInvitationShow(model.id.toString());
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
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [

                                                              const CustomText(
                                                                text:"Are you sure you want to \n Reject this Mission?",
                                                                fontSize: 22,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.black_80,
                                                              ),

                                                              SizedBox(
                                                                height: 8.h,
                                                              ),

                                                              organizerController.rejectMissionsInvitationLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                                                              CustomButton(onTap: (){

                                                                organizerController.rejectMissionsInvitation(model.id.toString());

                                                                if(organizerController.rejectMissionsInvitationLoading.value){
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
                        }),
                       onRefresh:organizerController.retriveInvitedMissionsShow,
                    ) ,

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

                          ///================ mission active list ==========================
                          if(organizerController.missionActiveInactiveStatus.value==false)

                            organizerController.retriveActivieMissionsList.isEmpty?
                            SizedBox(
                              height: MediaQuery.of(context).size.height/2,
                              child: Center(
                                child: CustomText(
                                  text: "No active mission yet!!",
                                  fontSize:isTablet?12.sp: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lightRed,
                                ),
                              ),
                            ):organizerController.retrieveMissionsActiveLoading.value?CustomLoader():
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: organizerController.retriveActivieMissionsList.length,
                                itemBuilder: (BuildContext context,index){
                                  
                                  final modeActiveMissions = organizerController.retriveActivieMissionsList[index];
                                  
                              return InkWell(
                                onTap: (){

                                  Get.toNamed(AppRoutes.organizerActiveMissionDetails,arguments: [
                                    {
                                      "missionId":modeActiveMissions.id,
                                    }
                                  ]);

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
                                                text: "${index+1}.${modeActiveMissions.name}",
                                                fontSize: 16,
                                                color: AppColors.black_80,
                                                fontWeight: FontWeight.w600,
                                              ),

                                                CustomText(
                                                text: "${DateConverter.timeFormetString(modeActiveMissions.createdAt.toString())}",
                                                fontSize: 12,
                                                color: AppColors.black_80,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 12,right: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              CustomText(
                                                text: "${modeActiveMissions.description}",
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

                                                      organizerController.missionEditNameController.value.text="${modeActiveMissions.name}";

                                                      organizerController.missionEditDescriptionController.value.text="${modeActiveMissions.description}";

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

                                                                             if(modeActiveMissions.connectedOrganizations?.isNotEmpty ??true)
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CustomText(
                                                                                    text: "${modeActiveMissions.connectedOrganizations?[0].name}",
                                                                                    fontSize: 16,
                                                                                    color: AppColors.black_80,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    textAlign: TextAlign.start,
                                                                                    left: 8,
                                                                                  ),

                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 8,right: 8),
                                                                                    child: CustomText(
                                                                                      text: "${modeActiveMissions.connectedOrganizations?[0].description}",
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
                                                                              )
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
                                                                            controller: organizerController.missionEditNameController.value),

                                                                        SizedBox(
                                                                          height: 12.h,
                                                                        ),

                                                                        CustomFormCard(
                                                                            title: "Description",
                                                                            hintText: "Description",
                                                                            fontSize: isTablet?16:16,
                                                                            hasBackgroundColor: true,
                                                                            controller: organizerController.missionEditDescriptionController.value),

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
                                                                              value: organizerController.missionActiveStatus.value,
                                                                              onChanged: (bool? value) {
                                                                                organizerController.missionActiveStatus.value = value!;

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
                                                                          child:
                                                                          organizerController.updateActiveMissionLoading.value?CustomLoader():
                                                                          CustomButton(
                                                                            onTap: () {

                                                                              if(organizerController.missionEditNameController.value.text==""){

                                                                                Toast.errorToast("Mission name is empty!!");

                                                                              }else if(organizerController.missionEditDescriptionController.value.text==""){
                                                                                Toast.errorToast("Description is empty!!");

                                                                              }else if(organizerController.missionActiveStatus.value==false){

                                                                                Toast.errorToast("Select mark as status!!");
                                                                              }else{

                                                                                organizerController.editActiveMission(modeActiveMissions.id.toString());

                                                                                if(organizerController.updateActiveMissionLoading.value){
                                                                                  Navigator.of(context).pop();
                                                                                }
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

                                                                  organizerController.missionInactiveDeleteLoading.value?CustomLoader():
                                                                  CustomButton(onTap: (){

                                                                    organizerController.missionDelete(modeActiveMissions.id.toString());

                                                                    if(organizerController.missionInactiveDeleteLoading.value){
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



                          /// mission Inactive list
                          if(organizerController.missionActiveInactiveStatus.value==true)
                            ///organizerController.retrieveMissionsInActive();
                            organizerController.retriveInactivieMissionsList.isEmpty?
                            SizedBox(
                              height: MediaQuery.of(context).size.height/2,
                              child: Center(
                                child: CustomText(
                                  text: "No Inactive mission yet!!",
                                  fontSize:isTablet?12.sp: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.lightRed,
                                ),
                              ),
                            ):organizerController.retriveInvitedMissionsLoading.value?CustomLoader():
                            ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                  itemCount: organizerController.retriveInactivieMissionsList.length,
                                    itemBuilder: (BuildContext context,index){

                                      final modelInActiveMissions = organizerController.retriveInactivieMissionsList[index];

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
                                                    text: "${index+1}.${modelInActiveMissions.name}",
                                                    fontSize: 16,
                                                    color: AppColors.black_80,
                                                    fontWeight: FontWeight.w600,
                                                  ),

                                                    CustomText(
                                                    text: "${DateConverter.timeFormetString(modelInActiveMissions.createdAt.toString())}",
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
                                                    text: "${modelInActiveMissions.description}",
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

                                                          organizerController.missionEditNameController.value.text="${modelInActiveMissions.name}";

                                                          organizerController.missionEditDescriptionController.value.text="${modelInActiveMissions.description}";

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
                                                                                color: AppColors.grey_3.withOpacity(0.5),
                                                                                borderRadius: BorderRadius.circular(15),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [

                                                                                  if(modelInActiveMissions.connectedOrganizations?.isNotEmpty ??true)
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        CustomText(
                                                                                          text: "${modelInActiveMissions.connectedOrganizations?[0].name}",
                                                                                          fontSize: 16,
                                                                                          color: AppColors.black_80,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          textAlign: TextAlign.start,
                                                                                          left: 8,
                                                                                        ),

                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                                                                          child: CustomText(
                                                                                            text: "${modelInActiveMissions.connectedOrganizations?[0].description}",
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
                                                                                    )
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
                                                                                controller: organizerController.missionEditNameController.value),

                                                                            SizedBox(
                                                                              height: 12.h,
                                                                            ),

                                                                            CustomFormCard(
                                                                                title: "Description",
                                                                                hintText: "Description",
                                                                                fontSize: isTablet?16:16,
                                                                                hasBackgroundColor: true,
                                                                                controller: organizerController.missionEditDescriptionController.value),

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
                                                                                  value: organizerController.missionInActiveStatus.value,
                                                                                  onChanged: (bool? value) {
                                                                                    organizerController.missionInActiveStatus.value = value!;
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
                                                                              child:
                                                                              organizerController.updateInActiveMissionLoading.value?CustomLoader():
                                                                              CustomButton(
                                                                                onTap: () {

                                                                                  if(organizerController.missionEditNameController.value.text==""){

                                                                                    Toast.errorToast("Mission name is empty!!");

                                                                                  }else if(organizerController.missionEditDescriptionController.value.text==""){
                                                                                    Toast.errorToast("Description is empty!!");

                                                                                  }else if(organizerController.missionInActiveStatus.value==false){

                                                                                    Toast.errorToast("Select mark as status!!");
                                                                                  }else{

                                                                                    organizerController.editInActiveMission(modelInActiveMissions.id.toString());

                                                                                    if(organizerController.updateInActiveMissionLoading.value){
                                                                                      Navigator.of(context).pop();
                                                                                    }
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
                                }),

                        ],
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
}
