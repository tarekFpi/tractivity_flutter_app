
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/adminstrator_navbar.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';


class AdministratiorCreateScreen extends StatefulWidget {
  const AdministratiorCreateScreen({super.key});

  @override
  State<AdministratiorCreateScreen> createState() => _AdministratiorCreateScreenState();
}

class _AdministratiorCreateScreenState extends State<AdministratiorCreateScreen> {

  final OrganizerController organizerController = Get.find<OrganizerController>();

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     // if(organizerController.adminstratior_currentIndex.value==1)
        title:
        Text(
          organizerController.adminstratior_currentIndex.value==0? "Create Organization":"Create Mission",
          style: TextStyle(
              color: AppColors.black,
              fontSize: 30,
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

                  Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: AppConstants.profileImage,
                        height: 100,
                        width: 100,
                        boxShape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Mehedi Bin Ab. Salam",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              CustomText(
                                text: "Bushwick Brooklyn, NY, USA",
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),

                  ///=============== Recemt Events Tab Bar ===============

                  const SizedBox(height: 20,),

                  CustomTabSingleText(
                      tabs: organizerController.adminstratiorNameList,
                      selectedIndex: organizerController.adminstratior_currentIndex.value,
                      onTabSelected: (value) {
                        organizerController.adminstratior_currentIndex.value = value;
                        setState(() {});
                      },
                      selectedColor: AppColors.primary,
                      unselectedColor: AppColors.grey_1
                  ),

                  const SizedBox(height: 20,),

                  ///============ Recent  Event ==============================
                  if(organizerController.adminstratior_currentIndex.value==0)
                    Column(
                        children: List.generate(2, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: AppColors.grey_5.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8,right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                                                     /*     CustomText(
                                          text: "${index+1} .",
                                          fontSize: 16,
                                          color: AppColors.black_80,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    */
                                          CustomText(
                                          text: "${index+1}.Global Horizons Foundation",
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

                                  const SizedBox(
                                    height: 4,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8,right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        const Flexible(
                                          child: SizedBox(
                                            width: 250,
                                            child: CustomText(
                                              text: "Empowering communities  worldwide \n through education, healthcare,\n and sustainable development initiatives.",
                                              fontSize: 12,
                                              color: AppColors.black_80,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),

                                        CustomButton(
                                          onTap: () {
                                          },
                                          title: "Delete",
                                          width: 60.w,
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
                          );
                        })),

                  if(organizerController.adminstratior_currentIndex.value==1)
                    Column(
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: AppColors.grey_5.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8,right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                          CustomText(
                                          text: "${index+1}.Global Horizons Foundation",
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
                                    padding: const EdgeInsets.only(left: 8,right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        const SizedBox(
                                          width: 250,
                                          child: CustomText(
                                            text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                                            fontSize: 12,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w400,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.clip, // Add ellipsis at the end if the text overflows.
                                            // maxLines: 3,
                                          ),
                                        ),


                                       Column(
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
                                                     child: AlertDialogEvent(title: "Are you sure you want to \n delete ?",discription: "",),
                                                   ),
                                                 ),
                                               );
                                             },
                                             title: "Delete",
                                             width: 60.w,
                                             height: 32.h,
                                             textColor: AppColors.black,
                                             fillColor: AppColors.primary,
                                             fontSize: 12,
                                           ),

                                           const SizedBox(
                                             height: 8,
                                           ),

                                           CustomButton(
                                             onTap: () {

                                               Get.toNamed(AppRoutes.adminstratiorEventListScreen);
                                             },
                                             title: "Report",
                                             width: 60.w,
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
                          );
                        })),

                ],
              ),
            );
          }
        ),
      ),
      bottomNavigationBar:   Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          if(organizerController.adminstratior_currentIndex.value==0)
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
                    content: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 300,
                      child: Column(
                        children: [

                          CustomFormCard(
                              title: "Organization Name",
                              hintText: "Organization Name",
                              hasBackgroundColor: true,
                              controller: TextEditingController(),
                          ),

                          CustomFormCard(
                              title: "Description",
                              hintText: "Description",
                              hasBackgroundColor: true,
                              controller: TextEditingController()),

                          Padding(
                            padding: const EdgeInsets.only(left: 12,right: 12),
                            child: CustomButton(
                              onTap: () {
                              },
                              title: "Done",
                              height: 45.h,
                              textColor: AppColors.black,
                              fillColor: AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ],
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

          if(organizerController.adminstratior_currentIndex.value==1)
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

                          CustomText(
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
                        height: MediaQuery.sizeOf(context).height/1.7,
                        child: Column(
                          children: [


                            const Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                text: "Add Organization",
                                fontSize: 14,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                bottom: 8,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){

    ///========================== add oranizaion ========================

                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    insetPadding: EdgeInsets.all(4),
                                    contentPadding: EdgeInsets.all(4),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        const CustomText(
                                          text: "Add Organization",
                                          fontSize: 24,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                        ),

                                        Align(
                                          alignment: Alignment.topRight,
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
                                      ],
                                    ),
                                    content:  SizedBox(
                                      height: MediaQuery.sizeOf(context).height/3,
                                      child: Column(
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: AppColors.grey_5.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              padding: EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [

                                                      CustomText(
                                                        text: "1 .",
                                                        fontSize: 16,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w600,
                                                      ),

                                                      const CustomText(
                                                        text: "Global Horizons Foundation",
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

                                                  const SizedBox(
                                                    height: 4,
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12,right: 8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        const Flexible(
                                                          child: SizedBox(
                                                            width: 250,
                                                            child: CustomText(
                                                              text: "Empowering communities  worldwide \n through education, healthcare",
                                                              fontSize: 12,
                                                              color: AppColors.black_80,
                                                              fontWeight: FontWeight.w400,
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                        ),

                                                        CustomButton(
                                                          onTap: () {

                                                          },
                                                          title: "Select",
                                                          width: 60.w,
                                                          height: 32.h,
                                                          textColor: AppColors.black,
                                                          fillColor: AppColors.primary,
                                                          fontSize: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),


                                                  const SizedBox(
                                                    height: 4,
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: AppColors.grey_5.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              padding: EdgeInsets.all(12),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [

                                                      CustomText(
                                                        text: "2 .",
                                                        fontSize: 16,
                                                        color: AppColors.black_80,
                                                        fontWeight: FontWeight.w600,
                                                      ),

                                                      const CustomText(
                                                        text: "Global Horizons Foundation",
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

                                                  const SizedBox(
                                                    height: 4,
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12,right: 8),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        const Flexible(
                                                          child: SizedBox(
                                                            width: 250,
                                                            child: CustomText(
                                                              text: "Empowering communities  worldwide \n through education, healthcare",
                                                              fontSize: 12,
                                                              color: AppColors.black_80,
                                                              fontWeight: FontWeight.w400,
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                        ),

                                                        CustomButton(
                                                          onTap: () {

                                                          },
                                                          title: "Select",
                                                          width: 60.w,
                                                          height: 32.h,
                                                          textColor: AppColors.black,
                                                          fillColor: AppColors.primary,
                                                          fontSize: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ),


                                                  const SizedBox(
                                                    height: 4,
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomButton(
                                              onTap: () {
                                              },
                                              title: "Done",
                                              height: 45.h,
                                              textColor: AppColors.black,
                                              fillColor: AppColors.primary,
                                              fontSize: 12,
                                            ),
                                          ),
                                          ],
                                          ),
                                    ),
                                  ),
                                );

                              },
                              child: Container(
                                child: const Row(
                                  children: [

                                  Icon(Icons.arrow_drop_down_sharp,size: 24,),

                                  CustomText(
                                    text: "Add Organization",
                                    fontSize: 14,
                                    color: AppColors.grey_1,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(color: Colors.black, spreadRadius: 1),
                                  ],
                                ),
                                height: 50,
                              ),
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            const Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                text: "Add Leader",
                                fontSize: 14,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                bottom: 8,
                              ),
                            ),

                            GestureDetector(
                              onTap: (){

                        ///========================== add Leader ========================

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
                                          text: "Add Leader",
                                          fontSize: 24,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                        ),

                                        Align(
                                          alignment: Alignment.center,
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
                                      ],
                                    ),
                                    content:  SizedBox(
                                      height: MediaQuery.sizeOf(context).height/3,

                                      width: MediaQuery.sizeOf(context).height,
                                      child: Column(
                                        children: [

                                          const SizedBox(
                                            height: 12,
                                          ),
                                          const CustomTextField(
                                              hintText: AppStrings.searchForSomeone,
                                              suffixIcon: Icon(
                                                Icons.search,
                                                color: AppColors.black_60,
                                              )),

                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Column(
                                              children: List.generate(2, (index) {
                                                return CustomFriendsList(
                                                  image: AppConstants.profileImage,
                                                  name: "Mehedi Hassan",
                                                  userName: "@mehedi",
                                                  reversText: "Select",
                                                );
                                              })
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomButton(
                                              onTap: () {
                                              },
                                              title: "Done",
                                              height: 45.h,
                                              textColor: AppColors.black,
                                              fillColor: AppColors.primary,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                              },
                              child: Container(
                                child:   const Row(
                                  children: [

                                    Icon(Icons.arrow_drop_down_sharp,size: 24,),

                                    CustomText(
                                      text: "Add Leader",
                                      fontSize: 14,
                                      color: AppColors.grey_1,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(color: Colors.black, spreadRadius: 1),
                                  ],
                                ),
                                height: 50,
                              ),
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            CustomFormCard(
                                title: "Name",
                                hintText: "Name",
                                hasBackgroundColor: true,
                                controller: TextEditingController()),

                            const SizedBox(
                              height: 12,
                            ),

                            CustomFormCard(
                                title: "Description",
                                hintText: "Description",
                                hasBackgroundColor: true,
                                controller: TextEditingController()),



                            Padding(
                              padding: const EdgeInsets.only(left: 12,right: 12),
                              child: CustomButton(
                                onTap: () {
                                },
                                title: "Done",
                                height: 45.h,
                                textColor: AppColors.black,
                                fillColor: AppColors.primary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
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

          AdminstratorNavbar(currentIndex: 1,)
        ],
      ),
    );
  }
}
