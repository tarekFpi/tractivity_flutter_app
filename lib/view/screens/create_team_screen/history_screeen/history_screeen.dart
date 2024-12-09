// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/inner_widget/custom_container_row.dart';
class HistoryScreeen extends StatelessWidget {
  const HistoryScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: AppStrings.history,),
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
    
    );
  }
}
