
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';


class ExploreEventScreen extends StatefulWidget {
  const ExploreEventScreen({super.key});

  @override
  State<ExploreEventScreen> createState() => _ExploreEventScreenState();
}

class _ExploreEventScreenState extends State<ExploreEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(),
      body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [

             CustomNetworkImage(
               imageUrl: AppConstants.profileImage,
               height: 170.h,
               width: MediaQuery.of(context).size.width,
               borderRadius: BorderRadius.circular(10),
             ),

           ],
         ),
       ),
     ),
    );
  }
}


