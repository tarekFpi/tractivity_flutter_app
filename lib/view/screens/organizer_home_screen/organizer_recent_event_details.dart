import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';


class OrganizerRecentEventDetails extends StatefulWidget {

  const OrganizerRecentEventDetails({super.key});

  @override
  State<OrganizerRecentEventDetails> createState() => _OrganizerRecentEventDetailsState();
}

class _OrganizerRecentEventDetailsState extends State<OrganizerRecentEventDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Organizer Event Details",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: AppConstants.profileImage,
                height: 170.h,
                width: MediaQuery.of(context).size.width,
                borderRadius: BorderRadius.circular(10),
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImage(imageSrc: AppIcons.dowanload),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          const CustomText(
                            text: "Rohingya refugee camp",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_80,
                          ),
                          const SizedBox(
                            width: 30,
                          ),

                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoutes.messageScreen);
                            },
                              child: CustomImage(imageSrc: AppIcons.chart)),

                          const SizedBox(
                            width: 16,
                          ),

                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoutes.memberScreen);
                            },
                              child: Icon(Icons.menu,size: 24,)),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomText(
                        text: "Download",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightBlue,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              CustomText(
                text: "Rohingya refugee camp",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black_80,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Icon(
                    Icons.monetization_on_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  CustomText(
                    text: "3500",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_80,
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  CustomText(
                    text: "Cox’s Bazar",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_80,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.profileImage,
                    height: 24,
                    width: 24,
                    boxShape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 3),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text.rich(
                    TextSpan(
                        text: 'Mehedi Bin',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: ' Leader',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightBlue),
                          ),
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.profileImage,
                    height: 24,
                    width: 24,
                    boxShape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 3),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text.rich(
                    TextSpan(
                        text: 'Sujon',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: ' Food Delivery',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightBlue),
                          ),
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const CustomText(
                text: "Description",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black_80,
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomText(
                text:
                    "The Rohingya have faced decades of discrimination \n and repression under successive Myanmar authorities. denied citizenship \n under the 1982 Citizenship Law, they are one of \n the largest stateless populations in the world.",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.black_80,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 16,
              ),
              const CustomText(
                text: "Time & Date",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black_80,
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomText(
                text: "22 December, 2024, 8.00 am-12.00 pm",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.black_80,
              ),
              const SizedBox(
                height: 16,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
