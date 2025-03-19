 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';


class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  final eventController = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Obx(
       () {

          return GestureDetector(
            onTap: (){

              Get.toNamed(AppRoutes.userEventProfile);
            },
            child: Row(
              children: [
                eventController.userProfileShowLoading.value?CustomLoader():
                CustomNetworkImage(
                  imageUrl:eventController.userProfileShowList.value.image==""? AppConstants.profileImage:"${ApiUrl.imageUrl}${eventController.userProfileShowList.value.image}",
                  height: 100.h,
                  width: 100.w,
                  boxShape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    CustomText(
                      text: "${eventController.userProfileShowList.value.fullName}",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(

                      children: [

                        Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 20,
                        ),

                        SizedBox(
                          width: 140.w,
                          child: CustomText(
                            text: "${eventController.userProfileShowList.value.address}",
                            fontSize:isTablet?6.sp: 12.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                            maxLines:eventController.userProfileShowList.value.address?.length,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }
      );
    });
  }
}
