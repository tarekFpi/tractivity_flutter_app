
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
import 'package:tractivity_app/view/screens/friend_screen/model/InviteFriendsResponeModel.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/model/UserProfileResponeModel.dart';

class FriendController extends GetxController{

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

  ///===================== Retrive organic users by specific user =====================

  RxList<InviteFriendsResponeModel> inviteFriendsShowList = <InviteFriendsResponeModel>[].obs;

  RxBool inviteFriendsShowListLoading = false.obs;

  Future<void> inviteFriendsFetchList() async{

    inviteFriendsShowListLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.inviteFriendsList(userId: userId));

    if (response.statusCode == 200) {

      inviteFriendsShowList.value = List.from(response.body["data"].map((m)=> InviteFriendsResponeModel.fromJson(m)));
      debugPrint("userProfileShowList:${userProfileShowList.toJson()}");


      inviteFriendsShowListLoading.value =false;
      refresh();

    } else {

      inviteFriendsShowListLoading.value =false;

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

  /// organic users by specific user invite friends search
  RxBool searchInviteLoading = false.obs;
  Rx<TextEditingController> eventSelectedSearchDateController = TextEditingController().obs;

  Future<void> searchInviteFriends(String query) async{

    if (query.isEmpty) {

      inviteFriendsFetchList();
      refresh();

    }else{

      debugPrint("InviteFriendsResponeModel:${query}");

      var userId = await SharePrefsHelper.getString(AppConstants.userId);

      searchInviteLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchInviteFriends(query: query,userId: userId));

      inviteFriendsShowList.refresh();

      if (response.statusCode == 200) {

        inviteFriendsShowList.value = List.from(response.body["data"].map((m)=> InviteFriendsResponeModel.fromJson(m)));

        searchInviteLoading.value =false;

        refresh();

      } else {

        searchInviteLoading.value =false;

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

/// organic users by specific Invite friend
  RxBool inviteFriendsLoading = false.obs;

  Future<void> inviteFriendsSend(String inviteId,String responderName) async{

    inviteFriendsLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);
    var userName = await SharePrefsHelper.getString(AppConstants.fullName);

    var body = json.encode({
      "requester": {
        "requesterId": userId,
        "name": userName
      },
      "responder": {
        "responderId": inviteId,
        "name": responderName
      }
    });

    var response = await ApiClient.postData(ApiUrl.inviteFriend, body);

    if (response.statusCode == 201) {

      Toast.successToast(response.body['message']);

      inviteFriendsLoading.value =false;

      inviteFriendsFetchList();

    } else {

      inviteFriendsLoading.value =false;

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



/*  ///===================== Retrive organic users by specific user =====================
  RxList<InviteFriendsResponeModel> inviteFriendsShowList = <InviteFriendsResponeModel>[].obs;

  RxBool inviteFriendsShowListLoading = false.obs;

  Future<void> inviteFriendsFetchList() async{

    inviteFriendsShowListLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.inviteFriendsList(userId: userId));

    if (response.statusCode == 200) {

      inviteFriendsShowList.value = List.from(response.body["data"].map((m)=> InviteFriendsResponeModel.fromJson(m)));
      debugPrint("userProfileShowList:${userProfileShowList.toJson()}");


      inviteFriendsShowListLoading.value =false;
      refresh();

    } else {

      inviteFriendsShowListLoading.value =false;

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
  }*/
}