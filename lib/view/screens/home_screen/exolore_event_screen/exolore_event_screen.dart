// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/inner_widget/custom_explore_container.dart';

class ExoloreEventScreen extends StatelessWidget {
  const ExoloreEventScreen({super.key});

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
                  return CustomExploreContainer(
                    image: AppConstants.profileImage,
                    title: "Cox’s Bazar Beach Helping Peolple",
                    location: "Cox’s Bazar, Bangladesh",
                    leaderName: "Mehedi",
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
