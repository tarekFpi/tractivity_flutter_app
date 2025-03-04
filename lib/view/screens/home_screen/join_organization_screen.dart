
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';

class JoinOrganizationScreen extends StatefulWidget {
  const JoinOrganizationScreen({super.key});

  @override
  State<JoinOrganizationScreen> createState() => _JoinOrganizationScreenState();
}

class _JoinOrganizationScreenState extends State<JoinOrganizationScreen> {

  final administratorController = Get.put(AdministratiorController());

  final  homeController = Get.find<HomeController>();

  final queryEditingController = TextEditingController();

  String query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homeController.organizationShow();


  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
          appBar: CustomRoyelAppbar(
            leftIcon: true,
            titleName: "Join Organization",
          ),
          body:Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12, vertical: isTablet?28:0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 8.h,
                  ),
                  ///======== Organization Search Bar ==============
                  CustomTextField(
                    textEditingController:queryEditingController,
                    fillColor: AppColors.neutral02,
                    //  hintText: AppStrings.search,
                    hintText: "Search for name...",
                    onChanged: (value){
                      setState(() {
                        query = value;
                      });
                      homeController.searchOrganizationList(query);
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

                          homeController.searchOrganizationList("");

                        }),

                  ),


                  const SizedBox(
                    height: 12,
                  ),

                  homeController.obx((state){

                   // Toast.errorToast("No Organization yet!!");

                    if (state == null || state.isEmpty) {

                     return SizedBox(
                        height: MediaQuery.of(context).size.height/2,
                        child: Center(
                          child: CustomText(
                            text: "No Organization yet!!",
                            fontSize:isTablet?12.sp: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.red,
                          ),
                        ),
                      );


                    }else{

                    //  Toast.errorToast("  Organization yet!!");
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state?.length,
                          itemBuilder: (BuildContext context,index){

                            final model = state?[index];

                            return Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height:isTablet?130.h: 110.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey_3.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: "${index+1}.",
                                                  fontSize: isTablet?6.sp:14.sp,
                                                  color: AppColors.black_80,
                                                  fontWeight: FontWeight.w600,
                                                ),

                                                CustomText(
                                                  text: "${model?.name}",
                                                  fontSize:isTablet?6.sp: 14.sp,
                                                  color: AppColors.black_80,
                                                  fontWeight: FontWeight.w600,
                                                  overflow: TextOverflow.clip,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),

                                        const SizedBox(
                                          height: 4,
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //  crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Expanded(
                                              child: CustomText(
                                                text: "${model?.description}",
                                                fontSize: 12,
                                                color: AppColors.black_80,
                                                fontWeight: FontWeight.w400,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ),

                                            Obx(()=> Checkbox(
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
                                              value: homeController.organizationIdList.contains(model?.id),
                                              onChanged: (bool? value) {

                                                homeController.selectedOranization.value = value!;

                                                if(homeController.selectedOranization.value){

                                                  homeController.organizationIdList.add(model!.id.toString());

                                                }else{
                                                  homeController.organizationIdList.remove(model?.id.toString());
                                                }

                                              },
                                            ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 4,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    }

                     })

                ],
              ),
            ),
          ),

         bottomNavigationBar:  Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
               child:homeController.joinOrganLoading.value?CustomLoader():CustomButton(
                 onTap: () {

                   if(homeController.organizationIdList.isEmpty){

                     Toast.errorToast("Select oranization name is Empty!!");
                   }else{

                     homeController.joinOrganizationVolunteer();
                   }

                 },
                 title: "Join",
                 height: 60.h,
                 textColor: AppColors.black,
                 fillColor: AppColors.primary,
                 fontSize:isTablet?8.sp: 14.sp,
               ),
             )
           ],
         ),
      );
    });
  }
}
