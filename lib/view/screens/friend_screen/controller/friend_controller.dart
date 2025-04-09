
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
import 'package:tractivity_app/view/screens/friend_screen/request_friends_model/RequestFriendsResponeModel.dart';
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



//bool isPagination = false
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
  RxBool searchMyFriendsLoading = false.obs;
  Rx<TextEditingController> eventSelectedSearchDateController = TextEditingController().obs;

  Future<void> searchInviteFriends(String query) async{

    if (query.isEmpty) {

      inviteFriendsFetchList();
      refresh();

    }else{

      debugPrint("InviteFriendsResponeModel:${query}");

      var userId = await SharePrefsHelper.getString(AppConstants.userId);

      inviteFriendsShowListLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchInviteFriends(query: query,userId: userId));

      inviteFriendsShowList.refresh();

      if (response.statusCode == 200) {

        inviteFriendsShowList.value = List.from(response.body["data"].map((m)=> InviteFriendsResponeModel.fromJson(m)));

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



   ///===================== Retrive all requested friendships =====================

  RxList<RequestFriendsResponeModel> requestFriendsShowList = <RequestFriendsResponeModel>[].obs;

  RxBool requestFriendsShowListLoading = false.obs;

  Future<void> requestFriendsFetchList() async{

    requestFriendsShowListLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.requestedFriendsList(userId: userId));

    if (response.statusCode == 200) {

      requestFriendsShowList.value = List.from(response.body["data"].map((m)=> RequestFriendsResponeModel.fromJson(m)));
      debugPrint("requestFriendsShowList:${userProfileShowList.toJson()}");


      requestFriendsShowListLoading.value =false;
      refresh();

    } else {

      requestFriendsShowListLoading.value =false;

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


  ///===================== Retrive all requested friendship search =====================

  RxBool searchRequestedLoading = false.obs;
  Rx<TextEditingController> requestSearchDateController = TextEditingController().obs;

  Future<void> searchRequestedFriends(String query) async{

    if (query.isEmpty) {

      requestFriendsFetchList();
      refresh();

    }else{

      debugPrint("searchRequestedFriends:${query}");

      var userId = await SharePrefsHelper.getString(AppConstants.userId);

      searchRequestedLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchRequestFriends(query: query,userId: userId));

      requestFriendsShowList.refresh();

      if (response.statusCode == 200) {

        requestFriendsShowList.value = List.from(response.body["data"].map((m)=> RequestFriendsResponeModel.fromJson(m)));

        searchRequestedLoading.value =false;

        refresh();

      } else {

        searchRequestedLoading.value =false;

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


  ///Accept friendship by friendshipId
  RxBool acceptFriendsLoading = false.obs;
  Future<void> acceptFriendsRequest(String friendsId) async{

    acceptFriendsLoading.value = true;

    var body = {
      "removedOrganizers":"",
    };

    var response = await ApiClient.patchData(ApiUrl.acceptRequestFriends(friendshipId: friendsId), jsonEncode(body),);

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      acceptFriendsLoading.value =false;

      requestFriendsFetchList();

    } else {

      acceptFriendsLoading.value =false;

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


  ///Retrive all friends by userId
  RxList<RequestFriendsResponeModel> myFriendsShowList = <RequestFriendsResponeModel>[].obs;

  RxBool myFriendsShowListLoading = false.obs;

  Future<void> myFriendsFetchList() async{

    myFriendsShowListLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retriveFriendsAllFriends(userId: userId));

    if (response.statusCode == 200) {

      myFriendsShowList.value = List.from(response.body["data"].map((m)=> RequestFriendsResponeModel.fromJson(m)));
      debugPrint("myFriendsShowList:${myFriendsShowList.toJson()}");


      myFriendsShowListLoading.value =false;
      refresh();

    } else {

      myFriendsShowListLoading.value =false;

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

  /// Retrive all friendsList by search

  RxBool searchMyFriendLoading = false.obs;
  Rx<TextEditingController> myFriendsSearchDateController = TextEditingController().obs;

  Future<void> searchMyFriendFriends(String query) async{

    if (query.isEmpty) {

      myFriendsFetchList();
      refresh();

    }else{

      debugPrint("searchMyFriendFriends:${query}");

      var userId = await SharePrefsHelper.getString(AppConstants.userId);

      searchMyFriendLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchMyFriends(query: query,userId: userId));

      myFriendsShowList.refresh();

      if (response.statusCode == 200) {

        myFriendsShowList.value = List.from(response.body["data"].map((m)=> RequestFriendsResponeModel.fromJson(m)));

        searchMyFriendLoading.value =false;

        refresh();

      } else {

        searchMyFriendLoading.value =false;

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


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

     inviteFriendsFetchList();
     requestFriendsFetchList();
    // myFriendsFetchList();
  }

}