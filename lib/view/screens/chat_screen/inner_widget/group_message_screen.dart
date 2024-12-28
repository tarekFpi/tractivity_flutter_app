// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
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
        surfaceTintColor: AppColors.white,
        elevation: 1,
        shadowColor: AppColors.white,
        centerTitle: false,
        backgroundColor: AppColors.white_50,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        title: Row(
          children: [
            Stack(
              children: [

            /*    CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
                  height: 54.w,
                  width: 54.w,
                  boxShape: BoxShape.circle,
                ),*/

                CustomImage(imageSrc: AppIcons.groupImage,
                  height: 60.w,
                  width: 60.w,),

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
                  color: AppColors.black),

              CustomText(
                text: "Active Now",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.black.withOpacity(0.5),
              ),
            ]),
          ],
        ),
           actions: [

          IconButton(
            color: AppColors.black,
            icon: Icon(Icons.more_vert),
            onPressed: () {

              showModalBottomSheet(
                context: context,
               /// barrierColor: Colors.grey,
                 backgroundColor: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (BuildContext context) {
                  // UDE : SizedBox instead of Container for whitespaces
                  return SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[


                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              const Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  text: "Setting",
                                  fontSize: 24,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  bottom: 8,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Align(
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
                              )
                            ],
                          ),
                        ),


                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.removeFriendScreen);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.person,
                                      size: 32,
                                      color: Colors.black,
                                    )),

                                 SizedBox(
                                   width: 4,
                                 ),
                                 CustomText(
                                  text: "Remove someone from the Event",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        GestureDetector(
                          onTap: (){

                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: Colors.white,
                                insetPadding: EdgeInsets.all(8),
                                contentPadding: EdgeInsets.all(8),
                                title: SizedBox(),
                                content: SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: AlertDialogEvent(title: "Are you sure you want to \n Delete this Group?",discription: "",),
                                ),
                              ),
                            );

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 32,
                                      color: AppColors.primary,
                                    )),

                                SizedBox(
                                  width: 4,
                                ),
                                CustomText(
                                  text: "Delete",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary,
                                ),

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                },
              );


            },
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
                  /*  CustomNetworkImage(
                      imageUrl: AppConstants.groupImage,
                      height: 45.w,
                      width: 45.w,
                      boxShape: BoxShape.circle,
                    ),*/

                    CustomImage(imageSrc: AppIcons.groupImage,
                      height: 60.w,
                      width: 60.w,),

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
