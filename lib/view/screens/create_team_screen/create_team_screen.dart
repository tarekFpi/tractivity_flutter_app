// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';

class CreateTeamScreen extends StatelessWidget {
  const CreateTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: AppStrings.createTeam,
        rightIcon: AppIcons.time,
        rightOnTap: (){
          Get.toNamed(AppRoutes.historyScreeen);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: Column(
          children: [
            ///================= Profile Image , Name and Location
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.unkown,
                  height: 70,
                  width: 70,
                  boxShape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
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
            SizedBox(
              height: 30,
            ),
            CustomFormCard(
                title: AppStrings.teamName,
                controller: TextEditingController()),
            CustomFormCard(
                title: AppStrings.addMember,
                readOnly: true,
                onTap: (){
                  Get.toNamed(AppRoutes.allMemberScreen);
                },
                prefixIcon: Icon(Icons.keyboard_arrow_down),
                controller: TextEditingController()),
            CustomFormCard(
                title: AppStrings.addEvent,
                readOnly: true,
                onTap: (){
                  Get.toNamed(AppRoutes.addEventsScreen);
                },
                prefixIcon: Icon(Icons.keyboard_arrow_down),
                controller: TextEditingController()),
            
            SizedBox(height: 30,),
            ///================= Done Button
            CustomButton(onTap: (){}, title: AppStrings.done,)
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 3),
    );
  }
}
