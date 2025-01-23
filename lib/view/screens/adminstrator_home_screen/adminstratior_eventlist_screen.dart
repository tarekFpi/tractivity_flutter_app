
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';


class AdminstratiorEventListScreen extends StatefulWidget {
  const AdminstratiorEventListScreen({super.key});

  @override
  State<AdminstratiorEventListScreen> createState() => _AdminstratiorEventListScreenState();
}

class _AdminstratiorEventListScreenState extends State<AdminstratiorEventListScreen> {

  String missionId="";

  final administratorController = Get.put(AdministratiorController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.arguments[0]["missionId"]!=null){

      missionId = Get.arguments[0]["missionId"];

     administratorController.missionByEventShow(missionId);

    }
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;


      return Scaffold(

        appBar:  AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Get.back(),
                icon:   Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.black,
                  size: isTablet?42:24,
                ));
          }),
          title: Text(
            "Event List",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600),
          ),

        ),
        body: Obx(
           () {
           //  administratorController.addressList.clear();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [

                    const SizedBox(
                      height: 24,
                    ),

                    administratorController.missionByEventShowLoading.value?CustomLoader():
                    Column(
                        children: List.generate(administratorController.missionByEventShowList.length, (index) {

                          final model = administratorController.missionByEventShowList[index];

                          administratorController.getAddressFromLatLng(model.cords?.lat??0.0,model.cords?.lng??0.0);

                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children: [

                                CustomNetworkImage(
                                 /// imageUrl: AppConstants.eventImage,
                                  imageUrl:"${ApiUrl.imageUrl}${model.images?[0]}",
                                  height: isTablet ? 200.h : 170.h,
                                  width: isTablet ? 180.w : 170.w,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    SizedBox(
                                      width: 150.w,
                                      child: CustomText(
                                        textAlign: TextAlign.start,
                                        text: "${model.name}",
                                        maxLines: 3,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        bottom: 5,
                                      ),
                                    ),
                                    /// Location
                                      Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: AppColors.black,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 150.w,
                                          child: CustomText(
                                            text: "${administratorController.addressList.isNotEmpty?administratorController.addressList[index]:""}",
                                        ///  text: "${administratorController.getAddressFromLatLng(model.cords?.lat??0.0,model.cords?.lng??0.0)}",
                                            fontSize: 12,
                                            color: AppColors.black_80,
                                            fontWeight: FontWeight.w400,
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    /// Leader
                                    Row(
                                      children: [
                                        CustomNetworkImage(
                                          imageUrl: AppConstants.profileImage,
                                          height: 30,
                                          width: 30,
                                          boxShape: BoxShape.circle,
                                        ),
                                        CustomText(
                                          text: "${model.creator?.name}",
                                          fontSize:isTablet?6.sp: 12.sp,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis, // Show "..." for overflowing text
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          left: 4,
                                        ),

                                          CustomText(
                                          text: "Leader",
                                          fontSize:isTablet?6.sp: 12.sp,
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w600,
                                         left: 4,                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        GestureDetector(
                                          onTap: () {

                                            Get.toNamed(AppRoutes.adminstratorEventDetailsScreen,arguments: [
                                              {
                                                "eventId":model.id
                                              }
                                            ]);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const CustomText(
                                              text:  "Explore",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),

                                      /*  const SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () {

                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                backgroundColor: Colors.white,
                                                insetPadding: EdgeInsets.all(8),
                                                contentPadding: EdgeInsets.all(8),
                                                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                                title: SizedBox(),
                                                content: SizedBox(
                                                  width: MediaQuery.sizeOf(context).width,
                                                  child: AlertDialogEvent(title: "Are you sure you want to \n Approved this Event?",discription: "",),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const CustomText(
                                              text:  "Approved",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),*/

                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        })
                    )
                  ],
                ),
              ),
            );
          }
        ),
      );
    });
  }
}
