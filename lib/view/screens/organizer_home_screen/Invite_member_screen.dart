
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/friend_screen/inner_widget/custom_friend_list.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/invite_volunteers_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteMemberScreen extends StatefulWidget {
  const InviteMemberScreen({super.key});

  @override
  State<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {

  final invitedController = Get.put(InviteVolunteersController());

  final queryEditingController = TextEditingController();

  String query = "";


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        appBar: const CustomRoyelAppbar(
          titleName: "Invite Volunteers",
          leftIcon: true,
        ),
        body:Obx(
                () {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child:Column(
                  children: [

                    ///============ search ======================================
                    CustomTextField(
                      textEditingController:queryEditingController,
                      fillColor: AppColors.neutral02,
                      //  hintText: AppStrings.search,
                      hintText: "Search for name...",
                      onChanged: (value){
                        setState(() {
                          query = value;
                        });
                        invitedController.searchVolunteersList(query);
                      },

                      suffixIcon: query.isBlank == true || query.isEmpty
                          ? Icon(
                        FluentIcons.search_24_regular,
                        size: 24,
                      )
                          : IconButton(
                          icon: Icon(Icons.close,size: 24,),
                          onPressed: () {
                            setState(() {
                              query = "";
                            });
                            queryEditingController.clear();
                            FocusScope.of(context).unfocus();

                            invitedController.searchVolunteersList("");

                          }),

                    ),


                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    invitedController.obx((state){

                      if (state == null || state.isEmpty) {

                        return SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          child: Center(
                            child: CustomText(
                              text: "No volunteers yet!!",
                              fontSize:isTablet?12.sp: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightRed,
                            ),
                          ),
                        );

                      }else{
                        return ListView.builder(
                            itemCount:state?.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final model =state?[index];

                              return Card(
                                elevation: 0.5,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10.h,left: 8,right: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (){},
                                        child: Row(
                                          children: [

                                            model?.image==""? CustomNetworkImage(
                                              imageUrl: AppConstants.profileImage,
                                              height:isTablet?64.h: 60.h,
                                              width:isTablet?64.w: 60.w,
                                              boxShape: BoxShape.circle,
                                            ):CustomNetworkImage(
                                              imageUrl: "${ApiUrl.imageUrl}${model?.image}",
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
                                                  text: "${model?.fullName}",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.black,
                                                ),
                                                CustomText(
                                                  text: "${model?.profession}",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.black_80,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*Obx(()=> Checkbox(
                                        checkColor: AppColors.white,
                                        activeColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3.0),
                                        ),
                                        side: const BorderSide(
                                          // ======> CHANGE THE BORDER COLOR HERE <======
                                          color: AppColors.primary,
                                          // Give your checkbox border a custom width
                                          width: 1.4,
                                        ),
                                        ///value: administratorController.selectedOranization.value,
                                        value: invitedController.volunteersIdList.contains(model?.id),
                                        onChanged: (bool? value) {

                                          invitedController.selectedVolunteers.value = value!;

                                          if(invitedController.selectedVolunteers.value){

                                            invitedController.volunteersIdList.add(model!.id.toString());

                                          }else{
                                            invitedController.volunteersIdList.remove(model?.id.toString());
                                          }

                                        },
                                      ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              );
                            });
                        }

                    }),

                  ],
                ),
              );
            }
        ),

        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(onTap: (){
              }, title: "Invite",fontSize: 12,),
            ),

          ],
        ),
      );
    });
  }
}
