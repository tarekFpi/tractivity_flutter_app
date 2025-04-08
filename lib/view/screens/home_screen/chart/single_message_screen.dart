// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/home_screen/chart/message_list/massage_list_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/chart/message_list/messagelist_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_strings/app_strings.dart';

class SingleMessageScreen extends StatefulWidget {
  SingleMessageScreen({super.key});

  @override
  State<SingleMessageScreen> createState() => _SingleMessageScreenState();
}

class _SingleMessageScreenState extends State<SingleMessageScreen> {
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

  //final homeController = Get.find<HomeController>();

  final messageController = Get.put(MessagelistController());

  var user_id = "";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    messageController.listenNewMessage();
    messageController.conversationAllMessageShow(messageController.conversationtUserShowList.value.id.toString());

    getUserId();
  }

  ///======================= create Room Chat =================
  void getUserId() async{

    user_id = await  SharePrefsHelper.getString(AppConstants.userId);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.2;
    final width = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        key: scaffoldKey,
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
                onPressed: (){

                  Get.off(() => MassageListScreen());
                 // Navigator.pop(context);
                }
              ),
            ],
          ),
          title: Row(
            children: [

              Icon(Icons.group,color: Colors.black,size: 32,),

              SizedBox(
                width: 8.w,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(()=> CustomText(
                          text: "${messageController.conversationtUserShowList.value.receiver?.name}",
                          fontSize:isTablet?10.sp: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black),
                    ),
                  ]),
            ],
          ),

        ),
        body:Obx(
                () {
              return Column(
                children: [
                  //============================= Message Screen =============================
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: ListView.builder(
                          reverse: true,
                          itemCount: messageController.conversationAllMessageShowList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final model = messageController.conversationAllMessageShowList[index];

                            return CustomInboxMassage(
                              alignment: model.sender?.id==user_id?false:true,
                              message:'${model.content}',
                              image:'${model.sender?.image}',
                              attachments: model.attachment!.toList(),
                              messageTime: '${DateConverter.timeFormetString(model.createdAt.toString())}',);
                          }
                      ),
                    ),
                  ),
                  //========================= Write Message Screen ==========================

                  if ((messageController.selectedImages.isNotEmpty))
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: messageController.selectedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  messageController.selectedImages[index],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.cancel, color: Colors.red),
                                  onPressed: () =>
                                      messageController.removeImage(index),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
                    child: Row(
                      children: [

                        ///===================== Write message field =======================
                        Expanded(
                            child: CustomTextField(
                              textEditingController: messageController.messageController.value,
                              suffixIcon:
                              IconButton(onPressed: () {

                                messageController.pickImagesFromGallery();
                              }, icon: const Icon(Icons.image)),
                              fillColor: Colors.grey.withOpacity(.1),
                              hintText: 'Write your message',
                              fieldBorderColor: Colors.grey,
                            )),

                        SizedBox(
                          width: 10.w,
                        ),
                        //====================== Camera button =======================

                        //  homeController.sendLoading.value?CircularProgressIndicator(color: Colors.amber,):
                        GestureDetector(
                          onTap: (){

                            messageController.sendChat(messageController.conversationtUserShowList.value.id.toString());
                          },
                          child: Container(
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
                          ),
                        )

                        //=================== Record button ====================
                      ],
                    ),
                  )
                ],
              );
            }
        ),
      );
    });
  }
}

class CustomInboxMassage extends StatelessWidget {
  CustomInboxMassage({
    super.key,
    required this.alignment,
    required this.message,
    required this.image,
    required this.attachments,
    this.messageTime,
  });

  final bool alignment;
  final String message;
  final String image;
  final List<String> attachments;
  final String? messageTime;

  final  messageController = Get.find<MessagelistController>();

  @override
  Widget build(BuildContext context) {



    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;
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
                  imageUrl: image.isEmpty?AppConstants.profileImage:"${ApiUrl.imageUrl}${image}",
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
                        alignment ? AppColors.grey_3 : AppColors.primary,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              textAlign: TextAlign.left,
                              text: message,
                              fontSize:isTablet?14: 14.sp,
                              color: alignment
                                  ? AppColors.black
                                  : AppColors.white,
                              fontWeight: FontWeight.w400,
                              maxLines: 20,
                            ),

