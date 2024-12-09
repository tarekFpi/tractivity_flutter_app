// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.termsAndConditions,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: AppColors.white_50,
            borderRadius: BorderRadius.circular(10),
          ),child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CustomText(
                text: "gravida elit enim. lobortis, ex orci lobortis, Donec orci elit felis, luctus ultrices odio tincidunt cursus elit ex nisi vehicula, Morbi Nunc Morbi venenatis sollicitudin. tortor. dui non quam dui. nibh tortor. sit viverra maximus ipsum",
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                maxLines: 8,
                textAlign: TextAlign.start,
                bottom: 20,
              ),
              CustomText(
                text: "gravida elit enim. lobortis, ex orci lobortis, Donec orci elit felis, luctus ultrices odio tincidunt cursus elit ex nisi vehicula, Morbi Nunc Morbi venenatis sollicitudin. tortor. dui non quam dui. nibh tortor. sit viverra maximus ipsum",
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                maxLines: 8,
                textAlign: TextAlign.start,
                bottom: 20,
              ),
              CustomText(
                text: "gravida elit enim. lobortis, ex orci lobortis, Donec orci elit felis, luctus ultrices odio tincidunt cursus elit ex nisi vehicula, Morbi Nunc Morbi venenatis sollicitudin. tortor. dui non quam dui. nibh tortor. sit viverra maximus ipsum",
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                maxLines: 8,
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
        ),
      ),
    );
  }
}
