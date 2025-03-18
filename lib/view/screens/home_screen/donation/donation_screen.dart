import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/donation/donation_controller.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {

  final  homeController = Get.find<HomeController>();

  final  donationController = Get.put(DonationController());


  @override
  Widget build(BuildContext context) {

    String longText =
        "100% of your donation will go towards building the infrastructure  of Serve Out. We have no paid staff.building the infrastructure  of Serve Out. We have no paid staff.500% of your donation will go towards building the infrastructure  of Serve Out. We have no paid staff.building the infrastructure  of Serve Out. We have no paid staff";

    return Scaffold(
      appBar: const CustomRoyelAppbar(
        titleName: AppStrings.donation,
        fontSize: 22,
        leftIcon: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600; // Detect if it's a tablet

          return Obx(
                  () {
                return Padding(
                  padding: EdgeInsets.all(isTablet ? 20.0 : 12.0), // Adjust padding
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: isTablet ? 20 : 12),

                        /// Donation Description**
                        /* CustomText(
                        text: "100% of your donation will go towards building the infrastructure  of Serve Out. We have no paid staff.building the infrastructure  of Serve Out. We have no paid staff.",
                        fontSize: isTablet ? 8.sp : 18.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                      ),*/

                        CustomText(
                          text: longText,
                          fontSize:isTablet?6.sp: 14.sp,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                          maxLines: 3,
                        ),

                        SizedBox(height: 4.h),
                        // Show more/less button
                        GestureDetector(
                          onTap: () {

                            homeController.isExpanded.value = !homeController.isExpanded.value;

                            if(isTablet){

                              showAlertDialog(context, longText,longText.length,isTablet);

                            }else{

                              ///Show BottomSheet when clicking on the text
                              showBottomSheet(context, longText,longText.length,isTablet);
                            }

                          },
                          child: Text(
                            homeController.isExpanded.value ? 'Show less' : 'Show more',
                            style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: isTablet?8.sp:14.sp),
                          ),
                        ),

                        SizedBox(height: isTablet ? 20 : 16.h),

                        CustomText(
                          text: "Basic details",
                          fontSize: isTablet ? 8.sp : 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          bottom: 12,
                        ),

                        /// **Email Field**
                        CustomFormCard(

                          title: AppStrings.email,
                          hintText: AppStrings.enterYourEmail,
                          fontSize: isTablet?16:16,
                          hasBackgroundColor: true,
                          controller: donationController.emailController.value,
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
                                controller: donationController.fristNameController.value,
                              ),
                            ),
                            SizedBox(width: isTablet ? 16 : 8),
                            Expanded(
                              child: CustomFormCard(
                                title: AppStrings.lastName,
                                hintText: AppStrings.enterLastName,
                                fontSize: isTablet?16:16,
                                hasBackgroundColor: true,
                                controller: donationController.lastNameController.value,
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: isTablet ? 16 : 8),

                        CustomText(
                          text: "Amount & card details",
                          fontSize: isTablet ? 7.sp : 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          bottom: 8,
                        ),
                        /// amount
                        CustomFormCard(
                          title: "Amount",
                          hintText: "\$0.00",
                          hasBackgroundColor: true,
                          fontSize: isTablet?16:16,
                          keyboardType: TextInputType.number,
                          controller: donationController.amountController.value,
                        ),

                        SizedBox(height: isTablet ? 20 : 12),

                        ///Card Information**
                        CustomText(
                          text: AppStrings.card,
                          fontSize: isTablet ? 16 : 14,
                          fontWeight: FontWeight.w600,
                          bottom: 8,
                        ),


                        ///Card Input
                        Container(
                          height: 60.h,
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
                                    keyboardType: TextInputType.number,
                                    textEditingController:donationController.cardNumberController.value,
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
                                controller: donationController.expirationDateController.value,
                              ),
                            ),
                            SizedBox(width: isTablet ? 16 : 8),
                            Expanded(
                              child: CustomFormCard(
                                title: AppStrings.security,
                                hintText: AppStrings.enterSecurity,
                                fontSize: isTablet?16:16,
                                hasBackgroundColor: true,
                                controller: donationController.securityCodeController.value,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: isTablet ? 12.h : 8.h),

                        CustomText(
                          text: "Donation Type",
                          fontSize: isTablet ? 8.sp : 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          bottom: 8,
                        ),

                        /*   CustomText(
                        text: "Donation Type",
                        fontSize: isTablet ? 8.sp : 12.sp,
                        fontWeight: FontWeight.w600,

                      ),*/

                        Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [

                            Radio<bool>(
                              value:
                              false, // Value for "No"
                              fillColor:
                              WidgetStateColor.resolveWith((states) =>
                              AppColors.primary),
                              groupValue: donationController.donationStatues.value,
                              onChanged:(bool? value) {

                                donationController.donationStatues.value = value!;

                              },
                            ),
                            CustomText(
                              text:
                              "One time gift",
                              fontSize:
                              isTablet?6.sp: 12.sp,
                              color: AppColors
                                  .black,
                              fontWeight:FontWeight.w600,
                            ),

                            Radio<bool>(
                              value:
                              true, // Value for "Yes"
                              fillColor:
                              WidgetStateColor.resolveWith((states) =>
                              AppColors.primary),
                              groupValue: donationController.donationStatues.value,
                              onChanged:(bool? value) {
                                donationController.donationStatues.value = value!;
                              },
                            ),

                            CustomText(
                              text:
                              "Recurring monthly gift",
                              fontSize:
                              isTablet?6.sp: 12.sp,
                              color: AppColors
                                  .primary,
                              fontWeight:
                              FontWeight
                                  .w600,
                            ),
                          ],
                        ),
                        SizedBox(height: isTablet ? 16.h : 8.h),

                        /// **Submit Button**
                        donationController.donationLoading.value?Center(child: CircularProgressIndicator(color: Colors.amber,)):
                        CustomButton(
                          onTap: () {


                            if(donationController.emailController.value.text==""){

                              Toast.errorToast("Email is Empty!!");

                            }else if(donationController.fristNameController.value.text==""){
                              Toast.errorToast("Frist Name is Empty!!");

                            }else if(donationController.lastNameController.value.text==""){
                              Toast.errorToast("Last Name is Empty!!");

                            }else if(donationController.amountController.value.text==""){
                              Toast.errorToast("Amount is Empty!!");

                            }else if(donationController.cardNumberController.value.text==""){
                              Toast.errorToast("Card number is Empty!!");

                            }else if(donationController.securityCodeController.value.text==""){
                              Toast.errorToast("Security Code is Empty!!");
                            }else{

                              donationController.donationCreate();
                            }
                          },
                          title: "Submit",
                          height: isTablet ? 70 : 50,
                          fontSize: isTablet ? 16 : 16,
                        ),

                        SizedBox(height: isTablet ? 24 : 16),
                      ],
                    ),
                  ),
                );
              }
          );
        },
      ),
      bottomNavigationBar: NavBar(currentIndex: 4),
    );
  }


  // Function to show the full text in a BottomSheet
  void showBottomSheet(BuildContext context, String longText,int maxLines, bool isTablet) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      const Text(
                        '',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                      InkWell(
                          onTap: (){
                            Navigator.pop(context);

                            homeController.isExpanded.value=false;
                          },
                          child: Icon(Icons.clear,size: 32,))
                    ],
                  ),
                  SizedBox(height: 12.h),

                  CustomText(
                    text: longText,
                    fontSize:isTablet?6.sp:14.sp,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    maxLines: maxLines,
                  ),
                  SizedBox(height: 10),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Function to show the full text in a BottomSheet
  void showAlertDialog(BuildContext context, String longText,int maxLines, bool isTablet) {

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(8),
        contentPadding: EdgeInsets.all(8),
        //   clipBehavior: Clip.antiAliasWithSaveLayer,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: "",
                fontSize: 24,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                bottom: 8,
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    homeController.isExpanded.value=false;
                  },
                  child: const Icon(
                    Icons.close,
                    size: 32,
                    color: Colors.black,
                  )),
            )
          ],
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomText(
                  text: longText,
                  fontSize:isTablet?6.sp:14.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  maxLines: maxLines,
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
    );

  }
}
