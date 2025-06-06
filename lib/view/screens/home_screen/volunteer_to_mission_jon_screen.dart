
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_loader/custom_loader.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/controller/administratior_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';



class VolunteerToMissionJonScreen extends StatefulWidget {
  const VolunteerToMissionJonScreen({super.key});

  @override
  State<VolunteerToMissionJonScreen> createState() => _VolunteerToMissionJonScreenState();
}

class _VolunteerToMissionJonScreenState extends State<VolunteerToMissionJonScreen> {

  String missionId="";

  final administratorController = Get.put(AdministratiorController());

  String inviationId="";

  final  homeController = Get.find<HomeController>();
  String userId="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initializeData();
  }

  void _initializeData() async {

    if(Get.arguments[0]["missionId"]!=null && Get.arguments[0]["inviationId"] != null){

      missionId = Get.arguments[0]["missionId"];

      inviationId = Get.arguments[0]["inviationId"];

      await administratorController.retriveSpecificMissionByMissionShow(missionId);
      await  administratorController.retriveAllEventByMissionShow(missionId);

    }

    userId = await SharePrefsHelper.getString(AppConstants.userId);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;


      return Scaffold(
        appBar:  AppBar(
          scrolledUnderElevation: 0,
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
            "Mission Details",
            style: TextStyle(
                color: AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600),
          ),

        ),
        body: Obx(() {

              var hours = administratorController.missionDetailsShowList.value.report?.hours;

              var mileage = administratorController.missionDetailsShowList.value.report?.mileage;
            ///  var joinedVolunteerList = administratorController.missionDetailsShowList.value?.connectedVolunteers;


              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Update observable after build completes
                homeController.isUserRequested.value = administratorController.missionDetailsShowList.value?.requestedVolunteers
                    ?.any((volunteer) => volunteer.id == userId) ?? false;
              });

              return RefreshIndicator(child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child:administratorController.missionDetailsShowList.toString().isEmpty?
                    SizedBox(
                      height: MediaQuery.of(context).size.height/2,
                      child: Center(
                        child: CustomText(
                          text: "No mission details yet!!",
                          fontSize:isTablet?12.sp: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightRed,
                        ),
                      ),
                    ):
                    administratorController.missionDetailsShowLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(
                          height: 24,
                        ),

                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Organizations :${ homeController.isUserRequested.value}",
                          fontSize:isTablet?6.sp: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          bottom: 5,
                        ),

                        ListView.builder(
                            itemCount: administratorController.missionDetailsShowList.value.connectedOrganizations?.length,
                            shrinkWrap: true, // ✅ Important: Makes ListView take only the space it needs
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final connectedOrganizations =administratorController.missionDetailsShowList.value.connectedOrganizations?[index];

                              return  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "${connectedOrganizations?.name}",
                                    fontSize:isTablet?6.sp: 16.sp,
                                    color: AppColors.black_80,
                                    fontWeight: FontWeight.w600,
                                    bottom: 6.h,
                                    textAlign: TextAlign.start,
                                  ),

                                  CustomText(
                                    text: "${connectedOrganizations?.description}",
                                    fontSize: 12,
                                    color: AppColors.black_02,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                    bottom: 4.h,// Add ellipsis at the end if the text overflows.
                                  ),
                                ],
                              );
                            }),

                        SizedBox(
                          height: 4.h,
                        ),
                        const Divider(
                          color: Colors.black54,
                          // height: 16.h,
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Mission",
                          fontSize:isTablet?6.sp: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          bottom: 5,
                        ),

                        CustomText(
                          text: "${administratorController.missionDetailsShowList.value.name}",
                          fontSize:isTablet?6.sp: 16.sp,
                          color: AppColors.black_80,
                          fontWeight: FontWeight.w600,
                          bottom: 6.h,
                        ),


                        CustomText(
                          text: "${administratorController.missionDetailsShowList.value.description}",
                          fontSize: 12,
                          color: AppColors.black_02,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          bottom: 8.h,// Add ellipsis at the end if the text overflows.
                        ),

                        const Divider(
                          color: Colors.black54,
                        ),

                        SizedBox(
                          height: 4.h,
                        ),

                        if((administratorController.missionDetailsShowList.value.connectedOrganizers?.isNotEmpty ??true)  && (administratorController.missionDetailsShowList.value.requestedOrganizers?.isNotEmpty ??true))
                          CustomText(
                            textAlign: TextAlign.start,
                            text: "Organizers",
                            fontSize:isTablet?6.sp: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                            bottom: 8.h,
                          ),

                        ///Organizers connectedOrganizers
                        ListView.builder(
                            itemCount: administratorController.missionDetailsShowList.value.connectedOrganizers?.length,
                            shrinkWrap: true, //
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final connectedOrganizers =administratorController.missionDetailsShowList.value.connectedOrganizers?[index];

                              return  Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  children: [

                                    connectedOrganizers?.image==""? CustomNetworkImage(
                                      imageUrl: AppConstants.profileImage,
                                      height:isTablet?64.h: 60.h,
                                      width:isTablet?64.w: 60.w,
                                      boxShape: BoxShape.circle,
                                    ):CustomNetworkImage(
                                      imageUrl: "${ApiUrl.imageUrl}${connectedOrganizers?.image}",
                                      height:isTablet?64.h: 60.h,
                                      width:isTablet?64.w: 60.w,
                                      boxShape: BoxShape.circle,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: "${connectedOrganizers?.fullName}",
                                                fontSize:isTablet?8.sp:12.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.black,
                                              ),
                                              CustomText(
                                                text: "${connectedOrganizers?.profession}",
                                                fontSize:isTablet?6.sp: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.black_80,
                                              ),
                                            ],
                                          ),

                                          administratorController.specificOrganizerDeleteLoading.value?CustomLoader():
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(10.r),
                                              // border: Border.all(color: AppColors.primary,width: 2),
                                            ),
                                            child:  GestureDetector(
                                              onTap: (){
                                                administratorController.removeSpecificOrganizer(connectedOrganizers!.id.toString(),missionId);

                                              },
                                              child:  Center(
                                                  child: CustomText(
                                                    text: "Remove",
                                                    color: AppColors.white,
                                                    fontSize:isTablet?6.sp: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),

                        SizedBox(
                          height: 4.h,
                        ),

                        ///Organizers requestedOrganizers
                        ListView.builder(
                            itemCount: administratorController.missionDetailsShowList.value.requestedOrganizers?.length,
                            shrinkWrap: true, //
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final requestedOrganizers =administratorController.missionDetailsShowList.value.requestedOrganizers?[index];

                              return  Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [

                                        requestedOrganizers?.image==""? CustomNetworkImage(
                                          imageUrl: AppConstants.profileImage,
                                          height:isTablet?64.h: 60.h,
                                          width:isTablet?64.w: 60.w,
                                          boxShape: BoxShape.circle,
                                        ):CustomNetworkImage(
                                          imageUrl: "${ApiUrl.imageUrl}${requestedOrganizers?.image}",
                                          height:isTablet?64.h: 60.h,
                                          width:isTablet?64.w: 60.w,
                                          boxShape: BoxShape.circle,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Row(
                                          children: [

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: "${requestedOrganizers?.fullName}",
                                                  fontSize:isTablet?8.sp:12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.black,
                                                ),
                                                CustomText(
                                                  text: "${requestedOrganizers?.profession}",
                                                  fontSize:isTablet?6.sp: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.black_80,
                                                ),
                                              ],
                                            ),

                                          ],),
                                      ],
                                    ),


                                    Row(

                                      children: [

                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: AppColors.black_04,
                                            borderRadius: BorderRadius.circular(10.r),
                                            // border: Border.all(color: AppColors.primary,width: 2),
                                          ),
                                          child: Center(
                                              child: CustomText(
                                                text: "Invited",
                                                color: AppColors.white,
                                                fontSize:isTablet?6.sp: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),

                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        administratorController.specificOrganizerDeleteLoading.value?CustomLoader():
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(10.r),
                                            // border: Border.all(color: AppColors.primary,width: 2),
                                          ),
                                          child:  GestureDetector(
                                            onTap: (){
                                              administratorController.removeSpecificOrganizer(requestedOrganizers!.id.toString(),missionId);

                                            },
                                            child:  Center(
                                                child: CustomText(
                                                  text: "Remove",
                                                  color: AppColors.white,
                                                  fontSize:isTablet?6.sp: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),

                        administratorController.missionDetailsShowList.value.connectedOrganizers==""?
                        const Divider(
                          color: Colors.black54,
                        ):const SizedBox(),

                        SizedBox(
                          height: 12.h,
                        ),

                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.neutral02,
                                borderRadius: BorderRadius.circular(10),
                              ),child: CustomText(text: "Hours: ${hours.round()} H",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                            ),

                            SizedBox(
                              width: 8.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.neutral02,
                                borderRadius: BorderRadius.circular(10),
                              ),child: CustomText(text: "Millage: ${mileage.round()} km",fontSize:isTablet?6: 12.sp,fontWeight: FontWeight.w600,),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 12.h,
                        ),

                        Row(
                          children: [
                            CustomText(
                              text:  "Mission mode:",
                              fontSize:isTablet?6.sp: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            CustomText(
                              text:  "${administratorController.missionDetailsShowList.value.mode}",
                              fontSize:isTablet?6.sp: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.cardBarClr,
                            )
                          ],
                        ),

                        SizedBox(
                          height: 4.h,
                        ),
                        const Divider(
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Events",
                          fontSize:isTablet?6.sp: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          bottom: 8.h,
                        ),

                        administratorController.missionEventShowList.value.isEmpty?
                        SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          child: Center(
                            child: CustomText(
                              text: "No Events yet!!",
                              fontSize:isTablet?12.sp: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightRed,
                            ),
                          ),
                        ):
                        administratorController.missionEventShowLoading.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                        ListView.builder(
                            itemCount: administratorController.missionEventShowList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {

                              final model = administratorController.missionEventShowList[index];

                              return  Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Row(
                                  children: [

                                    model.images?.isNotEmpty??true?
                                    CustomNetworkImage(
                                      /// imageUrl: AppConstants.eventImage,
                                      imageUrl:"${ApiUrl.imageUrl}${model.images?[0]}",
                                      height: isTablet ? 200.h : 170.h,
                                      width: isTablet ? 160.w : 160.w,
                                      borderRadius: BorderRadius.circular(10),
                                    ):Image.asset("assets/images/event_image.png",
                                      height: isTablet ? 200.h : 170.h,
                                      width: isTablet ? 160.w : 160.w,fit: BoxFit.fill,),

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
                                            fontSize:isTablet?8.sp: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            bottom: 5,
                                          ),
                                        ),
                                        /// Location
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: AppColors.black,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 150.w,
                                              child: CustomText(
                                                text: "${model.address?.state},${model.address?.city},${model.address?.zip}",
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
                                              fontSize:isTablet?6.sp: 10.sp,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis, // Show "..." for overflowing text
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              left: 4,
                                            ),

                                            CustomText(
                                              text: "Leader",
                                              fontSize:isTablet?6.sp: 10.sp,
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

                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  )
                ],
              ), onRefresh: ()async {
                await administratorController.retriveSpecificMissionByMissionShow(missionId);
                await  administratorController.retriveAllEventByMissionShow(missionId);

              });
            }
        ),

        bottomNavigationBar: Obx((){

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [

              ///for (int i = 0; i < (administratorController.missionDetailsShowList.value?.requestedVolunteers?.length ?? 0) ; i++)
                 ///if((administratorController.missionDetailsShowList.value.requestedVolunteers?[i].id==userId))


                if(homeController.isUserRequested.value)
                 Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12,bottom: 24),
                  child:  homeController.notificationInvitationMissionAcceptLodding.value?Center(child: CircularProgressIndicator(color: Colors.orange,)):
                  CustomButton (
                    onTap: ()  {
                       homeController.acceptSpecificMission(inviationId,false,missionId);

                         administratorController.retriveSpecificMissionByMissionShow(missionId);
                         administratorController.retriveAllEventByMissionShow(missionId);
                    },
                    title: "Join mission",
                    textColor: AppColors.white,
                    fillColor: AppColors.primary,
                    isBorder: true,
                    fontSize: 14,
                  ),
                ),

              ],
            );
          }
        ),
      );
    });
  }
}
