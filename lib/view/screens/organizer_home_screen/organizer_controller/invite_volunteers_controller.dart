
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/invite_volunteers_model/InviteVolunteerResponeModel.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/retrieve_volunteer_mission_model/RetriVolunteerTomissionResponeModel.dart';

class InviteVolunteersController extends GetxController with StateMixin<List<InviteVolunteerResponeModel>>{


  ///===== Retrieve volunteers for event sending invitation by mission Id ========================

  RxList<InviteVolunteerResponeModel> invitedVolunteersList = <InviteVolunteerResponeModel>[].obs;

  Future<void> inviteVolunteers(String missionId) async{

    change(null, status: RxStatus.loading());

    try{

      var response = await ApiClient.getData(ApiUrl.inviteVolunteer(missionId: missionId));

      if (response.statusCode == 200) {

        invitedVolunteersList.value = List.from(response.body["data"].map((m)=> InviteVolunteerResponeModel.fromJson(m)));

        change(invitedVolunteersList.value, status: RxStatus.success());

        if(invitedVolunteersList.isEmpty){

          change(null, status: RxStatus.empty());
        }

        refresh();
        debugPrint("retrieveVolunteersMissionsInviteLoading:${invitedVolunteersList.toJson()}");

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

      change(invitedVolunteersList.value, status: RxStatus.success());

    }else{

      try{

        final filteredList = invitedVolunteersList.value
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



}