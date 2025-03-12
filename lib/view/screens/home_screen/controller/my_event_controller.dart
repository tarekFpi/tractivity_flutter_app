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
import 'package:tractivity_app/view/screens/home_screen/retrive_my_eventModel/RetriveMyEventResponeModel.dart';


class MyEventController extends GetxController with StateMixin<List<RetriveMyEventResponeModel>>  {

  RxBool selectedOranization = false.obs;

  RxList<RetriveMyEventResponeModel> myEventShowList = <RetriveMyEventResponeModel>[].obs;

  Future<void> myEventShow() async{

    change(null, status: RxStatus.loading());

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retriveMyEventVolunteer(userId: userId));

    try{
      if (response.statusCode == 200) {

        myEventShowList.value = List.from(response.body["data"].map((m)=> RetriveMyEventResponeModel.fromJson(m)));

        debugPrint("myEventShowList:${myEventShowList.value}");

        change(myEventShowList.value, status: RxStatus.success());

        refresh();

        if(myEventShowList.isEmpty){

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
}