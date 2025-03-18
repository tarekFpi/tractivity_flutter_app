import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/retrieve_volunteer_mission_model/RetriVolunteerTomissionResponeModel.dart';

class MissionToVolunteerController extends GetxController with StateMixin<List<RetriVolunteerTomissionResponeModel>>{


  ///===== Retrieve volunteers for sending invitation by mission Id ========================
  RxList<String> volunteersIdList= <String>[].obs;

  RxBool selectedVolunteers = false.obs;

  RxList<RetriVolunteerTomissionResponeModel> retriveVolunteersMissionsList = <RetriVolunteerTomissionResponeModel>[].obs;

  Future<void> retrieveVolunteersToMissionsInvite(String missionId) async{

    change(null, status: RxStatus.loading());

   try{

     var response = await ApiClient.getData(ApiUrl.retrieveVolunteerToMissionInvite(missionId: missionId));

     if (response.statusCode == 200) {

       retriveVolunteersMissionsList.value = List.from(response.body["data"].map((m)=> RetriVolunteerTomissionResponeModel.fromJson(m)));

       change(retriveVolunteersMissionsList.value, status: RxStatus.success());

       if(retriveVolunteersMissionsList.isEmpty){

         change(null, status: RxStatus.empty());
       }

       refresh();
       debugPrint("retrieveVolunteersMissionsInviteLoading:${retriveVolunteersMissionsList.value}");

     } else {

       refresh();

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



  ///===================== search invite volunteers =====================
  Future<void> searchVolunteersList(String query) async{

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(retriveVolunteersMissionsList.value, status: RxStatus.success());

    }else{

      try{

        final filteredList = retriveVolunteersMissionsList.value
            .where((element) =>element.fullName!.toLowerCase().contains(query.toLowerCase().trim())
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


///===================== Invite volunteers to a specific mission by mission Id====================

  RxBool voluteersLoading = false.obs;

  Future<void> inviteVolunteerToMission(String missionId) async {

    voluteersLoading.value = true;

    var body = {
      "volunteers": volunteersIdList
    };

    var response = await ApiClient.postData(ApiUrl.inviteVolunteerToMissionByMission(missionId: missionId), jsonEncode(body));

    if (response.statusCode == 200) {

      voluteersLoading.value = false;

      Toast.successToast(response.body['message']!);

      retrieveVolunteersToMissionsInvite(missionId);

      volunteersIdList.clear();

      selectedVolunteers.value=false;
      Get.back();
    } else {

      voluteersLoading.value = false;

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        return;

      } else {

        ApiChecker.checkApi(response);
        return;
      }
    }
  }

}