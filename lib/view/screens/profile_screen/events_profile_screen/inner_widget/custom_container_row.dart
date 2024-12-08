// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_selected.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';
class CustomContainerRow extends StatelessWidget {
  CustomContainerRow({super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          CustomNetworkImage(
            imageUrl: AppConstants.profileImage,
            height: 170.h,
            width: 170.h,
            borderRadius: BorderRadius.circular(10),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150.w,
                child: CustomText(
                  textAlign: TextAlign.start,
                  text: "Cox’s Bazar Beach Helping Peolple",
                  maxLines: 3,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  bottom: 5,
                ),
              ),

              ///================= Location
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.black,
                    size: 20,
                  ),
                  CustomText(
                    text: "Dhaka, Bangladesh",
                    fontSize: 12,
                    color: AppColors.black_80,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),

              ///================= Time
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: AppColors.black,
                    size: 20,
                  ),
                  CustomText(
                    text: "12/12/2024",
                    fontSize: 12,
                    color: AppColors.black_80,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(
                      3,
                          (index) {
                        return Align(
                          widthFactor: .8,
                          child: CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 30,
                            width: 30,
                            boxShape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: "+30 people",
                    fontSize: 12,
                    color: AppColors.black_80,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

            ],
          )
        ],
      ),
    );
  }
}
