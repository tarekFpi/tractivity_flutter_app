
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
import 'package:tractivity_app/view/screens/home_screen/notification_evnet_inviteModel/RetriveNotificationEventInviteResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/notification_mission_inviteModel/notification_missionInviteModel.dart';
import 'package:tractivity_app/view/screens/home_screen/retrive_my_eventModel/RetriveMyEventResponeModel.dart';


class HomeController extends GetxController with StateMixin<List<OrganizationResponeModel>>  {

  RxInt home_currentIndex = 0.obs;

  RxList<String> nameList = [
    "My Events",
    "My Organization",
  ].obs;

  RxBool donationStatues = false.obs;

  RxBool isExpanded = false.obs;


  ///===== get all organizations except me as a volunteer ========================
  RxList<String> organizationIdList= <String>[].obs;

  RxBool selectedOranization = false.obs;

  RxList<OrganizationResponeModel> organizationShowList = <OrganizationResponeModel>[].obs;

  Future<void> organizationShow() async{

    change(null, status: RxStatus.loading());

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retriveOrganizationVolunteer(userId: userId));

    try{
      if (response.statusCode == 200) {

        organizationShowList.value = List.from(response.body["data"].map((m)=> OrganizationResponeModel.fromJson(m)));

        debugPrint("organizationShowList:${organizationShowList.value}");

        change(organizationShowList.value, status: RxStatus.success());

        refresh();

        if(organizationShowList.isEmpty){

          change(null, status: RxStatus.empty());
        }

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


  ///===== Join organization as volunteer ==========================
  RxBool joinOrganLoading = false.obs;
  Future<void> joinOrganizationVolunteer() async {

    joinOrganLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "volunteerId":userId,
      "organizations": organizationIdList
    };


   var response = await ApiClient.patchData(ApiUrl.joinOrganizationVolunteer, jsonEncode(body));

    if (response.statusCode == 200) {

      joinOrganLoading.value = false;

      Toast.successToast(response.body['message']!);

      organizationIdList.clear();

      selectedOranization.value=false;

      organizationShow();
    } else {

      joinOrganLoading.value = false;

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        return;

      } else {

        ApiChecker.checkApi(response);
        return;
      }
    }
  }


  ///===================== search Join organization OrganizationList =====================
  Future<void> searchOrganizationList(String query) async{

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(organizationShowList.value, status: RxStatus.success());

    }else{

      try{

        final filteredList = organizationShowList.value
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


  ///Retrive all invitation event notification by volunteer
  RxBool notificationInvitationEventLodding = false.obs;

  RxList<RetriveNotificationEventInviteResponeModel> notificationInvitaionEventList = <RetriveNotificationEventInviteResponeModel>[].obs;

  Future<void> notificationInvitationEventShow() async{

    notificationInvitationEventLodding.value=true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.inviteVolunteerEvent(userId: userId));

    try{
      if (response.statusCode == 200) {

        notificationInvitaionEventList.value = List.from(response.body["data"].map((m)=> RetriveNotificationEventInviteResponeModel.fromJson(m)));

        debugPrint("notificationInvitaionList:${organizationShowList.value}");

        notificationInvitationEventLodding.value=false;
        refresh();

      } else {

        notificationInvitationEventLodding.value=false;

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

    }
  }


  ///Retrive all invitation mission notification by volunteer
   RxBool notificationInvitationMissionLodding = false.obs;
  RxList<RetriveNotificationMissionInviteResponeModel> notificationInvitaionMissionList = <RetriveNotificationMissionInviteResponeModel>[].obs;

  Future<void> notificationInvitationMissionShow() async{

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.inviteVolunteerMission(userId: userId));

    try{
      if (response.statusCode == 200) {

        notificationInvitaionMissionList.value = List.from(response.body["data"].map((m)=> RetriveNotificationMissionInviteResponeModel.fromJson(m)));

        debugPrint("notificationInvitationMissionShow:${notificationInvitaionMissionList.value}");

        refresh();

      } else {

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

    }
  }



///Accept event invitation volunteer ============
  RxBool notificationInvitationEventAcceptLodding = false.obs;

  Future<void> acceptSpecificEvent(String invitationId,bool statue,String eventId) async{

    notificationInvitationEventAcceptLodding.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "invitationId": invitationId,
      "volunteerId": userId,
    };

    var response = await ApiClient.patchData(ApiUrl.acceptEventVolunteer,jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      notificationInvitationEventAcceptLodding.value =false;
      notificationInvitationEventShow();

        if(statue==true){

          Get.offNamed(AppRoutes.joinEventDetailsScreen,arguments: [
            {
              "eventId":eventId,
              "inviationId":invitationId
            }
          ]);

        }

      refresh();
    } else {

      notificationInvitationEventAcceptLodding.value =false;

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


  ///===================== Reject event invitation by invitaionId =====================
  RxBool eventInvitationDeleteLoading = false.obs;

  Future<void> organizationDelete(String eventId) async{

    eventInvitationDeleteLoading.value = true;

    var response = await ApiClient.deleteData(ApiUrl.deleteEventInviation(eventId: eventId));

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


  ///Start work
  RxBool startWorkEventLodding = false.obs;

  Future<void> startWorkEvent(String volunteerId,String eventId) async{

    startWorkEventLodding.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "eventId": eventId,
      "volunteerId": userId,
    };

    var response = await ApiClient.patchData(ApiUrl.startWorkEventVolunteer,jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      startWorkEventLodding.value =false;
      refresh();

    } else {

      startWorkEventLodding.value =false;

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

///End work event
  RxBool endWorkEventLodding = false.obs;

   RxDouble totalWorkedHour=0.0.obs;

  RxDouble mileage=0.0.obs;

  Rx<TextEditingController> totalWorkedHourController = TextEditingController().obs;

  Rx<TextEditingController> mileageController = TextEditingController().obs;

  Future<void> endWorkEvent(String volunteerId,String eventId) async{

    startWorkEventLodding.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "eventId": eventId,
      "volunteerId": userId,
    };

    var response = await ApiClient.patchData(ApiUrl.endWorkEventVolunteer,jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      totalWorkedHour.value =response.body["data"][0]["totalWorkedHour"];

      mileage.value = response.body["data"][0]["mileage"];

      totalWorkedHourController.value.text =totalWorkedHour.value.toString();

      mileageController.value.text =mileage.value.toString();

      startWorkEventLodding.value =false;
      refresh();

    } else {

      startWorkEventLodding.value =false;

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


  RxList<RetriveMyEventResponeModel> myEventShowList = <RetriveMyEventResponeModel>[].obs;

  RxBool startWorkEventStatues = false.obs;

  Future<void> myEventShow() async{

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retriveMyEventVolunteer(userId: userId));

    try{
      if (response.statusCode == 200) {

        myEventShowList.value = List.from(response.body["data"].map((m)=> RetriveMyEventResponeModel.fromJson(m)));

        debugPrint("myEventShowList:${jsonEncode(myEventShowList)}");

        for (int i = 0; i < myEventShowList.length; i++){

          for (int a = 0; i < myEventShowList[i].joinedVolunteer!.length; a++){

              if(myEventShowList[i].joinedVolunteer?[a].startInfo?.isStart==true && myEventShowList[i].joinedVolunteer?[a].volunteer==userId){

                startWorkEventStatues.value=true;
              }
          }
        }


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
  
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedOranization.value=false;
    //organizationIdList.clear();
  }
}