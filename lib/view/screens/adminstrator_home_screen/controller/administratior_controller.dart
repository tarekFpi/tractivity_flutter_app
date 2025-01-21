
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/leader_model/leaderResponeModel.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/organization_model/OrganizationResponeModel.dart';


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



  ///===================== fetch Organization by  uid =====================

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

    var userId= await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "creatorId": userId,
      "name": missionNameController.value.text,
      "description": missionDescriptionController.value.text,
      "connectedOrganizations": organizationIdList,
      "requestedOrganizers": leaderIdList
    };

    var response = await ApiClient.postData(ApiUrl.createOranizer, jsonEncode(body));

    if (response.statusCode == 201) {

      createMissionLoading.value = false;

      Toast.successToast(response.body['message']!);

      organizationNameController.value.clear();
      organizationDescriptionController.value.clear();

      organizationShow();

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


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    organizationShow();

    leaderShow();
  }
}
