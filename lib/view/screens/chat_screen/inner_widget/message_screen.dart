// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_strings/app_strings.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});
  final List<bool> align = [
    true,
    false,
    true,
    false,
    true,
    true,
    false,
    true,
    false,
    false,
    false
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: AppColors.black,
        elevation: 5,
        shadowColor: AppColors.black,
        centerTitle: false,
        backgroundColor: AppColors.black_80,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
                  height: 54.w,
                  width: 54.w,
                  boxShape: BoxShape.circle,
                ),
                Positioned(
                  bottom: 5.w,
                  right: 0,
                  child: Container(
                    height: 12.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                        color: AppColors.green, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
               CustomText(
                  text: AppStrings.profile,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white),
              CustomText(
                text: "Active Now",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.white.withOpacity(0.5),
              ),
            ]),
          ],
        ),
           actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
          /*IconButton(
            icon: CustomImage(imageSrc: AppIcons.personIcon),
            onPressed: () {},
          ),
          SizedBox(
            width: 10.w,
          )*/
        ],
      ),
      body: Column(
        children: [
          //============================= Measage Screen =============================
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: ListView(
                shrinkWrap: true,
                children: List.generate(
                  align.length,
                  (index) => CustomInboxMassage(
                      alignment: align[index],
                      message:
                          'Mi sento bene adesso. Ma ho un problema. Puoi fare una chiamata?',
                      messageTime: '2:00 PM'),
                ),
              ),
            ),
          ),
          //========================= Write Message Screen ==========================
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
            child: Row(
              children: [
                /*//===================== AttCh file button =======================
                CustomImage(
                  imageSrc: AppIcons.personIcon,size: 25,
                 // height: 25.w,
                 // width: 25.w,
                ),
                SizedBox(
                  width: 10.w,
                ),*/
                //===================== Write message field =======================
                Expanded(
                    child: CustomTextField(
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
                  fillColor: Colors.grey.withOpacity(.1),
                  hintText: 'Write your message',
                  fieldBorderColor: Colors.grey,
                )),
                SizedBox(
                  width: 10.w,
                ),
                //====================== Camera button =======================
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: const Icon(
                    Icons.send,
                    color: AppColors.white,
                  ),
                )

                //=================== Record button ====================
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomInboxMassage extends StatelessWidget {
  const CustomInboxMassage({
    super.key,
    required this.alignment,
    required this.message,
    this.messageTime,
  });

  final bool alignment;
  final String message;
  final String? messageTime;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            alignment ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          alignment
              ? Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height: 45.w,
                      width: 45.w,
                      boxShape: BoxShape.circle,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          decoration: BoxDecoration(
                            color:
                                alignment ? AppColors.white : AppColors.primary,
                            borderRadius: alignment
                                ? const BorderRadius.only(
                                    bottomRight: Radius.circular(16),
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  )
                                : const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.0.h, vertical: 10.h),
                            child: CustomText(
                              textAlign: TextAlign.left,
                              text: message,
                              fontSize: 16.sp,
                              color: alignment
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w400,
                              maxLines: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: CustomText(
                            text: messageTime ?? '',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  decoration: BoxDecoration(
                    color: alignment ? AppColors.white : AppColors.primary,
                    borderRadius: alignment
                        ? const BorderRadius.only(
                            bottomRight: Radius.circular(16),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.0.h, vertical: 10.h),
                    child: CustomText(
                      textAlign: TextAlign.left,
                      text: message,
                      fontSize: 16.sp,
                      color: alignment ? AppColors.black : AppColors.white,
                      fontWeight: FontWeight.w400,
                      maxLines: 20,
                    ),
                  ),
                ),
          SizedBox(
            height: 4.h,
          ),
          alignment
              ? Container()
              : CustomText(
                  text: messageTime ?? '',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }
}
