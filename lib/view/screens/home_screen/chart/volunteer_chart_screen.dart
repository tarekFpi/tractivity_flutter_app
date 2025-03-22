import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/utils/SocketApi.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';


class VolunteerChartScreen extends StatefulWidget {
  VolunteerChartScreen({super.key});

  @override
  State<VolunteerChartScreen> createState() => _VolunteerChartScreenState();
}

class _VolunteerChartScreenState extends State<VolunteerChartScreen> {
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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  final homeController = Get.find<HomeController>();
  var user_id = "";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homeController.listenNewMessage();
    homeController.conversationAllMessageShow(homeController.conversationtShowList.value.id.toString());

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
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          title: Row(
            children: [

              SizedBox(
                width: 10.w,
              ),

              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                 CustomText(
                    text: "Message",
                    fontSize:isTablet?10.sp: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black),
              ]),
            ],
          ),

        ),
        body:Obx(
          () {
            return Column(
              children: [
                //============================= Measage Screen =============================
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: ListView.builder(
                        reverse: true,
                        itemCount: homeController.conversationAllMessageShowList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final model = homeController.conversationAllMessageShowList[index];

                          return CustomInboxMassage(
                            alignment: model.sender?.id==user_id?false:true,
                            message:
                            '${model.content}',
                            messageTime: '${DateConverter.timeFormetString(model.createdAt.toString())}',);
                        }
                    ),
                  ),
                ),
                //========================= Write Message Screen ==========================
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
                  child: Row(
                    children: [

                      ///===================== Write message field =======================
                      Expanded(
                          child: CustomTextField(
                            textEditingController: homeController.messageController.value,
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

                    //  homeController.sendLoading.value?CircularProgressIndicator(color: Colors.amber,):
                      GestureDetector(
                        onTap: (){

                          homeController.sendChat(homeController.conversationtShowList.value.id.toString());
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
                          fontSize:isTablet?14: 14.sp,
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
                        fontSize:isTablet?14: 14.sp,
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
                  fontSize:isTablet?14: 14.sp,
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
              fontSize:isTablet?14: 14.sp,
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
}



