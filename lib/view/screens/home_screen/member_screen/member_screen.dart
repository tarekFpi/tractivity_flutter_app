
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: AppStrings.member),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: Column(
            children: [

              SizedBox(height: 20.h,),
              Column(
                  children: List.generate(6, (index) {
                   /* return CustomFriendsList(
                      nameOnTap: (){
                        Get.toNamed(AppRoutes.eventsProfileScreen);
                      },
                      image: AppConstants.profileImage,
                      name: "Mehedi Hassan",
                      userName: "@mehedi",
                      reversText: "Select",
                    );*/

                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){},
                            child: Row(
                              children: [
                                CustomNetworkImage(
                                  imageUrl: AppConstants.profileImage,
                                  height: 60,
                                  width: 60,
                                  boxShape: BoxShape.circle,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Mehedi Hassan",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                    CustomText(
                                      text: "Student",
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
                            child: GestureDetector(
                              onTap: (){

                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    insetPadding: EdgeInsets.all(16),
                                    contentPadding: EdgeInsets.all(16),
                                    //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                    title: Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 32,
                                            color: Colors.black,
                                          )),
                                    ),
                                    content: SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      height: 250,
                                      child:Column(
                                        children: [

                                          ///============ Working Time ============
                                          CustomFormCard(
                                              title: "Working Time",
                                              hintText:"04:30 Hours",
                                              readOnly: true,
                                              hasBackgroundColor: true,
                                              controller: TextEditingController()),


                              /*            ///============ Working Distance ============
                                          CustomFormCard(
                                              title: "Working Distance",
                                              hintText:"12 Km",
                                              readOnly: true,
                                              hasBackgroundColor: true,
                                              controller: TextEditingController()),*/


                                          ///============ Working Role ============
                                          CustomFormCard(
                                              title: "Working Role",
                                              hintText:"Food Delivery",
                                              hasBackgroundColor: true,
                                              readOnly: true,
                                              controller: TextEditingController()),


                                        ],
                                      ),
                                    ),
                                  ),
                                );

                              },
                              child: const Center(
                                  child: CustomText(
                                    text: "Details",
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),


                        ],
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
