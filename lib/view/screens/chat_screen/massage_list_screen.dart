// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';

class MassageListScreen extends StatelessWidget {
  const MassageListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: AppStrings.messages),
      body: LayoutBuilder(builder: (context,constraints){

        final isTablet = constraints.maxWidth > 600;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [

              CustomTextField(
                  hintText: AppStrings.searchForSomeone,
                  suffixIcon: Icon(
                    Icons.search,
                    color: AppColors.black_60,
                    size:isTablet?32: 24,
                  )),
              SizedBox(
                height: 20.h,
              ),

              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.singleMessageScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: AppConstants.profileImage,
                          height: 50,
                          width: 50,
                          boxShape: BoxShape.circle,
                        ),
                        CustomText(
                          text: "Mehedi Hassan",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          left: 10,
                        ),
                      ],
                    ),
                    CustomText(
                      text: "3.00 pm",
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 22.h,
              ),

              /// ================= Group Messenger ================================

              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.messageScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [

                    Row(
                      children: [

                        CustomImage(imageSrc: AppIcons.groupImage),

                        CustomText(
                          text: "Cox’s Bazar Beach \n Helping Peolple",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          left: 10,
                        ),
                      ],
                    ),

                    Column(
                      children: [

                        CustomText(
                          text: "+30 People",
                          fontSize: 14,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),

                        SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          text: "3.00 pm",
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                    //

                  ],
                ),
              )
            ],
          ),
        );
      }),
      bottomNavigationBar: NavBar(currentIndex: 2),
    );
  }
}
