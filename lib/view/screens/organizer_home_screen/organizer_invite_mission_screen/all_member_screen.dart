/*

import 'package:flutter/material.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';

class AllMemberScreen extends StatefulWidget {
  const AllMemberScreen({super.key});

  @override
  State<AllMemberScreen> createState() => _AllMemberScreenState();
}

class _AllMemberScreenState extends State<AllMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRoyelAppbar(
        titleName: "Invite",
        leftIcon: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child:Column(
          children: [



            Column(
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: (){

                    },
                    child: CustomFriendsList(
                      image: AppConstants.profileImage,
                      name: "Mehedi Hassan",
                      userName: "@mehedi",
                      reversText: "Details",
                    ),
                  );
                })
            )
          ],
        ),
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(onTap: (){
            }, title: "Invite",fontSize: 12,),
          ),

        ],
      ),
    );
  }
}
*/
