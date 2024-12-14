
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractivity_app/main.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

import '../../components/custom_button/custom_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRoyelAppbar(
        titleName: "Notifications",
        leftIcon: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomText(
                text: "Event invitation",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),

              SizedBox(
                height: 16.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SvgPicture.asset(
                    AppIcons.userIcons,
                  ),

                  SizedBox(
                    width: 8.w
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const CustomText(
                        text: "Nahid Hossain invite you for a event.",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      const CustomText(
                        text: "20 June. 2024",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Row(
                        children: [
                          CustomButton(
                            onTap: () {},
                            title: "Accept",
                            width: 70.w,
                            height: 32.h,
                            textColor: AppColors.black,
                            fillColor: AppColors.primary,
                            isBorder: true,
                            fontSize: 14,
                          ),

                          const SizedBox(
                            width: 12,
                          ),
                          CustomButton(
                            onTap: () {},
                            title: "Delete",
                            width: 70.w,
                            height: 32.h,
                            textColor: AppColors.black,
                            fillColor: AppColors.white_50,
                            isBorder: true,
                            fontSize: 14,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),


              const SizedBox(
                height: 26,
              ),

              CustomText(
                text: "Event invitation",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),

              SizedBox(
                height: 16.h,
              ),

              Column(
                children: List.generate(6, (index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SvgPicture.asset(
                          AppIcons.eventIcons,
                        ),

                        SizedBox(
                            width: 8.w
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const CustomText(
                              text: "Nahid Hossain invite you for a event.",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),

                            const SizedBox(
                              height: 8,
                            ),
                            const CustomText(
                              text: "20 June. 2024",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            CustomButton(
                              onTap: () {},
                              title: "Explore",
                              width: 70.w,
                              height: 32.h,
                              textColor: AppColors.black,
                              fillColor: AppColors.primary,
                              isBorder: true,
                              fontSize: 14,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

