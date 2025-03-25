import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/organization_model/OrganizationResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/completed_event_model/CompletedEventResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/my_organization_model/MyOrganizationResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/notification_evnet_inviteModel/RetriveNotificationEventInviteResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/notification_mission_inviteModel/notification_missionInviteModel.dart';


class RunningCompleteController extends GetxController with StateMixin<List<CompletedEventResponeModel>>  {


  Rx<TextEditingController> queryRunningCompleteEventController = TextEditingController().obs;

  ///Retrive all invitation event notification by volunteer
  RxString queryEvent = "".obs;

  RxBool runningCompleteEventLodding = false.obs;

  RxList<CompletedEventResponeModel> runningCompleteEventList = <CompletedEventResponeModel>[].obs;

  Future<void> runningCompleteEventShow() async{

    runningCompleteEventLodding.value=true;

    change(null, status: RxStatus.loading());

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.runningCompleteEvent(userId: userId));

    try{
      if (response.statusCode == 200) {

        runningCompleteEventList.value = List.from(response.body["data"].map((m)=> CompletedEventResponeModel.fromJson(m)));

        change(runningCompleteEventList.value, status: RxStatus.success());

        if(runningCompleteEventList.isEmpty){

          change(null, status: RxStatus.empty());
          refresh();
        }

        debugPrint("notificationInvitaionEventList:${runningCompleteEventList.value}");

        refresh();

      } else {

        change(null, status: RxStatus.empty());

        if (response.statusText == ApiClient.somethingWentWrong) {
          Toast.errorToast(AppStrings.checknetworkconnection);
          refresh();
          return;
        } else {

          ApiChecker.checkApi(response);

          refresh();
          return;
        }
      }
    }catch(e){
      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }




  ///===================== search notification Invitaion EventL ist volunteers =====================
  Future<void> searchEventList(String query) async{

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(runningCompleteEventList.value, status: RxStatus.success());

    }else{


      try{

        final filteredList = runningCompleteEventList.value
            .where((element) =>element.name!.toLowerCase().contains(query.toLowerCase().trim())
        ).toList();

        if(filteredList.isEmpty){

          change([], status: RxStatus.empty());


        }else {
          change(filteredList, status: RxStatus.success());
        }

      }catch(e){

        debugPrint(e.toString());
      }

    }
  }

}