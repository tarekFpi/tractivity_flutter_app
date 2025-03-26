// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_button/custom_button.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/my_event_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/my_organization_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/homepage_drawer.dart';
import 'package:tractivity_app/view/screens/profile_screen/user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final  homeController = Get.find<HomeController>();

  final   myEventController = Get.put(MyEventController());

  final   myOrganizationController = Get.put(MyOrganizationController());

  final storage = GetStorage();

  String query = "";

  final queryEditingController = TextEditingController();

  final queryOrganizationEditingController = TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    storage.write("status", "volunteer");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      myEventController.myEventShow();

      myOrganizationController.myOrganizationShow();
    });
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){

      final isTablet = constraints.maxWidth > 600;

      return Scaffold(
        key: _scaffoldKey,
        drawer: HomeSideDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu, color: AppColors.primary,size: isTablet?28.w:24.w
                  ,),
              );
            },
          ),
          title: Text(
            AppStrings.serveOut,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [

            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.notificationScreen);
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child:SvgPicture.asset(
                  AppIcons.event_notification,
                  semanticsLabel: 'My SVG Image',
                  height:  isTablet?42.h:32.h,
                  width:  isTablet?42.w:32.w,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 12),
          child: Obx(() {

            return RefreshIndicator(child:
            ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: isTablet ? 20 : 12),

                    /// Profile Section
                    UserProfileScreen(),


                    SizedBox(height: isTablet ? 20 : 12),

                    ///Event Banner
                    Container(
                      width: double.infinity,
                      height: isTablet ? 150 : 100,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Completed Events',
                                    style: TextStyle(fontSize: isTablet ? 28 : 24, fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                        text: '',
                                        style: TextStyle(fontSize: isTablet ? 28 : 24, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    CustomButton(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.exoloreEventCompletedScreen);
                                      },
                                      title: "Explore",
                                      width: isTablet ? 170 : 90,
                                      height: isTablet ? 60 : 32,
                                      fontSize: isTablet ? 16 : 14,
                                      textColor: AppColors.black,
                                      fillColor: AppColors.white,
                                      isBorder: true,
                                      borderWidth: .6,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              AppIcons.icon1,
                              height: isTablet ? 120 : 100,
                              width: isTablet ? 90 : 70,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: isTablet ? 20 : 12),

                    ///Recent Events Tab Bar
                    CustomTabSingleText(
                      fontSize: isTablet?24:16,
                      tabs: homeController.nameList,
                      selectedIndex: homeController.home_currentIndex.value,
                      onTabSelected: (value) {
                        homeController.home_currentIndex.value = value;
                        ///setState(() {});
                      },
                      selectedColor: AppColors.primary,
                      unselectedColor: AppColors.grey_1,
                    ),

                    SizedBox(height: isTablet ? 20 : 8),

                    /// my Events List
                    if(homeController.home_currentIndex.value ==0)
                      Column(
                        children: [

                          SizedBox(
                            height: 8.h,
                          ),

                          ///============ search my event ======================================
                          CustomTextField(
                            textEditingController:queryEditingController,
                            fillColor: AppColors.neutral02,
                            //  hintText: AppStrings.search,
                            hintText: "Search for event name...",
                            onChanged: (value){
                              setState(() {
                                query = value;
                              });
                              myEventController.searchMyEventVolunteersList(query);
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

                                  myEventController.searchMyEventVolunteersList("");

                                }),
                             ),

                          SizedBox(
                            height: 12.h,
                          ),
                          myEventController.myEventShowList.isEmpty?
                          SizedBox(
                            height: MediaQuery.of(context).size.height/4,
                            child: Center(
                              child: CustomText(
                                text: "No event yet!!",
                                fontSize:isTablet?12.sp: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.lightRed,
                              ),
                            ),
                          ):
                          myEventController.obx((state){

                            return ListView.builder(
                                itemCount: state?.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {

                                  final model = state?[index];

                                  return  Padding(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      children: [

                                        model?.images?.isNotEmpty??true?
                                        CustomNetworkImage(
                                          /// imageUrl: AppConstants.eventImage,
                                          imageUrl:"${ApiUrl.imageUrl}${model?.images?[0]}",
                                          height: isTablet ? 200.h : 170.h,
                                          width: isTablet ? 160.w : 160.w,
                                          borderRadius: BorderRadius.circular(10),
                                        ):Image.asset("assets/images/event_image.png",
                                          height: isTablet ? 200.h : 170.h,
                                          width: isTablet ? 180.w : 180.w,fit: BoxFit.fill,),

                                        const SizedBox(
                                          width: 10,
                                        ),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            CustomText(
                                              textAlign: TextAlign.start,
                                              text: "${model?.name}",
                                              maxLines: 3,
                                              fontSize:isTablet?8.sp: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              bottom: 5,
                                              overflow: TextOverflow.ellipsis,
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
                                                    text: "${model?.address?.state},${model?.address?.city},${model?.address?.zip}",
                                                    ///  text: "${administratorController.getAddressFromLatLng(model.cords?.lat??0.0,model.cords?.lng??0.0)}",
                                                    fontSize: 9,
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
                                                SizedBox(
                                                  child: CustomText(
                                                    text: "${model?.creator?.name}",
                                                    fontSize:isTablet?6.sp: 9.sp,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w600,
                                                    overflow: TextOverflow.ellipsis, // Show "..." for overflowing text
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    left: 4,
                                                  ),
                                                ),

                                                CustomText(
                                                  text: "Leader",
                                                  fontSize:isTablet?6.sp: 9.sp,
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

                                                    Get.toNamed(AppRoutes.recentEventExploreDetails,arguments: [
                                                      {
                                                        "eventId":model?.id
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
                                });

                          })

                        ],
                      ),


                    if (homeController.home_currentIndex.value == 1)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          SizedBox(
                            height: 8.h,
                          ),

                          ///============ search my Organization ======================================
                          CustomTextField(
                            textEditingController:queryOrganizationEditingController,
                            fillColor: AppColors.neutral02,
                            //  hintText: AppStrings.search,
                            hintText: "Search for Organization name...",
                            onChanged: (value){

                              myOrganizationController.queryOrganization.value = value;

                              myOrganizationController.searchMyOrganizationVolunteersList(myOrganizationController.queryOrganization.value);
                            },

                             suffixIcon: myOrganizationController.queryOrganization.value .isBlank == true || myOrganizationController.queryOrganization.value .isEmpty
                                ? Icon(
                              FluentIcons.search_24_regular,
                              size: 24,
                            )
                                : IconButton(
                                icon: Icon(Icons.close,size: 24,),
                                onPressed: () {
                                  myOrganizationController.queryOrganization.value  = "";
                                  queryOrganizationEditingController.clear();
                                  FocusScope.of(context).unfocus();

                                  myOrganizationController.searchMyOrganizationVolunteersList("");

                                }),

                          ),

                          SizedBox(
                            height: 12.h,
                          ),

                          myOrganizationController.myOrganizationList.isEmpty?
                          SizedBox(
                            height: MediaQuery.of(context).size.height/4,
                            child: Center(
                              child: CustomText(
                                text: "No my organization yet!!",
                                fontSize:isTablet?12.sp: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.lightRed,
                              ),
                            ),
                          ):
                          myOrganizationController.obx((state){

                            return ListView.builder(
                                itemCount:state?.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context,index){

                                  final model = state?[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.neutral02,
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: "${model?.name}",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  bottom: 8.h,
                                                ),
                                                CustomText(
                                                  text:
                                                  "${model?.description}",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  maxLines: 5,
                                                  textAlign: TextAlign.start,
                                                  bottom: 10.h,
                                                ),
                                                Row(
                                                  children: [
                                                    CustomNetworkImage(
                                                      imageUrl: AppConstants.profileImage,
                                                      height: 40.h,
                                                      width: 40.w,
                                                      boxShape: BoxShape.circle,
                                                    ),
                                                    CustomText(
                                                      text: "${model?.creator?.name}",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      left: 8.h,
                                                    ),
                                                    Expanded(
                                                      child: CustomText(
                                                        text: "(Adminstrator)",
                                                        fontSize: 12,
                                                        color: AppColors.blue,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [

                                              /*   CustomText(
                                         text: "17-12-2024",
                                         fontSize: 10,
                                         fontWeight: FontWeight.w400,
                                         bottom: 8.h,
                                       ),*/

                                              CustomButton(
                                                onTap: () {
                                                  ///OrganizerApprovedScreen
                                                  Get.toNamed(AppRoutes.organizeDetailsScreen,
                                                      arguments: [
                                                        {
                                                          "organizationId":model?.id,
                                                          "organizationShowList":model,
                                                        }
                                                      ]);
                                                },
                                                title: "Details",
                                                height:isTablet?40.h: 30.h,
                                                width:isTablet?70.w: 70.w,
                                                fontSize: 12,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          })

                        ],
                      ),

                    SizedBox(height: isTablet ? 30 : 20),
                  ],
                )
              ],
            ), onRefresh: ()async {
              await  myEventController.myEventShow();
              await  myOrganizationController.myOrganizationShow();

            });
          },
          ),
        ),
        bottomNavigationBar: NavBar(currentIndex: 0),
      );
    });
  }
}

