import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';


class AlertNotification extends StatefulWidget {

  AlertNotification({super.key});


@override
State<AlertNotification> createState() => _AlerNotificationState();
}

class _AlerNotificationState extends State<AlertNotification> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [



          CustomText(
            text: "Are you sure you want to \n Delete this Notification?",
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.black_80,
          ),

          SizedBox(
            height: 8.h,
          ),

          CustomButton(onTap: (){},title:"Yes",height: 45.h,),

          SizedBox(
            height: 12.h,
          ),
          CustomButton(onTap: (){},title:"NO",height: 45.h,fillColor: AppColors.white,textColor: AppColors.primary,
            isBorder: true,borderWidth: 1,)
        ],
      ),
    );
  }
}
