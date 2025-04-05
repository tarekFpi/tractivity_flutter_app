
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/events_model/EventsRetriveResponeModel.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/leader_model/leaderResponeModel.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/mission_model/MissionRetriveResponeModel.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/organization_model/OrganizationResponeModel.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_mission_event_model/SpecificIdEventsResponeModel.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_organization_mission/retriveAllMissionByOrganizationResponse.dart';


class AdministratiorController extends GetxController {


  RxInt currentIndex = 0.obs;
  RxList<String> nameList = [
    AppStrings.recentEvents,
    AppStrings.completeEvent,
  ].obs;
  RxList<String> inviteMissionNameList = [
    AppStrings.inviteMission,
    AppStrings.eventList,
  ].obs;


  RxInt adminstratior_currentIndex = 0.obs;

  RxList<String> adminstratiorNameList = [
    "Organization List",
    "Mission List",
  ].obs;

  RxBool missionStatues = false.obs;

  ///===================== get event List lat long get address =====================
  var addressList = <String>[].obs;

  var getSingladdress = "Fetching address...".obs;

 ///var addressList = <String>{}.obs;

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {

      ///Get the list of placemarks for the provided latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      ///Check if placemarks list is not empty
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        ///Construct the address from the placemark
        String address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

        getSingladdress.value=address;

        addressList.add(address);
      //  debugPrint("address:${address}");

        return address;
      } else {
        return "No address found.";
      }
    } catch (e) {
      return "Failed to get address: $e";
    }
  }


  ///===================== create Organization =====================

  Rx<TextEditingController> organizationNameController =
      TextEditingController().obs;

  Rx<TextEditingController> organizationDescriptionController =
      TextEditingController().obs;

  RxBool createOrganLoading = false.obs;

  Future<void> createOrganization() async {

    createOrganLoading.value = true;

  var userId= await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "creatorId": userId,
      "name": organizationNameController.value.text,
      "description": organizationDescriptionController.value.text
    };

    var response = await ApiClient.postData(ApiUrl.createOranizer, jsonEncode(body));

    if (response.statusCode == 201) {

      createOrganLoading.value = false;

      Toast.successToast(response.body['message']!);

      organizationNameController.value.clear();
      organizationDescriptionController.value.clear();

      organizationShow();

    } else {

      createOrganLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        return;

      } else {

        ApiChecker.checkApi(response);
        return;
      }
    }
  }


  ///===================== edit Organization =====================
  Rx<TextEditingController> editOrganizationNameController =
      TextEditingController().obs;

  Rx<TextEditingController> editOrganizationDescriptionController =
      TextEditingController().obs;

  RxBool editOrganLoading = false.obs;

  Future<void> editOrganization(String organizationId) async {

    editOrganLoading.value = true;

    var body = {
      "name": editOrganizationNameController.value.text,
      "description": editOrganizationDescriptionController.value.text
    };

    var response = await ApiClient.patchData(ApiUrl.editOranizer(oranizerId: organizationId), jsonEncode(body));

    if (response.statusCode == 200) {

      editOrganLoading.value = false;

      Toast.successToast(response.body['message']!);

      editOrganizationNameController.value.clear();
      editOrganizationDescriptionController.value.clear();

      organizationShow();

    } else {

      editOrganLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        return;

      } else {

        ApiChecker.checkApi(response);
        return;
      }
    }
  }


