import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/model/UserProfileResponeModel.dart';

class EventsController extends GetxController{
  RxInt currentIndex = 0.obs;
  RxList<String> nameList = [
    AppStrings.events,
    AppStrings.profile,
  ].obs;
  RxList<String> joinEvenNameList = [
    AppStrings.inviteEvent,
    AppStrings.eventListText,
  ].obs;


  final List<String> friendList = [
   AppStrings.seeAllFriends,
   AppStrings.inviteFriends,
   AppStrings.request,
  ];

  ///===================== fetch  userProfile by uid =====================

  Rx<UserProfileResponeModel> userProfileShowList = UserProfileResponeModel().obs;

  RxBool userProfileShowLoading = false.obs;

  Future<void> userProfileShow() async{

    userProfileShowLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retriveUserProfile(userId: userId));


    if (response.statusCode == 200) {

      userProfileShowList.value =  UserProfileResponeModel.fromJson(response.body["data"]);

      debugPrint("userProfileShowList:${userProfileShowList.toJson()}");


      userProfileShowLoading.value =false;
      refresh();

    } else {

      userProfileShowLoading.value =false;

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userProfileShow();
  }
}