// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';

class MassageListScreen extends StatefulWidget {
  const MassageListScreen({super.key});

  @override
  State<MassageListScreen> createState() => _MassageListScreenState();
}

class _MassageListScreenState extends State<MassageListScreen> {

  final homeController = Get.find<HomeController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      homeController.conversationBySpecificUserShow();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: AppStrings.messages),
      body: LayoutBuilder(builder: (context,constraints){

        final isTablet = constraints.maxWidth > 600;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: RefreshIndicator(child: ListView(
            children: [
              Obx(
                      () {
                    return Column(
                      children: [
                        CustomTextField(
                            hintText: AppStrings.searchForSomeone,
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColors.black_60,
                              size:isTablet?32: 24,
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        homeController.conversationBySpecificMessageLoading.value?
                        Center(child: CircularProgressIndicator(color: Colors.amber,)):
                        homeController.conversationBySpecificUserShowList.isEmpty?
                        SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          child: Center(
                            child: CustomText(
                              text: "No conversations user yet!!",
                              fontSize:isTablet?12.sp: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightRed,
                            ),
                          ),
                        ):
                        ListView.builder(
                            itemCount: homeController.conversationBySpecificUserShowList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context,index){

                              final model=homeController.conversationBySpecificUserShowList[index];

                              return GestureDetector(
                                onTap: (){


                                  if(model.type=="group"){

                                    homeController.groupIntoEvent(model.receiver?.name.toString()??"",model.id.toString());
                                  }if(model.type=="direct"){

                                    homeController.groupIntoSingleUser(model.receiver?.name.toString()??"",model.receiver?.receiverId?.id.toString()??"");

                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          model.type=="group"?Image.asset("assets/icons/group.png",width: 45,height: 45,color: Colors.black,):
                                          CustomNetworkImage(
                                            //   imageUrl: AppConstants.profileImage,
                                            imageUrl:model.receiver?.receiverId?.image==""? AppConstants.profileImage:"${ApiUrl.imageUrl}${model.receiver?.receiverId?.image}",
                                            height: 50,
                                            width: 50,
                                            boxShape: BoxShape.circle,
                                          ),
                                          CustomText(
                                            text: "${model.receiver?.name}",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            left: 10,
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                        text: "${DateConverter.timeFormetString(model.createdAt.toString())}",
                                        fontSize: 12,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),




                        /*     /// ================= Group Messenger ================================

                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.messageScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [

                        Row(
                          children: [

                            CustomImage(imageSrc: AppIcons.groupImage),

                            CustomText(
                              text: "Cox’s Bazar Beach \n Helping Peolple",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              left: 10,
                            ),
                          ],
                        ),

                        Column(
                          children: [

                            CustomText(
                              text: "+30 People",
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),

                            SizedBox(
                              height: 8,
                            ),
                            CustomText(
                              text: "3.00 pm",
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            )
                          ],
                        ),
                        //

                      ],
                    ),
                  )*/
                      ],
                    );
                  }
              )
            ],
          ), onRefresh: ()async{
            await  homeController.notificationInvitationEventShow();
          })
        );
      }),
      bottomNavigationBar: NavBar(currentIndex: 2),
    );
  }
}
