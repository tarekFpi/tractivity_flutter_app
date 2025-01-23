
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_event_model/SpecificIdEventsResponeModel.dart';


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

  ///===================== get event List lat long get address =====================

  var addressList = <String>[].obs;

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


///===================== fetch  Organization by uid =====================

  RxList<OrganizationResponeModel> organizationShowList = <OrganizationResponeModel>[].obs;

  RxBool organizationShowLoading = false.obs;

  Future<void> organizationShow() async{


    organizationShowLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.fetchOrganization(userId: userId));


    if (response.statusCode == 200) {

      organizationShowList.value = List.from(response.body["data"].map((m)=> OrganizationResponeModel.fromJson(m)));

      debugPrint("organizationShowList:${organizationShowList.toJson()}");


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

    var response = await ApiClient.getData(ApiUrl.leaderShow);

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

  RxList<String> leaderIdList= <String>[].obs;

  RxBool selectedOranization = false.obs;

  RxBool selectedLeader = false.obs;

  Rx<TextEditingController> missionNameController = TextEditingController().obs;

  Rx<TextEditingController> missionDescriptionController = TextEditingController().obs;


  RxBool createMissionLoading = false.obs;

  Future<void> createMission() async {

    createMissionLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "creatorId": userId,
      "name": missionNameController.value.text,
      "description": missionDescriptionController.value.text,
      "connectedOrganizations": organizationIdList,
      "requestedOrganizers": leaderIdList
    };

    var response = await ApiClient.postData(ApiUrl.createMission, jsonEncode(body));

    if (response.statusCode == 201) {

      createMissionLoading.value = false;

      Toast.successToast(response.body['message']!);

      debugPrint("response:${body}");

      organizationNameController.value.clear();
      organizationDescriptionController.value.clear();
      organizationIdList.value.clear();
      leaderIdList.value.clear();

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
      leaderIdList.clear();
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

    }else{

      debugPrint("searchOragizationLoading:${query}");

      searchOragizationLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchOrganization(query: query));

      //organizationShowList.refresh();

      if (response.statusCode == 200) {

        organizationShowList.value = List.from(response.body["data"].map((m)=> OrganizationResponeModel.fromJson(m)));

        organizationShowList.refresh();

        searchOragizationLoading.value =false;
        refresh();

      } else {

        organizationShowList.refresh();
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

        leaderShowList.refresh();
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


  ///===================== fetch Mission by uid event show =====================

  RxList<EventsRetriveResponeModel> missionByEventShowList = <EventsRetriveResponeModel>[].obs;

  RxBool missionByEventShowLoading = false.obs;

  Future<void> missionByEventShow(String missionId) async{

    missionByEventShowLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.missionIDByEventList(missionId: missionId));

    if (response.statusCode == 200) {

      missionByEventShowList.value = List.from(response.body["data"].map((m)=> EventsRetriveResponeModel.fromJson(m)));

      debugPrint("missionByEventShowList:${organizationShowList.value}");


      missionByEventShowLoading.value =false;
      refresh();

    } else {

      missionByEventShowLoading.value =false;

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


  Future<void> downloadPdf(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/${url.split('/').last}";

      await Dio().download(url, filePath);
      ScaffoldMessenger.of(Get.context! ).showSnackBar(
        SnackBar(content: Text("Downloaded: ${filePath}")),
      );

      OpenFile.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text("Error downloading PDF")),
      );
    }
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/PDF_Download";
        directory = Directory(newPath);

        File saveFile = File(directory.path + "/$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(
            url,
            saveFile.path,
          );
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    organizationShow();

    leaderShow();

    missionListShow();
  }
}
