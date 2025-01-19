// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';

class AllMemberScreen extends StatelessWidget {

  const AllMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: AppStrings.allMember,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: Column(
            children: [
              CustomTextField(
                  hintText: AppStrings.searchForSomeone,
                  suffixIcon: Icon(
                    Icons.search,
                    color: AppColors.black_60,
                  )),
              SizedBox(height: 20.h,),
              Column(
                  children: List.generate(6, (index) {
                    return CustomFriendsList(
                      nameOnTap: (){
                        Get.toNamed(AppRoutes.userEventProfile);
                      },
                      image: AppConstants.profileImage,
                      name: "Mehedi Hassan",
                      userName: "@mehedi",
                      reversText: "Select",
                    );
                  })
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: CustomButton(onTap: (){}, title: AppStrings.confirm,),
      ),
    );
  }
}
