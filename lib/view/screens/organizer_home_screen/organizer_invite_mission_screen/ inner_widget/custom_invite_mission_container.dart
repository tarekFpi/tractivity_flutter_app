// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
class CustomInviteMissionContainer extends StatelessWidget {
  const CustomInviteMissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
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
                CustomButton(onTap: (){}, title: "Approved",height: 30,width: 70,fontSize: 12,),
                SizedBox(height: 10.h,),
                CustomButton(onTap: (){}, title: "Delete",height: 30,width: 70,fontSize: 12,),
              ],
            )


          ],
        ),
      ),
    );
  }
}
