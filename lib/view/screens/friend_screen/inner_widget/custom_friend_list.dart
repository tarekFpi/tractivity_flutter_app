// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
class CustomFriendsList extends StatelessWidget {
  final String image;
  final String? name;
  final String? userName;
  final String? reversText;
  //final Function()? onTap;
  final Function()? nameOnTap;
  const CustomFriendsList({super.key,required this.image, this.name, this.userName,this.reversText, this.nameOnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: nameOnTap,
            child: Row(
              children: [
                CustomNetworkImage(
                  imageUrl: image,
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
                      text: name ?? "",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    CustomText(
                      text: userName ?? "",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_80,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10.r),
             // border: Border.all(color: AppColors.primary,width: 2),
            ),
            child: Center(
                child: CustomText(
                  text: reversText?? "Follow",
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )),
          )
        ],
      ),
    );
  }
}
