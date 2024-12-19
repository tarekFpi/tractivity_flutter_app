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
        leftIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),

              CustomText(
                text:
                    "100% of your donation will go towards \n building the infrastructure of Serve Out. \n We have no paid staff.",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 12,
              ),
              CustomText(
                text: "Your Details",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                bottom: 12,
              ),

              ///============ email ============
              CustomFormCard(
                  title: AppStrings.email,
                  hintText: AppStrings.enterYourEmail,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              Row(
                children: [
                  ///============ first  Name ============
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: CustomFormCard(
                          title: AppStrings.firstName,
                          hintText: AppStrings.enterFristName,
                          hasBackgroundColor: true,
                          controller: TextEditingController()),
                    ),
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  ///============ last  Name ============
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: CustomFormCard(
                          title: AppStrings.lastName,
                          hintText: AppStrings.enterLastName,
                          hasBackgroundColor: true,
                          controller: TextEditingController()),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              Row(
                children: [
                  ///============ Country  Name ============
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: CustomFormCard(
                          title: AppStrings.country,
                          hintText: AppStrings.enterCountry,
                          hasBackgroundColor: true,
                          controller: TextEditingController()),
                    ),
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  ///============ last  Name ============
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: CustomFormCard(
                          title: AppStrings.state,
                          hintText: AppStrings.enterState,
                          hasBackgroundColor: true,
                          controller: TextEditingController()),
                    ),
                  ),
                ],
              ),

              ///============ Summary Name ============
              CustomFormCard(
                  title: AppStrings.summary,
                  hintText: AppStrings.enterSummary,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),

              ///============ Recurring Monthly Gift  ============
              const CustomText(
                text: "Recurring Monthly Gift",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                bottom: 16,
              ),

              ///============ Card number  ============
       /*       CustomFormCard(
                  title: AppStrings.card,
                  hintText: AppStrings.enterNumber,
                  hasBackgroundColor: true,
                  controller: TextEditingController()),*/

              CustomText(
                text: AppStrings.card,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                bottom: 8,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 60,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.black_80, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: [
                      Flexible(
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

              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  ///============ Expiration date  ============
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: CustomFormCard(
                          title: AppStrings.expiration,
                          hintText: AppStrings.enterDay,
                          hasBackgroundColor: true,
                          controller: TextEditingController()),
                    ),
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  ///============ security code ============
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: CustomFormCard(
                          title: AppStrings.security,
                          hintText: AppStrings.enterSecurity,
                          hasBackgroundColor: true,
                          controller: TextEditingController()),
                    ),
                  ),
                ],
              ),
              CustomButton(onTap: (){}, title: "Submit",)
            ],
          ),
        ),
      ),
    );
  }
}
