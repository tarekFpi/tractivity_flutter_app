
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Sell all member"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Column(
              children: [


                Column(
                    children: List.generate(3, (index) {

                      return Card(
                        color: AppColors.white,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.h,left: 6,right: 6,top: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child: Row(
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: AppConstants.profileImage,
                                      height: 60,
                                      width: 60,
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
                                          text: "Mehedi Hassan",
                                          fontSize:isTablet?8.sp: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                        ),
                                        CustomText(
                                          text: "Student",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black_80,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

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
                                                  controller: TextEditingController()),

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CustomButton(onTap: (){

                                                  Navigator.of(context).pop();

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
                                  CustomButton(onTap: (){

                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        insetPadding: EdgeInsets.all(8),
                                        contentPadding: EdgeInsets.all(8),
                                        title: SizedBox(),
                                        content: SizedBox(
                                          width: MediaQuery.sizeOf(context).width,
                                          child: AlertDialogEvent(title: "Are you sure you want to \n remove member ?",discription: "",),
                                        ),
                                      ),
                                    );
                                  }, title: "remove",fontSize: 12, height: isTablet?40.h:30.h,width: isTablet?80.w
                                      :70.w,),

                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  CustomButton(onTap: (){

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
                                                  controller: TextEditingController()),

                                              CustomButton(onTap: (){
                                                Navigator.of(context).pop();
                                              }, title: "Edit",fontSize: isTablet?6.sp: 12.sp,),

                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }, title: "Edit",fontSize: 12, height: isTablet?40.h:30.h,width: isTablet?80.w
                                      :70.w,),
                                ],
                              )

                            ],
                          ),
                        ),
                      );
                    })
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.organizerEventCreateScreen);
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
      );
    });
  }
}
