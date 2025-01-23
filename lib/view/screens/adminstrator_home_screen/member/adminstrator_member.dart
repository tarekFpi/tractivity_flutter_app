
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class AdminstratorMember extends StatefulWidget {
  const AdminstratorMember({super.key});

  @override
  State<AdminstratorMember> createState() => _AdminstratorMemberState();
}

class _AdminstratorMemberState extends State<AdminstratorMember> {
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true,titleName: AppStrings.member),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Column(
              children: [

                SizedBox(height: 20.h,),
                Column(
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: [
                                  CustomNetworkImage(
                                    imageUrl: AppConstants.profileImage,
                                    height:isTablet?64.h: 60.h,
                                    width:isTablet?64.w: 60.w,
                                    boxShape: BoxShape.circle,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                    Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Mehedi Hassan",
                                        fontSize:isTablet?8.sp:16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                      const CustomText(
                                        text: "Student",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black_80,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10.r),
                                // border: Border.all(color: AppColors.primary,width: 2),
                              ),
                              child: GestureDetector(
                                onTap: (){

                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      insetPadding: EdgeInsets.all(16),
                                      contentPadding: EdgeInsets.all(16),
                                      //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                      title: Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              size: 32,
                                              color: Colors.black,
                                            )),
                                      ),
                                      content: SizedBox(
                                        width: MediaQuery.sizeOf(context).width,
                                        height:MediaQuery.sizeOf(context).height/2.2,
                                        child:Column(
                                          children: [

                                            ///============ Working Time ============
                                            CustomFormCard(
                                                fontSize: isTablet?16:16,
                                                title: "Working Time",
                                                hintText:"04:30 Hours",
                                                readOnly: true,
                                                hasBackgroundColor: true,
                                                controller: TextEditingController()),


                                            ///============ Working Distance ============
                                            CustomFormCard(
                                                fontSize: isTablet?16:16,
                                                title: "Working Distance",
                                                hintText:"12 Km",
                                                readOnly: true,
                                                hasBackgroundColor: true,
                                                controller: TextEditingController()),


                                            ///============ Working Role ============
                                            CustomFormCard(
                                                fontSize: isTablet?16:16,
                                                title: "Working Role",
                                                hintText:"Food Delivery",
                                                hasBackgroundColor: true,
                                                readOnly: true,
                                                controller: TextEditingController()),


                                          ],
                                        ),
                                      ),
                                    ),
                                  );

                                },
                                child: const Center(
                                    child: CustomText(
                                      text: "Details",
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ),


                          ],
                        ),
                      );
                    })
                ),
              ],
            ),
          ),
        ),

      );
    });
  }
}
