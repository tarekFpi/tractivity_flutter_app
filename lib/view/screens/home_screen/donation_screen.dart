import 'package:flutter/material.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: AppStrings.donation,
        fontSize: 22,
        leftIcon: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600; // Detect if it's a tablet

          return Padding(
            padding: EdgeInsets.all(isTablet ? 20.0 : 12.0), // Adjust padding
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: isTablet ? 20 : 12),

                  /// **Donation Description**
                  CustomText(
                    text: "100% of your donation will go towards \n building the infrastructure \n of Serve Out. We have no paid staff.",
                    fontSize: isTablet ? 18 : 18,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                  ),

                  SizedBox(height: isTablet ? 20 : 12),

                  CustomText(
                    text: "Your Details",
                    fontSize: isTablet ? 18 : 18,
                    fontWeight: FontWeight.w600,
                    bottom: 12,
                  ),

                  /// **Email Field**
                  CustomFormCard(
                    title: AppStrings.email,
                    hintText: AppStrings.enterYourEmail,
                    fontSize: isTablet?16:16,
                    hasBackgroundColor: true,
                    controller: TextEditingController(),
                  ),

                  SizedBox(height: isTablet ? 16 : 8),

                  /// **First Name & Last Name**
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormCard(
                          title: AppStrings.firstName,
                          hintText: AppStrings.enterFristName,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: TextEditingController(),
                        ),
                      ),
                      SizedBox(width: isTablet ? 16 : 8),
                      Expanded(
                        child: CustomFormCard(
                          title: AppStrings.lastName,
                          hintText: AppStrings.enterLastName,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isTablet ? 16 : 8),

                  /// **Country & State**
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormCard(
                          title: AppStrings.country,
                          hintText: AppStrings.enterCountry,
                          hasBackgroundColor: true,
                          fontSize: isTablet?16:16,
                          controller: TextEditingController(),
                        ),
                      ),
                      SizedBox(width: isTablet ? 16 : 8),
                      Expanded(
                        child: CustomFormCard(
                          title: AppStrings.state,
                          hintText: AppStrings.enterState,
                          hasBackgroundColor: true,
                          fontSize: isTablet?16:16,
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isTablet ? 16 : 8),

                  /// **Summary Field**
                  CustomFormCard(
                    title: AppStrings.summary,
                    hintText: AppStrings.enterSummary,
                    hasBackgroundColor: true,
                    fontSize: isTablet?16:16,
                    controller: TextEditingController(),
                  ),

                  SizedBox(height: isTablet ? 20 : 12),

                  /// **Recurring Monthly Gift**
                  CustomText(
                    text: "Recurring Monthly Gift",
                    fontSize: isTablet ? 16 : 16,
                    fontWeight: FontWeight.w600,
                    bottom: 16,
                  ),

                  /// **Card Information**
                  CustomText(
                    text: AppStrings.card,
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w600,
                    bottom: 8,
                  ),

                  SizedBox(height: isTablet ? 12 : 8),

                  /// **Card Input**
                  Container(
                    height: 60,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.black_80, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              fillColor: AppColors.white,
                              hintText: "1234 1234 1234 1234",
                            ),
                          ),
                          CustomImage(imageSrc: AppIcons.cardImage)
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: isTablet ? 16 : 8),

                  /// **Expiration Date & Security Code**
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormCard(
                          title: AppStrings.expiration,
                          hintText: AppStrings.enterDay,
                          hasBackgroundColor: true,
                          fontSize: isTablet?16:16,
                          controller: TextEditingController(),
                        ),
                      ),
                      SizedBox(width: isTablet ? 16 : 8),
                      Expanded(
                        child: CustomFormCard(
                          title: AppStrings.security,
                          hintText: AppStrings.enterSecurity,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isTablet ? 24 : 16),

                  /// **Submit Button**
                  CustomButton(
                    onTap: () {},
                    title: "Submit",
                    height: isTablet ? 70 : 50,
                    fontSize: isTablet ? 16 : 16,
                  ),

                  SizedBox(height: isTablet ? 24 : 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
