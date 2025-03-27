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



  ///======================================>> get about-us api <<================================

  var about_usList="".obs;

  RxBool aboutUsLoading = false.obs;

  Future<void> showAboutUS() async{

    aboutUsLoading.value=true;

    try{
      var response = await ApiClient.getData(ApiUrl.aboutUS);

      if (response.statusCode == 200) {

        about_usList.value = response.body["data"]["description"];

        debugPrint("about_usList:${about_usList.value}");
        aboutUsLoading.value=false;
      } else {
        aboutUsLoading.value=false;

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

      aboutUsLoading.value=false;
      Toast.errorToast(e.toString());
      debugPrint(e.toString());
    }
  }

  ///Get terms and condition
  var terms_condition="".obs;

  RxBool terms_conditionLoading = false.obs;

  Future<void> showTermsCondition() async{

    terms_conditionLoading.value=true;

    try{
      var response = await ApiClient.getData(ApiUrl.termsCondition);

      if (response.statusCode == 200) {

        terms_condition.value = response.body["data"]["termsCondition"];

        debugPrint("privacy_policyList:${terms_condition.value}");
        terms_conditionLoading.value=false;

      } else {
        terms_conditionLoading.value=false;

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

      terms_conditionLoading.value=false;
      Toast.errorToast(e.toString());
      debugPrint(e.toString());
    }
  }


  ///======================================>> get privacy-policy api <<================================

  var privacy_policyList="".obs;

  RxBool privacy_policyLoading = false.obs;

  Future<void> showPrivacyPolicyList() async{

    privacy_policyLoading.value=true;

    try{
      var response = await ApiClient.getData(ApiUrl.privacyPolicy);

      if (response.statusCode == 200) {

        privacy_policyList.value = response.body["data"]["privacyPolicy"];

        debugPrint("privacy_policyList:${privacy_policyList.value}");

      } else {

        privacy_policyLoading.value=false;
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

      privacy_policyLoading.value=false;
      Toast.errorToast(e.toString());
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userProfileShow();
  }
}