
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/alert_dialog_event.dart';
import 'package:tractivity_app/view/screens/notification/notification_alert.dart';

class EventCompleteScreen extends StatefulWidget {
  const EventCompleteScreen({super.key});

  @override
  State<EventCompleteScreen> createState() => _EventCompleteScreenState();
}

class _EventCompleteScreenState extends State<EventCompleteScreen> {

  @override
  Widget build(BuildContext context) {
       return LayoutBuilder(builder: (context,constraints){

         final isTablet = constraints.maxWidth > 600;

         return Scaffold(

           appBar:  AppBar(
             leading: Builder(builder: (context) {
               return IconButton(
                   onPressed: () => Get.back(),
                   icon: Icon(
                     Icons.arrow_back_rounded,
                     color: AppColors.black,
                     size: isTablet?42:24,
                   ));
             }),
             title: Text(
               "Completed Event",
               style: TextStyle(
                   color: AppColors.black,
                   fontSize: 22.sp,
                   fontWeight: FontWeight.w600),
             ),

           ),
           body: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 15.0),
               child: Column(
                 children: [


                   const SizedBox(
                     height: 24,
                   ),

                   Column(
                       children: List.generate(3, (index) {

                         return  Padding(
                           padding: const EdgeInsets.only(bottom: 20.0),
                           child: Row(
                             children: [

                               CustomNetworkImage(
                                 imageUrl: AppConstants.eventImage,
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
                                       text: "Cox’s Bazar Beach Helping Peolple"!,
                                       maxLines: 3,
                                       fontSize: 14,
                                       fontWeight: FontWeight.w500,
                                       bottom: 5,
                                     ),
                                   ),
                                   /// Location
                                   const Row(
                                     children: [
                                       Icon(
                                         Icons.location_on,
                                         color: AppColors.black,
                                         size: 20,
                                       ),
                                       CustomText(
                                         text: "Cox’s Bazar, Bangladesh",
                                         fontSize: 12,
                                         color: AppColors.black_80,
                                         fontWeight: FontWeight.w400,
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
                                         text: "Mehedi",
                                         fontSize: 14,
                                         color: AppColors.black,
                                         fontWeight: FontWeight.w600,
                                         right: 10.w,
                                         left: 10.w,
                                       ),
                                       const CustomText(
                                         text: "Leader",
                                         fontSize: 14,
                                         color: AppColors.blue,
                                         fontWeight: FontWeight.w600,
                                       ),
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


                                           Get.toNamed(AppRoutes.adminstratorEventDetailsScreen);
                                         },
                                         child: Container(
                                           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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

                                       const SizedBox(
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
                                             text:  "Complete",
                                             fontSize: 14,
                                             fontWeight: FontWeight.w500,
                                             color: AppColors.black,
                                           ),
                                         ),
                                       ),
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
           ),
         );
       });
  }
}