///===================== fetch  Organization by uid =====================

  RxList<OrganizationResponeModel> organizationShowList = <OrganizationResponeModel>[].obs;

  RxBool organizationShowLoading = false.obs;

  Future<void> organizationShow() async{

    organizationShowLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.fetchOrganization(userId: userId));

    if (response.statusCode == 200) {

      organizationShowList.value = List.from(response.body["data"].map((m)=> OrganizationResponeModel.fromJson(m)));

      debugPrint("organizationShowList:${organizationShowList.value}");

      organizationShowLoading.value =false;
      refresh();

    } else {

      organizationShowLoading.value =false;

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




  ///===================== fetch Organization delete by  uid =====================
  RxBool organizationDeleteLoading = false.obs;

  Future<void> organizationDelete(String organization_Id) async{

    organizationDeleteLoading.value = true;

    var response = await ApiClient.deleteData(ApiUrl.deleteOrganization(organization_Id: organization_Id));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      organizationDeleteLoading.value =false;

      organizationShowList.refresh();
      organizationShow();


    } else {

      organizationDeleteLoading.value =false;

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


  ///===================== show leader List  =================
  RxList<LeaderResponeModel> leaderShowList = <LeaderResponeModel>[].obs;

  RxBool leaderShowLoading = false.obs;

  Future<void> leaderShow() async{

    leaderShowLoading.value = true;
    var body = {
      "organizations": organizationIdList,
    };

    var response = await ApiClient.postData(ApiUrl.leaderShow,jsonEncode(body));

    if (response.statusCode == 200) {

      leaderShowList.value = List.from(response.body["data"].map((m)=> LeaderResponeModel.fromJson(m)));

      debugPrint("leaderShowList:${leaderShowList.toJson()}");


      leaderShowLoading.value =false;
      refresh();

    } else {

      leaderShowLoading.value =false;

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



  ///===================== create Mission =================

  RxList<String> organizationIdList= <String>[].obs;

  RxBool isExpanded=false.obs;

  RxList<String> createLeaderIdList= <String>[].obs;

  RxBool selectedOranization = false.obs;

  RxBool selectedLeader = false.obs;

  Rx<TextEditingController> missionNameController = TextEditingController().obs;

  Rx<TextEditingController> missionDescriptionController = TextEditingController().obs;

  RxBool createMissionLoading = false.obs;

  RxString missionModeStatue="".obs;

  Future<void> createMission() async {

    createMissionLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

   ///private public
    if(missionStatues.value==false){

      missionModeStatue.value="private";

    }if(missionStatues.value==true){

      missionModeStatue.value="public";
    }

    var body = {
      "creatorId": userId,
      "name": missionNameController.value.text,
      "mode": missionModeStatue.value,
      "description": missionDescriptionController.value.text,
      "connectedOrganizations": organizationIdList,
      "requestedOrganizers": createLeaderIdList
    };

    debugPrint("mission_status:${jsonEncode(body)}");

     var response = await ApiClient.postData(ApiUrl.createMission, jsonEncode(body));

    if (response.statusCode == 201) {

      createMissionLoading.value = false;

      Toast.successToast(response.body['message']!);

      debugPrint("response:${body}");

      organizationNameController.value.clear();
      organizationDescriptionController.value.clear();
      organizationIdList.value.clear();
      createLeaderIdList.value.clear();

      missionListShow();

    } else {

      createMissionLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        return;

      } else {

        ApiChecker.checkApi(response);
        return;
      }
    }
  }



  ///===================== edit mission =====================
  Rx<TextEditingController> editMissionNameController = TextEditingController().obs;

  Rx<TextEditingController> editMissionDescriptionController = TextEditingController().obs;

  ///RxList<String> editOrganizationIdList= <String>[].obs;



  RxList<String> exitingLeaderIdList= <String>[].obs;

  RxList<String> presentLeaderIdList= <String>[].obs;

  RxList<String>removedOrganizers=<String>[].obs;

  RxList<String>newOrganizers=<String>[].obs;

  RxBool updateMissionLoading = false.obs;

  Future<void> editMission(String missionId) async {

    updateMissionLoading.value = true;

    ///Finding new and removed organizers
    newOrganizers.value = presentLeaderIdList.where((id)=> !exitingLeaderIdList.contains(id)).toList();

    removedOrganizers.value = exitingLeaderIdList.where((id)=> !presentLeaderIdList.contains(id)).toList();


    print("New Organizer: ${newOrganizers.value}");

    print("Removed Organizer: ${removedOrganizers.value}");

    ///private public
    if(missionStatues.value==false){

      missionModeStatue.value="private";

    }if(missionStatues.value==true){

      missionModeStatue.value="public";
    }


    var body = {
      "removedOrganizers": removedOrganizers,
      "newOrganizers": newOrganizers,
      "name": editMissionNameController.value.text,
      "description": editMissionDescriptionController.value.text,
      "mode": missionModeStatue.value,
      "status": "inactive"
    };

    debugPrint("missionEdit:${jsonEncode(body)}");

   var response = await ApiClient.patchData(ApiUrl.editMission(editId: missionId), jsonEncode(body));

    if (response.statusCode == 200) {

      updateMissionLoading.value = false;

      Toast.successToast(response.body['message']!);

      debugPrint("response:${body}");

      editMissionNameController.value.clear();
      editMissionDescriptionController.value.clear();

      exitingLeaderIdList.value.clear();
      newOrganizers.value.clear();
      removedOrganizers.value.clear();
      presentLeaderIdList.value.clear();

      missionListShow();

    } else {

      updateMissionLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        return;

      } else {

        ApiChecker.checkApi(response);
        return;
      }
    }
  }



  ///===================== fetch  Mission by uid =====================
  RxList<MissionRetriveResponeModel> missionShowList = <MissionRetriveResponeModel>[].obs;

  RxBool missionShowLoading = false.obs;

  Future<void> missionListShow() async{

    missionShowLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.showMission(userId: userId));


    if (response.statusCode == 200) {

      missionShowList.value = List.from(response.body["data"].map((m)=> MissionRetriveResponeModel.fromJson(m)));

      debugPrint("missionShowList:${missionShowList.toJson()}");

      missionNameController.value.clear();
      missionDescriptionController.value.clear();
      exitingLeaderIdList.clear();
      organizationIdList.clear();
      missionShowLoading.value =false;

      refresh();

    } else {

      missionShowLoading.value =false;

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



  ///===================== fetch Mission delete by uid =====================

  RxBool missionDeleteLoading = false.obs;

  Future<void> missionDelete(String mission_Id) async{

    missionDeleteLoading.value = true;

    var response = await ApiClient.deleteData(ApiUrl.deleteMission(mission_Id: mission_Id));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      missionDeleteLoading.value =false;

      missionShowList.refresh();
      missionListShow();

    } else {

      missionDeleteLoading.value =false;

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

  ///===================== search  organization  =====================

  RxBool searchOragizationLoading = false.obs;

  Future<void> searchOrganizationList(String query) async{

    if (query.isEmpty) {

      organizationShow();
      refresh();

    }else{

      debugPrint("searchOragizationLoading:${query}");

      searchOragizationLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchOrganization(query: query));

       organizationShowList.refresh();

      if (response.statusCode == 200) {

        organizationShowList.value = List.from(response.body["data"].map((m)=> OrganizationResponeModel.fromJson(m)));

        searchOragizationLoading.value =false;

        refresh();

      } else {

        searchOragizationLoading.value =false;

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
  }


  ///===================== search  leader  =====================
  RxBool searchLeaderLoading = false.obs;

  Future<void> searchLeaderList(String query) async{

    if (query.isEmpty) {

      leaderShow();

    }else{

      debugPrint("searchLeaderList:${query}");

      searchLeaderLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchLeader(query: query));

      ///organizationShowList.refresh();

      if (response.statusCode == 200) {

        leaderShowList.value = List.from(response.body["data"].map((m)=> LeaderResponeModel.fromJson(m)));

        leaderShowList.refresh();

        searchLeaderLoading.value =false;
        refresh();

      } else {

        searchLeaderLoading.value =false;

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
  }


  ///===================== Retrive specific mission by mission Id=====================
  Rx<RetriveSpecificMissionByMissionResponeModel> missionDetailsShowList = RetriveSpecificMissionByMissionResponeModel().obs;

  RxBool missionDetailsShowLoading = false.obs;
  Future<void> retriveSpecificMissionByMissionShow(String missionId) async{

    missionDetailsShowLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.missionIdByMissionDetails(missionId: missionId));

    if (response.statusCode == 200) {

      missionDetailsShowList.value = RetriveSpecificMissionByMissionResponeModel.fromJson(response.body["data"]);

      missionDetailsShowLoading.value =false;
      refresh();

    } else {

      refresh();
      missionDetailsShowLoading.value =false;

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


  ///Retrieve all mission by specific organization

  RxList<RetriveAllMissionByOrganizationResponse> organizationMissionDetailsShow = <RetriveAllMissionByOrganizationResponse>[].obs;
  RxBool organizationMissionDetailsShowLoading = false.obs;

  Future<void> retriveAllMissionByOrganization(String organizationId) async{

    organizationMissionDetailsShowLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.organizationByMissionList(organizationId: organizationId));

    if (response.statusCode == 200) {

     ///organizationMissionDetailsShow.value = RetriveAllMissionByOrganizationResponse.fromJson(response.body["data"]);

      organizationMissionDetailsShow.value = List.from(response.body["data"].map((m)=> RetriveAllMissionByOrganizationResponse.fromJson(m)));

      organizationMissionDetailsShowLoading.value =false;
      refresh();

    } else {

      organizationMissionDetailsShowLoading.value =false;

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



  ///=================================================
  ///Retrive all events by missionId

  RxList<SpecificIdEventsResponeModel> missionEventShowList = <SpecificIdEventsResponeModel>[].obs;
  RxBool missionEventShowLoading = false.obs;

  Future<void> retriveAllEventByMissionShow(String missionId) async{

    missionEventShowLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.retriveAllEventByMissionId(missionId: missionId));

    if (response.statusCode == 200) {

      missionEventShowList.value = List.from(response.body["data"].map((m)=> SpecificIdEventsResponeModel.fromJson(m)));

      missionEventShowLoading.value =false;
      refresh();

    } else {

      missionEventShowLoading.value =false;

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


  ///Remove specific organizer from a mission

  RxBool specificOrganizerDeleteLoading = false.obs;

  Future<void> removeSpecificOrganizer(String organizerId,String missionId) async{

    specificOrganizerDeleteLoading.value = true;

    var body = {
      "organizerId": organizerId,
    };

    var response = await ApiClient.deleteData(ApiUrl.removeSpecificOrganizer(missionId: missionId),body: jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      specificOrganizerDeleteLoading.value =false;

      retriveSpecificMissionByMissionShow(missionId);
      missionDetailsShowList.refresh();

      refresh();
    } else {

      specificOrganizerDeleteLoading.value =false;

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



  ///===================== retrive Specific event by Id event show =====================
  RxInt sliderCurrentIndex = 0.obs;

  Rx<SpecificIdEventsResponeModel> retriveSpecificByEventShowList = SpecificIdEventsResponeModel().obs;

  RxBool retriveSpecificByEventShowLoading = false.obs;

  Future<void> retriveSpecificByEventShow(String eventId) async{

    retriveSpecificByEventShowLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.retriveBySpecificEventList(eventId: eventId));

    if (response.statusCode == 200) {

      retriveSpecificByEventShowList.value = SpecificIdEventsResponeModel.fromJson(response.body["data"]);

      debugPrint("retriveSpecificByEventShowList:${organizationShowList.value}");


      retriveSpecificByEventShowLoading.value =false;
      refresh();

    } else {

      retriveSpecificByEventShowLoading.value =false;

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





  ///===================== retrive Specific event by Id event download  =====================
  void startDownload(String url ,String fileName) async {

    String filePath = await downloadPDF(url, fileName);

    if (filePath.isNotEmpty) {
      await showDownloadNotification(filePath);
    }
  }

  Future<void> showDownloadNotification(String filePath) async {

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'pdf_download_channel',
      'PDF Downloads',
      channelDescription: 'Notifications for PDF downloads',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'Tap to open PDF',
      platformChannelSpecifics,
      payload: filePath,
    );
  }


  Future<String> downloadPDF(String url, String fileName) async {
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String filePath = '${tempDir.path}/$fileName';

      await Dio().download(url, filePath);

      return filePath;
    } catch (e) {
      print('Download error: $e');
      return '';
    }
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    organizationShow();

   // leaderShow();

    missionListShow();
  }
}
