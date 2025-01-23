
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';


class OrganizationEventListScreen extends StatefulWidget {

  const OrganizationEventListScreen({super.key});

  @override
  State<OrganizationEventListScreen> createState() => _OrganizationEventListScreenState();
}

class _OrganizationEventListScreenState extends State<OrganizationEventListScreen> {
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar:AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                ));
          }),
          title: Text(
            "Event List",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [

                SizedBox(
                  height: 16.h,
                ),


                Column(
                    children: List.generate(2, (index) {

                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [

                            CustomNetworkImage(
                              imageUrl: AppConstants.eventImage,
                              height: isTablet ? 200.h : 170.h,
                              width: isTablet ? 180.w : 170.w,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
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
                                const Row(
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
                                const SizedBox(
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
                                    const CustomText(
                                      text: "Leader",
                                      fontSize: 14,
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    GestureDetector(
                                      onTap: () {

                                        Get.toNamed(AppRoutes.exploreEventScreen);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const CustomText(
                                          text:  "Explore",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
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
    });
  }
}
