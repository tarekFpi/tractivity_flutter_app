
import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_missionby_mission_model/RetriveSpecificMissionByMissionResponeModel.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/invite_volunteers_model/InviteVolunteerResponeModel.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/invite_volunteers_model/volunteer_slotList_model/volunteers_listmodel.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/invite_volunteers_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/mission_to_volunteer_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';

class OrganizerEventCreateScreen extends StatefulWidget {
  const OrganizerEventCreateScreen({super.key});

  @override
  State<OrganizerEventCreateScreen> createState() => _OrganizerEventCreateScreenState();
}

class _OrganizerEventCreateScreenState extends State<OrganizerEventCreateScreen> {

  RetriveSpecificMissionByMissionResponeModel? missionByMissionResponeModel;

  String missionName="";

  String missionDescription="";

  final  organizerController = Get.find<OrganizerController>();

  final administratorController = Get.put(AdministratiorController());

  final invitedController = Get.put(InviteVolunteersController());

  final queryEditingController = TextEditingController();

  String query = "";

  @override
  void initState() {
    super.initState();

    if(Get.arguments[0]["missionOrganization"]!=null){

      // missionByMissionResponeModel = Get.arguments[0]["missionOrganization"];
    }

    organizerController.pickedFiles.clear();
    organizerController.selectedImages.clear();
    organizerController.getUserCurrentLocation();
    organizerController.volunteersIdList.clear();
  }




  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: const CustomRoyelAppbar(
          titleName: "Create Event",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          child: Obx(
             () {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    CustomText(
                      text: "${administratorController.missionDetailsShowList.value.description}",
                      fontSize:isTablet?6.sp: 12.sp,
                      color: AppColors.black_80,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        GestureDetector(
                          onTap: (){
                          organizerController.pickImagesFromGallery();
                          },
                          child: Container(
                            height:isTablet?90.h: 100.h,
                            width:isTablet? 110.w:140.w,
                            decoration: BoxDecoration(
                              color: AppColors.grey_5.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              children: [

                                CustomImage(imageSrc: AppIcons.uploadIcon,width: 45,height: 45,),

                                SizedBox(
                                  height: 4,
                                ),
                                CustomText(
                                  text: "Upload Image",
                                  fontSize: 12,
                                  color: AppColors.black_80,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: (){
                            organizerController.pickFiles();
                          },
                          child: Container(
                            height:isTablet?90.h: 100.h,
                            width:isTablet? 110.w:140.w,
                            decoration: BoxDecoration(
                              color: AppColors.grey_5.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              children: [

                                CustomImage(imageSrc: AppIcons.dowanload,width: 45,height: 45,),

                                SizedBox(
                                  height: 4.h,
                                ),
                                const CustomText(
                                  text: "Upload PDF",
                                  fontSize: 12,
                                  color: AppColors.black_80,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                   /* SizedBox(
                      height: 4.h,
                    ),
                    organizerController.pickedFiles.value.isNotEmpty? Align(
                      alignment: Alignment.centerLeft,
                      child: Flexible(
                        child: CustomText(
                          text: "${organizerController.pickedFiles.toJson()}",
                          fontSize:isTablet? 6.sp:12.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start,
                          maxLines: organizerController.pickedFiles.length,
                        ),
                      ),
                    ):SizedBox(),*/


                      SizedBox(
                      height: 12.h,
                    ),
                    ///============ Event Name ============
                    CustomFormCard(
                        fontSize: isTablet?16:16,
                        title: "Event Name",
                        hintText: "Event Name",
                        hasBackgroundColor: true,
                        controller: organizerController.eventNameController.value),

                    ///============ Event Description ============
                    CustomFormCard(
                        fontSize: isTablet?16:16,
                        title: "Description",
                        hintText: "Description",
                        hasBackgroundColor: true,
                        controller: organizerController.eventDescriptionController.value),

                    ///============ Event City ============
                    CustomFormCard(
                        fontSize: isTablet?16:16,
                        title: "City",
                        hintText: "City",
                        hasBackgroundColor: true,
                        controller:  organizerController.cityController.value),

                    ///============ Event State ============
                    CustomFormCard(
                        fontSize: isTablet?16:16,
                        title: "State",
                        hintText: "State",
                        hasBackgroundColor: true,
                        controller:organizerController.stateController.value),

                    ///============ Event Zip ============
                    CustomFormCard(
                        fontSize: isTablet?16:16,
                        title: "Zip",
                        hintText: "Zip",
                        hasBackgroundColor: true,
                        controller: organizerController.zipController.value),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        ///mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [


                          GestureDetector(
                            onTap: (){
                              organizerController.selectOpenTime();
                            },
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    const Icon(
                                      Icons.lock_clock,
                                      size: 24,
                                    ),

                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    CustomText(
                                      text: "${organizerController.timeOpenPicker.value}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),

                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                            SizedBox(
                            width: 4.w,
                          ),

                          GestureDetector(
                            onTap: (){
                             organizerController.selectCloseTime();
                            },
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    const Icon(
                                      Icons.lock_clock,
                                      size: 24,
                                    ),

                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    CustomText(
                                      text: "${organizerController.timeClosePicker.value}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),

                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),


                          const SizedBox(
                            width: 8,
                          ),

                          GestureDetector(
                            onTap: (){
                             organizerController.selectDate();
                            },
                            child: Row(
                              children: [

                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                CustomText(
                                  text: "${organizerController.selectedDate.value}",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height:isTablet?16.h: 12.h,
                    ),

                    Row(
                      children: [

                        CustomButton(onTap: (){
                          organizerController.toggleButton(1);
                          organizerController.eventAccessmode.value="private";

                        }, title: "private",height: 30.h,width:isTablet?60.w:70.w,
                          fontSize:isTablet?6.sp:14.sp,
                          textColor: AppColors.black,
                          fillColor:organizerController.isButton1Selected.value
                              ? organizerController.selectedColor.value
                              : organizerController.unselectedColor.value,
                          isBorder: true,
                          borderWidth: .5,
                        ),
                     ///AppColors.white
                        const SizedBox(
                          width: 12,
                        ),

                     CustomButton(onTap: (){

                     organizerController.toggleButton(2);
                     organizerController.eventAccessmode.value="public";

                     }, title: "public",height: 30.h,width:isTablet?60.w:70.w,
                     fontSize:isTablet?6.sp:14.sp,
                     textColor: AppColors.black,
                     fillColor:organizerController.isButton2Selected.value
                     ? organizerController.selectedColor.value
                         : organizerController.unselectedColor.value,
                     isBorder: true,
                     borderWidth: .5,
                     )

                      ],
                    ),

                    SizedBox(
                      height:isTablet?16.h: 12.h,
                    ),

                    CustomButton(onTap: (){

                    ///Get.toNamed(AppRoutes.addMemberScreen);

                      invitedController.inviteVolunteers(administratorController.missionDetailsShowList.value.id.toString());

                      ///adding some properties
                      showModalBottomSheet(
                        context: context,
                        ///background color for modal bottom screen
                        backgroundColor: Colors.white,
                        ///elevates modal bottom screen
                        elevation: 10,
                        /// gives rounded corner to modal bottom screen
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        builder: (BuildContext context) {
                          ///UDE : SizedBox instead of Container for whitespaces
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height/1,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                 Column(
                                   children: [

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [

                                         const Text(
                                           'Invite Volunteers',
                                           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                         ),

                                         InkWell(
                                             onTap: (){

                                               Navigator.pop(context);

                                               organizerController.volunteersSelectedList.clear();

                                               organizerController.selectedVolunteers.value=false;
                                             },
                                             child: Icon(Icons.clear,size: 32,))
                                       ],
                                     ),
                                     SizedBox(
                                       height: 12.h,
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
                                         invitedController.searchVolunteersList(query);
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

                                             invitedController.searchVolunteersList("");

                                           }),

                                     ),


                                     SizedBox(
                                       height: 12.h,
                                     ),

                                     invitedController.obx((state){

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
                                             itemCount:state.length,
                                             shrinkWrap: true,
                                             physics: NeverScrollableScrollPhysics(),
                                             itemBuilder: (BuildContext context, int index) {

                                               final model = state[index];

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

                                                             model.image==""? CustomNetworkImage(
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
                                                                   text: "${model.fullName}",
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
                                                         value: organizerController.volunteersIdList.contains(model.id),
                                                         onChanged: (bool? value) {

                                                           organizerController.selectedVolunteers.value = value!;


                                                           if(organizerController.selectedVolunteers.value){

                                                             organizerController.volunteersIdList.add(model.id.toString());

                                                             InviteVolunteerResponeModel addItem = InviteVolunteerResponeModel(
                                                               id: model.id.toString(),
                                                               fullName: model.fullName.toString(),
                                                               image: model.image.toString(),
                                                               profession:model.profession
                                                             );
                                                             
                                                              if(!organizerController.volunteersSelectedList.contains(model.id.toString())){
                                                                
                                                                organizerController.volunteersSelectedList.add(addItem);
                                                                
                                                              }
                                                            
                                                           }else{
                                                             organizerController.volunteersIdList.remove(model.id.toString());
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

                                  Align(
                                     alignment: Alignment.bottomCenter,
                                    child: CustomButton(onTap: (){

                                      if(organizerController.volunteersSelectedList.isEmpty){

                                        Toast.errorToast("Please Select Volunteer..!!");

                                      }else{

                                        Navigator.pop(context);
                                        organizerController.setSelectedVolunteersToggle();

                                      }

                                    }, title: "Done",fontSize: 12,),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                    }, title: "Add Volunteers",height: 30.h,width: 120.w,fontSize: 12,
                      textColor: AppColors.black,
                    ),

                    SizedBox(
                      height:isTablet?16.h: 12.h,
                    ),

                    CustomButton(onTap: (){

                     // Get.toNamed(AppRoutes.memberScreen);

                      // adding some properties
                      showModalBottomSheet(
                        context: context,

                        //background color for modal bottom screen
                        backgroundColor: Colors.white,
                        //elevates modal bottom screen
                        elevation: 10,
                        // gives rounded corner to modal bottom screen
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        builder: (BuildContext context) {
                          // UDE : SizedBox instead of Container for whitespaces
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height/1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          const Text(
                                            'Sell all Volunteers',
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                          ),

                                          InkWell(
                                              onTap: (){

                                                Navigator.pop(context);
                                                organizerController.volunteersRoleList.clear();
                                              },
                                              child: Icon(Icons.clear,size: 32,))
                                        ],
                                      ),

                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      organizerController.volunteersSelectedList.isEmpty?
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height/2,
                                        child: Center(
                                          child: CustomText(
                                            text: "No volunteers yet!!",
                                            fontSize:isTablet?12.sp: 24.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.lightRed,
                                          ),
                                        ),
                                      ):
                                      Column(
                                          children: List.generate(organizerController.volunteersSelectedList.length, (index) {

                                            final model = organizerController.volunteersSelectedList[index];

                                            return Card(
                                              color: AppColors.white,
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 16.h,left: 6,right: 6,top: 8),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        model.image==""? CustomNetworkImage(
                                                          imageUrl: AppConstants.profileImage,
                                                          height:isTablet?64.h: 60.h,
                                                          width:isTablet?64.w: 60.w,
                                                          boxShape: BoxShape.circle,
                                                        ):CustomNetworkImage(
                                                          imageUrl: "${ApiUrl.imageUrl}${model.image}",
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
                                                              text: "${model.fullName}",
                                                              fontSize:isTablet?8.sp: 18,
                                                              fontWeight: FontWeight.w600,
                                                              color: AppColors.black,
                                                            ),
                                                            CustomText(
                                                              text: "${model.profession}",
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                              color: AppColors.black_80,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: 12.h,
                                                    ),
                                                    Obx(
                                                       () {
                                                        return Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [

                                                            if((organizerController.volunteersRoleList
                                                                .any((volunteer) => volunteer.volunteer == model.id.toString()))!=true)
                                                            CustomButton(onTap: (){
                                                              showDialog(
                                                                context: context,
                                                                builder: (ctx) => AlertDialog(
                                                                  backgroundColor: Colors.white,
                                                                  insetPadding: EdgeInsets.all(16),
                                                                  contentPadding: EdgeInsets.all(16),
                                                                  ///clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                  title: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [

                                                                      const CustomText(
                                                                        text: "Add Role",
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
                                                                            //  organizerController.volunteersRoleList.clear();
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
                                                                    height:MediaQuery.sizeOf(context).height/3.3,
                                                                    child:Column(
                                                                      children: [

                                                                        ///============ Add role ============
                                                                        CustomFormCard(
                                                                            title: "Add role",
                                                                            hintText:"Add role",
                                                                            fontSize: isTablet ? 16 : 14,
                                                                            hasBackgroundColor: true,
                                                                            controller: organizerController.volunteersRoleController.value),



                                                                        Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: CustomButton(onTap: (){

                                                                            VolunteersListModel addRole = VolunteersListModel(
                                                                                 volunteer: model.id.toString(),
                                                                                 workTitle: organizerController.volunteersRoleController.value.text
                                                                            );

                                                                            bool isMatch = organizerController.volunteersRoleList
                                                                                .any((volunteer) => volunteer.volunteer == model.id.toString());

                                                                             if(!isMatch){
                                                                             organizerController.volunteersRoleList.add(addRole);
                                                                               debugPrint("volunteersRoleList1:${jsonEncode(organizerController.volunteersRoleList)}");

                                                                               Navigator.of(context).pop();
                                                                               organizerController.volunteersRoleController.value.clear();

                                                                             }else{
                                                                               Navigator.of(context).pop();

                                                                             }

                                                                          }, title: "Done",fontSize:isTablet?6.sp: 12.sp,),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }, title: "add role",fontSize: 12, height: isTablet?40.h:30.h,width: isTablet?80.w
                                                                :70.w,),


                                                            SizedBox(
                                                              width: 12.w,
                                                            ),

                                                            if(organizerController.volunteersRoleList
                                                                .any((volunteer) => volunteer.volunteer == model.id.toString()))
                                                            CustomButton(onTap: (){

                                                                  organizerController.volunteersRoleList.forEach((item){

                                                                    if(item.volunteer.contains(model.id.toString())){
                                                                      organizerController.volunteersEditRoleController.value.text =item.workTitle.toString();
                                                                    }
                                                                  });


                                                              showDialog(
                                                                context: context,
                                                                builder: (ctx) => AlertDialog(
                                                                  backgroundColor: Colors.white,
                                                                  insetPadding: EdgeInsets.all(16),
                                                                  contentPadding: EdgeInsets.all(16),
                                                                  ///clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                  title:Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [

                                                                      const CustomText(
                                                                        text: "Edit Role",
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
                                                                             //
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
                                                                    height:MediaQuery.sizeOf(context).height/4,
                                                                    child:Column(
                                                                      children: [

                                                                        ///============ edit role ============
                                                                        CustomFormCard(
                                                                            title: "Edit role",
                                                                            hintText:"edit role",
                                                                            fontSize: isTablet ? 16 : 14,
                                                                            hasBackgroundColor: true,
                                                                            controller: organizerController.volunteersEditRoleController.value),

                                                                        CustomButton(onTap: (){


                                                                          organizerController.volunteersRoleList.remove(model.id.toString());

                                                                          VolunteersListModel editRole = VolunteersListModel(
                                                                              volunteer: model.id.toString(),
                                                                              workTitle: organizerController.volunteersEditRoleController.value.text
                                                                          );


                                                                          organizerController.volunteersRoleList.add(editRole);

                                                                          debugPrint("volunteersEditRole:${jsonEncode(organizerController.volunteersRoleList)}");

                                                                          organizerController.volunteersEditRoleController.value.clear();
                                                                          Navigator.of(context).pop();

                                                                          /*if(isMatch){
                                                                          // var index= organizerController.volunteersRoleList.indexOf(model.id.toString());
                                                                          }*/

                                                                        }, title: "Edit",fontSize: isTablet?6.sp: 12.sp,),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }, title: "Edit",fontSize: 12, height: isTablet?40.h:30.h,width: isTablet?80.w
                                                                :70.w,),
                                                          ],
                                                        );
                                                      }
                                                    )

                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                      ),
                                    ],
                                  ),

                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CustomButton(onTap: (){

                                      Navigator.pop(context);

                                    }, title: "Done",fontSize: 12,),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }, title: "Add Role to Volunteers",height: 30.h,width:isTablet?170.w: 160.w,fontSize:isTablet? 6.sp:12.sp,
                      textColor: AppColors.black,
                    ),


                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:organizerController.createEventLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                      CustomButton(onTap: (){

                        if(organizerController.eventNameController.value.text==""){
                          Toast.errorToast("Event name is empty!!");
                        }else if(organizerController.eventDescriptionController.value.text==""){
                          Toast.errorToast("description is empty!!");

                        }else if(organizerController.cityController.value.text==""){
                          Toast.errorToast("City is empty!!");
                        } else if (organizerController.stateController.value.text.isEmpty) {

                          Toast.errorToast("State is empty!!");

                        } else if (organizerController.zipController.value.text.isEmpty) {

                          Toast.errorToast("Zip code is empty!!");

                        }else if (organizerController.timeOpenPicker.value=="start Time") {

                          Toast.errorToast("Start time  is empty!!");

                        }else if (organizerController.timeClosePicker.value=="end Time") {

                          Toast.errorToast("End time  is empty!!");

                        } else if (organizerController.selectedDate.value=="00/00/0000") {

                          Toast.errorToast("Date is empty!!");
                        } else if (organizerController.eventAccessmode.value.isEmpty) {

                          Toast.errorToast("Event Access mode is empty!!");

                        }else if (organizerController.volunteersRoleList.isEmpty) {
                          Toast.errorToast("volunteer role is empty!!");
                        }else{

                          organizerController.createEvent(administratorController.missionDetailsShowList.value.id.toString());
                        }


                      }, title: "Submit",fontSize: 12, height: isTablet?70:60,),
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
