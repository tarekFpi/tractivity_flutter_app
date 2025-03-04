
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
import 'package:tractivity_app/view/screens/adminstrator_home_screen/organization_model/OrganizationResponeModel.dart';


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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedOranization.value=false;
    //organizationIdList.clear();
  }
}