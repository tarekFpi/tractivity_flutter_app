import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class AlertDialogEvent extends StatefulWidget {

  String title;

  String discription;

  AlertDialogEvent({super.key,required this.title,required this.discription});

  @override
  State<AlertDialogEvent> createState() => _AlertDialogEventState();
}

class _AlertDialogEventState extends State<AlertDialogEvent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          CustomText(
            text:"${widget.title}",
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.black_80,
          ),

          SizedBox(
            height: 8.h,
          ),

          CustomButton(onTap: (){
            Navigator.of(context).pop();
          },title:"Yes",height: 45.h,),

          SizedBox(
            height: 12.h,
          ),
          CustomButton(onTap: (){
            Navigator.of(context).pop();
          },title:"NO",height: 45.h,fillColor: AppColors.white,textColor: AppColors.primary,
            isBorder: true,borderWidth: 1,)
        ],
      ),
    );
  }
}
