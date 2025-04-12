// ignore_for_file: prefer_const_constructors
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_icons/app_icons.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_image/custom_image.dart';
import 'package:tractivity_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
import 'package:tractivity_app/view/screens/home_screen/chart/message_list/messagelist_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';

class MassageListScreen extends StatefulWidget {
  const MassageListScreen({super.key});

  @override
  State<MassageListScreen> createState() => _MassageListScreenState();
}

class _MassageListScreenState extends State<MassageListScreen> {

  final homeController = Get.find<HomeController>();

  final messageListController =Get.put(MessagelistController());

  final queryEditingController = TextEditingController();

  String query = "";
  var userId="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async{

      userId = await SharePrefsHelper.getString(AppConstants.userId);

       messageListController.conversationBySpecificUserShow();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: AppStrings.messages),
      body: LayoutBuilder(builder: (context,constraints){

        final isTablet = constraints.maxWidth > 600;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: RefreshIndicator(child: ListView(
            children: [
              Obx(() {
                    return Column(
                      children: [

                        ///======== message list Search Bar ==============
                        CustomTextField(
                          textEditingController:queryEditingController,
                          fillColor: AppColors.neutral02,
                          //  hintText: AppStrings.search,
                          hintText: "Search for name...",
                          onChanged: (value){
                            setState(() {
                              query = value;
                            });
                            messageListController.searchMessageList(query);
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

                                messageListController.searchMessageList("");

                              }),

                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        messageListController.conversationBySpecificMessageLoading.value?
                        Center(child: CircularProgressIndicator(color: Colors.amber,)):
                        messageListController.conversationBySpecificUserShowList.isEmpty?
                        SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          child: Center(
                            child: CustomText(
                              text: "No conversations user yet!!",
                              fontSize:isTablet?12.sp: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightRed,
                            ),
                          ),
                        ):
                        messageListController.obx((state){

                          return ListView.builder(
                            itemCount: state?.length ?? 0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final model = state![index];

                              // Filter: Direct or Group where user is involved
                              bool showItem = false;

                              if (model.type == "direct") {
                                showItem = (model.sender?.senderId?.id != userId || model.receiver?.receiverId?.id != userId);
                              } else if (model.type == "group") {
                                showItem = (model.conversationMembers != null && model.conversationMembers!.contains(userId));
                              }

                              if (!showItem) return SizedBox.shrink();

                              return GestureDetector(
                                onTap: () {
                                  if (model.type == "group") {

                                    homeController.groupIntoEvent(model.sender?.name??"", model.id ??"");

                                  } else if (model.type == "direct") {

                                /*    String name = (model.sender?.senderId?.id == userId)
                                        ? model.receiver?.name ?? ""
                                        : model.sender?.name ?? "";
                                    String id = (model.sender?.senderId?.id == userId)
                                        ? model.receiver?.receiverId?.id ?? ""
                                        : model.sender?.senderId?.id ?? "";*/

                                    messageListController.groupIntoSingleUser(model.receiver?.name??"", model.receiver!.receiverId?.id.toString()??"");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          model.type == "group"
                                              ? Image.asset("assets/icons/group.png", width: 45, height: 45, color: Colors.black)
                                              : CustomNetworkImage(
                                            imageUrl: model.sender?.senderId?.id == userId
                                                ? "${ApiUrl.imageUrl}${model.receiver?.receiverId?.image ?? AppConstants.profileImage}"
                                                : "${ApiUrl.imageUrl}${model.sender?.senderId?.image ?? AppConstants.profileImage}",
                                            height: 50,
                                            width: 50,
                                            boxShape: BoxShape.circle,
                                          ),
                                          CustomText(
                                            text: model.sender?.senderId?.id == userId
                                                ? model.receiver?.name ?? ""
                                                : model.sender?.name ?? "",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            left: 10,
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                        text: DateConverter.timeFormetString(model.createdAt.toString()),
                                        fontSize: 12,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );



                         /* return ListView.builder(
                              itemCount: state?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context,index){

                                final model=state?[index];

                                if((model?.type=="direct") && (model?.sender?.senderId?.id!=userId || model?.receiver?.receiverId?.id!=userId)){

                                     return GestureDetector(
                                       onTap: (){

                                         if(model?.type=="direct"){

                                           messageListController.groupIntoSingleUser(model?.receiver?.name.toString()??"",model?.receiver?.receiverId?.id.toString()??"");
                                         }
                                       },
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [

                                             Row(
                                               children: [
                                                 model?.type=="group"?Image.asset("assets/icons/group.png",width: 45,height: 45,color: Colors.black,):
                                                 CustomNetworkImage(
                                                   //   imageUrl: AppConstants.profileImage,
                                                   imageUrl:model?.receiver?.receiverId?.image==""? AppConstants.profileImage:"${ApiUrl.imageUrl}${model?.receiver?.receiverId?.image}",
                                                   height: 50,
                                                   width: 50,
                                                   boxShape: BoxShape.circle,
                                                 ),
                                                 CustomText(
                                                   text: "${model?.receiver?.name}",
                                                   fontSize: 18,
                                                   fontWeight: FontWeight.w600,
                                                   left: 10,
                                                 ),
                                               ],
                                             ),
                                             CustomText(
                                               text: "${DateConverter.timeFormetString(model?.createdAt.toString())}",
                                               fontSize: 12,
                                               color: AppColors.primary,
                                               fontWeight: FontWeight.w600,
                                             )
                                           ],
                                         ),
                                       ),
                                     );

                                 }else {

                                  if ((model?.conversationMembers != null) && (model?.conversationMembers?.contains(userId)??true)){

                                   Toast.successToast("userId");
                                     return GestureDetector(
                                       onTap: (){

                                         if(model?.type=="group"){

                                           homeController.groupIntoEvent(model?.receiver?.name.toString()??"",model!.id.toString());
                                         }
                                       },
                                       child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [

                                             Row(
                                               children: [
                                                 model?.type=="group"?Image.asset("assets/icons/group.png",width: 45,height: 45,color: Colors.black,):
                                                 CustomNetworkImage(
                                                   //   imageUrl: AppConstants.profileImage,
                                                   imageUrl:model?.receiver?.receiverId?.image==""? AppConstants.profileImage:"${ApiUrl.imageUrl}${model?.receiver?.receiverId?.image}",
                                                   height: 50,
                                                   width: 50,
                                                   boxShape: BoxShape.circle,
                                                 ),
                                                 CustomText(
                                                   text: "${model?.receiver?.name}",
                                                   fontSize: 18,
                                                   fontWeight: FontWeight.w600,
                                                   left: 10,
                                                 ),
                                               ],
                                             ),
                                             CustomText(
                                               text: "${DateConverter.timeFormetString(model?.createdAt.toString())}",
                                               fontSize: 12,
                                               color: AppColors.primary,
                                               fontWeight: FontWeight.w600,
                                             )
                                           ],
                                         ),
                                       ),
                                     );

                                   }
                                 }


                              });*/
                        })


                      ],
                    );
                  }
              )
            ],
          ), onRefresh: ()async{
            await  messageListController.conversationBySpecificUserShow();
          })
        );
      }),
      bottomNavigationBar: NavBar(currentIndex: 2),
    );
  }
}
