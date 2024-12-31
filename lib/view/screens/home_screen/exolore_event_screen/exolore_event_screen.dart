// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/inner_widget/custom_explore_container.dart';

class ExoloreEventScreen extends StatelessWidget {
    ExoloreEventScreen({super.key});

    final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: AppStrings.exploreEvent,
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [

              ///======== Search Bar ===========
              CustomTextField(
                hintText: AppStrings.searchEvent,
                fillColor: AppColors.neutral02,
                suffixIcon: Icon(
                  Icons.search,
                  color: AppColors.black_60,
                ),
              ),

              SizedBox(
                height: 20,
              ),

              ///========= Complete Events Row Date Time ===========
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: AppStrings.completeEvent,
                    color: AppColors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "16 Dec, 2024",
                        color: AppColors.black_80,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      IconButton(
                          onPressed: () async {
                            DateTime? datePicker = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if(datePicker!=null){
                              print("Date: ${datePicker.day}-${datePicker.month}-${datePicker.year}");
                            }
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            color: AppColors.black_80,
                            size: 20,
                          ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Column(
                children: List.generate(2, (index) {



                  return  Padding(
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
                                text: "Cox’s Bazar Beach Helping Peolple"!,
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
                                  text: "Cox’s Bazar, Bangladesh",
                                  fontSize: 12,
                                  color: AppColors.black_80,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            /// Leader
                            Row(
                              children: [
                                CustomNetworkImage(
                                  imageUrl: AppConstants.profileImage,
                                  height: 30,
                                  width: 30,
                                  boxShape: BoxShape.circle,
                                ),
                                CustomText(
                                  text: "Mehedi",
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

                                GestureDetector(
                                  onTap: () {

                                    storage.write("status","banner_page");

                                    Get.toNamed(AppRoutes.exploreEventScreen);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: CustomText(
                                      text:  "Explore",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w),

                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                })
              )
            ],
          ),
        ),
      ),
    );
  }
}