                            // Image Gallery (if multiple images exist)
                            if ((attachments.isNotEmpty))
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0.h, vertical: 8.h),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: attachments
                                      .map((imageUrl) => GestureDetector(

                                    onTap: () {
                                      // Handle image click (open full view)
                                      debugPrint("Open image: $imageUrl");


                                      ///adding some properties
                                      showModalBottomSheet(
                                        context: context,
                                        ///background color for modal bottom screen
                                        backgroundColor: Colors.white,
                                        ///elevates modal bottom screen
                                        elevation: 10,
                                        /// gives rounded corner to modal bottom screen
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        builder: (BuildContext context) {
                                          ///UDE : SizedBox instead of Container for whitespaces
                                          return SizedBox(
                                            height: MediaQuery.sizeOf(context).height/2.5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child:Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Column(
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
                                                              },
                                                              child: Icon(Icons.clear,size: 32,))
                                                        ],
                                                      ),


                                                      CarouselSlider.builder(
                                                        options: CarouselOptions(
                                                          initialPage: messageController.sliderChatCurrentIndex.value,
                                                          autoPlay: true,
                                                          aspectRatio: 2.0,
                                                          enlargeCenterPage: true,
                                                          height: MediaQuery.sizeOf(context).height / 5,
                                                          onPageChanged: (index, reason) {

                                                            messageController.sliderChatCurrentIndex.value = index;
                                                          },
                                                        ),
                                                        itemCount: attachments.length??0,
                                                        itemBuilder: (context, index, realIndex) {

                                                          return  CustomNetworkImage(
                                                            //imageUrl: AppConstants.profileImage,
                                                            imageUrl:"${ApiUrl.imageUrl}$imageUrl",
                                                            height:isTablet?200.h: 180.h,
                                                            width: MediaQuery.of(context).size.width,
                                                            borderRadius: BorderRadius.circular(10),
                                                          );
                                                        },
                                                      ),

                                                      SizedBox(
                                                        height: 16.h,
                                                      ),

                                                      ///======== Dots ===========
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: List.generate(
                                                          attachments.length??0,
                                                              (index) => buildDot(index, context),
                                                        ),
                                                      ),

                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [

                                          Image.network(
                                            "${ApiUrl.imageUrl}$imageUrl",
                                            width: 100.w,
                                            height: 100.h,
                                            fit: BoxFit.cover,
                                          ),

                                          Positioned(
                                              right: 0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 4,right: 2),
                                                child: InkWell(
                                                    onTap: (){

                                                      messageController.startImageDownload("${ApiUrl.baseUrl}/${imageUrl}","${imageUrl.split("\\").last}");
                                                    },
                                                    child: Icon(Icons.download,color: Colors.green,size: 28,)),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  )
                                      .toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: CustomText(
                        text: messageTime ?? '',
                        fontSize:isTablet?14: 12.sp,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.0.h, vertical: 0.h),
                    child: CustomText(
                      textAlign: TextAlign.left,
                      text: message,
                      fontSize:isTablet?14: 14.sp,
                      color: alignment ? AppColors.black : AppColors.white,
                      fontWeight: FontWeight.w400,
                      maxLines: 20,
                    ),
                  ),

                  // Image Gallery (if multiple images exist)
                  if ((attachments.isNotEmpty))
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0.h, vertical: 8.h),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: attachments
                            .map((imageUrl) => GestureDetector(

                          onTap: () {
                            // Handle image click (open full view)
                            debugPrint("Open image: $imageUrl");


                            ///adding some properties
                            showModalBottomSheet(
                              context: context,
                              ///background color for modal bottom screen
                              backgroundColor: Colors.white,
                              ///elevates modal bottom screen
                              elevation: 10,
                              /// gives rounded corner to modal bottom screen
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              builder: (BuildContext context) {
                                ///UDE : SizedBox instead of Container for whitespaces
                                return SizedBox(
                                  height: MediaQuery.sizeOf(context).height/2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Column(
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
                                                    },
                                                    child: Icon(Icons.clear,size: 32,))
                                              ],
                                            ),


                                            CarouselSlider.builder(
                                              options: CarouselOptions(
                                                initialPage: messageController.sliderChatCurrentIndex.value,
                                                autoPlay: true,
                                                aspectRatio: 2.0,
                                                enlargeCenterPage: true,
                                                height: MediaQuery.sizeOf(context).height / 5,
                                                onPageChanged: (index, reason) {

                                                  messageController.sliderChatCurrentIndex.value = index;
                                                },
                                              ),
                                              itemCount: attachments.length??0,
                                              itemBuilder: (context, index, realIndex) {

                                                return  CustomNetworkImage(
                                                  //imageUrl: AppConstants.profileImage,
                                                  imageUrl:"${ApiUrl.imageUrl}$imageUrl",
                                                  height:isTablet?200.h: 180.h,
                                                  width: MediaQuery.of(context).size.width,
                                                  borderRadius: BorderRadius.circular(10),
                                                );
                                              },
                                            ),

                                            SizedBox(
                                              height: 16.h,
                                            ),

                                            ///======== Dots ===========
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: List.generate(
                                                attachments.length??0,
                                                    (index) => buildDot(index, context),
                                              ),
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(12),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [

                                Image.network(
                                  "${ApiUrl.imageUrl}$imageUrl",
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),

                                Positioned(
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4,right: 2),
                                      child: InkWell(
                                          onTap: (){

                                            messageController.startImageDownload("${ApiUrl.baseUrl}/${imageUrl}","${imageUrl.split("\\").last}");
                                          },
                                          child: Icon(Icons.download,color: Colors.green,size: 28,)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        ) .toList(),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            alignment
                ? Container()
                : CustomText(
              text: messageTime ?? '',
              fontSize:isTablet?14: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      );
    });
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4,
      width: messageController.sliderChatCurrentIndex.value == index ? 30 : 15,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: messageController.sliderChatCurrentIndex.value == index
            ? AppColors.lightRed
            : AppColors.grey_1,
      ),
    );
  }
}