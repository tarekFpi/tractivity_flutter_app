
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';

class RemoveFriendScreen extends StatefulWidget {
  const RemoveFriendScreen({super.key});

  @override
  State<RemoveFriendScreen> createState() => _RemoveFriendScreenState();
}

class _RemoveFriendScreenState extends State<RemoveFriendScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: AppStrings.removeFriend,leftIcon: true,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: Column(
            children: [


              SizedBox(height: 10,),

              const CustomTextField(
                  hintText: AppStrings.searchForSomeone,
                  suffixIcon: Icon(
                    Icons.search,
                    color: AppColors.black_60,
                  )),

              SizedBox(height: 20.h,),

              Column(
                  children: List.generate(6, (index) {
                    return GestureDetector(
                      onTap: (){

                      // Get.toNamed(AppRoutes.eventsProfileScreen);
                      },
                      child: CustomFriendsList(
                        image: AppConstants.profileImage,
                        name: "Mehedi Hassan",
                        userName: "married",
                        reversText: "Remove",
                      ),
                    );
                  })
              ),


            ],
          ),
        ),
      ),

    );
  }
}
