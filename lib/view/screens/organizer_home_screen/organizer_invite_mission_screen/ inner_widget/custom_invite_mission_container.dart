// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
class CustomInviteMissionContainer extends StatelessWidget {
  const CustomInviteMissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.neutral02,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Empower Tomorrow",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        bottom: 8.h,
                      ),
                      CustomText(
                        text:
                        "Fostering opportunities for underprivileged communities through education and skill development programs.",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        bottom: 10.h,
                      ),
                      Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 40,
                            width: 40,
                            boxShape: BoxShape.circle,
                          ),
                          CustomText(
                            text: "Mehedi",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            left: 8.h,
                            right: 8.h,
                          ),
                          CustomText(
                            text: "(Adminstrator)",
                            fontSize: 14,
                            color: AppColors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    CustomText(
                      text: "17-12-2024",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                    ),
                    CustomButton(onTap: (){
                      ///OrganizerApprovedScreen

                      Get.toNamed(AppRoutes.organizerApprovedScreen);

                    }, title: "Accept",height:isTablet?30.h: 30.h,
                      width:isTablet?70.sp: 60.sp,fontSize:isTablet?6.sp:14.sp,),

                    SizedBox(height: 10.h,),

                    CustomButton(onTap: (){
                      /*       showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: Colors.white,
                      insetPadding: EdgeInsets.all(8),
                      contentPadding: EdgeInsets.all(8),
                      title: SizedBox(),
                      content: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: AlertDialogEvent(title: "Are you sure you want to \n Reject ?",discription: "",),
                      ),
                    ),
                  );*/

                    }, title: "Reject",height:isTablet?30.h: 30.h,
                      width:isTablet?70.sp: 60.sp,fontSize:isTablet? 6.sp:14.sp,),
                  ],
                )


              ],
            ),
          ),
        );
    });
  }
}
