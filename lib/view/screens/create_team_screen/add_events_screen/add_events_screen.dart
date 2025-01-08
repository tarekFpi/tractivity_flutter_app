// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/inner_widget/custom_container_row.dart';
class AddEventsScreen extends StatelessWidget {
  const AddEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: AppStrings.addEvent,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              Column(
                  children: List.generate(3, (index) {
                    return CustomContainerRow();
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
