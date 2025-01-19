
import 'package:dropdown_button2/dropdown_button2.dart';
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

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: AppBar(
          title:
          Text(
            organizerController.adminstratior_currentIndex.value==0? "Create Organization":"Create Mission",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 22.sp,
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
                            height: 100.h,
                            width: 100.w,
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
                                fontSize: 18,
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
                          fontSize: isTablet?24:16,
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
                                  height:isTablet?140.h: 130.h,
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

                                              Flexible(
                                              child: SizedBox(
                                                width:isTablet?300.w: 250.w,
                                                child: CustomText(
                                                  text: "Empowering communities  worldwide  through education, healthcare,\n and sustainable development initiatives.",
                                                  fontSize: 12,
                                                  color: AppColors.black_80,
                                                  fontWeight: FontWeight.w400,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
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
                                  height:isTablet?140.h: 130.h,
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

                                             SizedBox(
                                               width:isTablet?300.w: 250.w,
                                              child: const CustomText(
                                                text: "Empowering communities  worldwide  through education, healthcare,  and sustainable development initiatives.",
                                                fontSize: 12,
                                                color: AppColors.black_80,
                                                fontWeight: FontWeight.w400,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,// Add ellipsis at the end if the text overflows.
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

                                                 SizedBox(
                                                  height:isTablet?12.h: 8.h,
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
                          height: 300.h,
                          child: Column(
                            children: [

                              CustomFormCard(
                                title: "Organization Name",
                                hintText: "Organization Name",
                                hasBackgroundColor: true,
                                fontSize: isTablet?16:16,
                                controller: TextEditingController(),
                              ),

                              CustomFormCard(
                                  title: "Description",
                                  hintText: "Description",
                                  hasBackgroundColor: true,
                                  fontSize: isTablet?16:16,
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
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                          //  height: MediaQuery.sizeOf(context).height/1.4,
                          
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
                                      ///======== Search Bar ==============
                                      const CustomTextField(
                                        hintText: "Search",
                                        fillColor: AppColors.neutral02,
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: AppColors.black_60,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Column(
                                        children:  List.generate(
                                            2,
                                                (index) => Column(
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Container(
                                                    height:isTablet?130.h: 100.h,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.grey_5.withOpacity(0.5),
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
                                                                 fontSize: 16,
                                                                 color: AppColors.black_80,
                                                                 fontWeight: FontWeight.w600,
                                                               ),

                                                               CustomText(
                                                                 text: "Global Horizons Foundation",
                                                                 fontSize:isTablet?6.sp: 14.sp,
                                                                 color: AppColors.black_80,
                                                                 fontWeight: FontWeight.w600,
                                                                 overflow: TextOverflow.clip,
                                                               ),
                                                             ],
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
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [

                                                                Flexible(
                                                                child: SizedBox(
                                                                  width:isTablet?300.w: 250.w,
                                                                  child: CustomText(
                                                                    text: "Empowering communities  worldwide \n through education, healthcare",
                                                                    fontSize: 12,
                                                                    color: AppColors.black_80,
                                                                    fontWeight: FontWeight.w400,
                                                                    textAlign: TextAlign.start,
                                                                    overflow: TextOverflow.clip,
                                                                    maxLines: 2,
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

                                              ],
                                            )

                                        ),
                                      )
                                    ],
                                )
                                ),
                          
                          
                          
                                 const SizedBox(
                                  height: 12,
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
                                        const CustomTextField(
                                          hintText: "Search",
                                          fillColor: AppColors.neutral02,
                                          suffixIcon: Icon(
                                            Icons.search,
                                            color: AppColors.black_60,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Column(
                                          children:  List.generate(
                                              2,
                                                  (index) => Column(
                                                children: [

                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Container(
                                                      height:isTablet?130.h: 100.h,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.grey_5.withOpacity(0.5),
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
                                                                    fontSize: 16,
                                                                    color: AppColors.black_80,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),

                                                                  CustomText(
                                                                    text: "Global Horizons Foundation",
                                                                    fontSize:isTablet?6.sp: 14.sp,
                                                                    color: AppColors.black_80,
                                                                    fontWeight: FontWeight.w600,
                                                                    overflow: TextOverflow.clip,
                                                                  ),
                                                                ],
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
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [

                                                                Flexible(
                                                                  child: SizedBox(
                                                                    width:isTablet?300.w: 250.w,
                                                                    child: CustomText(
                                                                      text: "Empowering communities  worldwide \n through education, healthcare",
                                                                      fontSize: 12,
                                                                      color: AppColors.black_80,
                                                                      fontWeight: FontWeight.w400,
                                                                      textAlign: TextAlign.start,
                                                                      overflow: TextOverflow.clip,
                                                                      maxLines: 2,
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

                                                ],
                                              )

                                          ),
                                        )
                                      ],
                                    )
                                ),

                                const SizedBox(
                                  height: 12,
                                ),
                                CustomFormCard(
                                    title: "Name",
                                    hintText: "Name",
                                    fontSize: isTablet?16:16,
                                    hasBackgroundColor: true,
                                    controller: TextEditingController()),
                          
                                const SizedBox(
                                  height: 12,
                                ),
                          
                                CustomFormCard(
                                    title: "Description",
                                    hintText: "Description",
                                    fontSize: isTablet?16:16,
                                    hasBackgroundColor: true,
                                    controller: TextEditingController()),
                          
                          
                          
                                Padding(
                                  padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                                  child: CustomButton(
                                    onTap: () {
                                    },
                                    title: "Done",
                                    height: 60.h,
                                    textColor: AppColors.black,
                                    fillColor: AppColors.primary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
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
    });
  }
}
