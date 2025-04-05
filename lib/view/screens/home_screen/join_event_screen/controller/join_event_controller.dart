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
import 'package:tractivity_app/view/screens/home_screen/notification_evnet_inviteModel/RetriveNotificationEventInviteResponeModel.dart';


class JoinEventController extends GetxController with StateMixin<List<RetriveNotificationEventInviteResponeModel>>  {


  Rx<TextEditingController> queryInviteEventController = TextEditingController().obs;

  ///Retrive all invitation event notification by volunteer
  RxString queryevent = "".obs;

  RxBool notificationInvitationEventLodding = false.obs;

  RxList<RetriveNotificationEventInviteResponeModel> notificationInvitaionEventList = <RetriveNotificationEventInviteResponeModel>[].obs;

  Future<void> notificationInvitationEventShow() async{

    notificationInvitationEventLodding.value=true;

    change(null, status: RxStatus.loading());

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.inviteVolunteerEvent(userId: userId));

    try{

      if (response.statusCode == 200) {

        notificationInvitaionEventList.value = List.from(response.body["data"].map((m)=> RetriveNotificationEventInviteResponeModel.fromJson(m)));

       change(notificationInvitaionEventList.value, status: RxStatus.success());

        if(notificationInvitaionEventList.isEmpty){

          change(null, status: RxStatus.empty());
          refresh();
        }

        debugPrint("notificationInvitaionEventList:${notificationInvitaionEventList.value}");

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



  ///===================== Reject event invitation by invitaionId =====================
  RxBool eventInvitationDeleteLoading = false.obs;

  Future<void> eventDelete(String invitationId) async{

    eventInvitationDeleteLoading.value = true;

    var response = await ApiClient.deleteData(ApiUrl.deleteEventInviation(invitationId: invitationId));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      eventInvitationDeleteLoading.value =false;

      notificationInvitationEventShow();

    } else {

      eventInvitationDeleteLoading.value =false;

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
  }

  ///===================== search notification Invitaion EventL ist volunteers =====================
  Future<void> searchNotificationInvitaionEventList(String query) async{

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(notificationInvitaionEventList.value, status: RxStatus.success());

    }else{


       try{

        final filteredList = notificationInvitaionEventList.value
            .where((element) =>element.contentId!.name!.toLowerCase().contains(query.toLowerCase().trim())
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