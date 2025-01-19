// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';
class EventMemberDetailsScreen extends StatelessWidget {
  const EventMemberDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Member",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
        child: Column(
            children: List.generate(6, (index) {
              return CustomFriendsList(
                nameOnTap: (){
                  Get.toNamed(AppRoutes.userEventProfile);
                },
                image: AppConstants.profileImage,
                name: "Mehedi Hassan",
                userName: "Student",
                reversText: "Details",
              );
            })
        ),
      ),
    );
  }
}
