// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class CustomExploreContainer extends StatelessWidget {
  final String? image;
  final String? title;
  final String? location;
  final String? leaderName;
  final bool? showDeliveryButtton;
  final String? btnOne;
  final String? btnTwo;

  CustomExploreContainer({
    super.key,
    this.image,
    this.title,
    this.location,
    this.leaderName,
    this.showDeliveryButtton = false, this.btnOne, this.btnTwo,
  });

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [

          CustomNetworkImage(
            imageUrl: image!,
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
                  text: title!,
                  maxLines: 3,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  bottom: 5,
                ),
              ),
              /// Location
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.black,
                    size: 20,
                  ),
                  CustomText(
                    text: location!,
                    fontSize: 12,
                    color: AppColors.black_80,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              // Leader
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.profileImage,
                    height: 30,
                    width: 30,
                    boxShape: BoxShape.circle,
                  ),
                  CustomText(
                    text: leaderName!,
                    fontSize: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    right: 10.w,
                    left: 10.w,
                  ),
                  CustomText(
                    text: "Leader",
                    fontSize: 14,
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.exploreEventScreen);
                      storage.write("status","home_page");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomText(
                        text: btnOne?? "Explore",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  if (showDeliveryButtton!)
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.exploreEventScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomText(
                          text:btnTwo ?? AppStrings.delivery,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    )
                  else
                    SizedBox(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
