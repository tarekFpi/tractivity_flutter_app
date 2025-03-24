
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/SocketApi.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/organization_model/OrganizationResponeModel.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_mission_event_model/SpecificIdEventsResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/chart/conversationBySpecificUser_model/conversationBySpecificUserResponseModel.dart';
import 'package:tractivity_app/view/screens/home_screen/chart/conversation_allmessage_model/ConversationRetriveResponseModel.dart';
import 'package:tractivity_app/view/screens/home_screen/chart/conversation_model/ConversationResponseModel.dart';
import 'package:tractivity_app/view/screens/home_screen/completed_event_model/CompletedEventResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/notification_evnet_inviteModel/RetriveNotificationEventInviteResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/notification_mission_inviteModel/notification_missionInviteModel.dart';



class HomeController extends GetxController with StateMixin<List<OrganizationResponeModel>>  {

  RxInt home_currentIndex = 0.obs;

  RxList<String> nameList = [
    "My Events",
    "My Organization",
  ].obs;

  RxBool donationStatues = false.obs;

  RxBool isExpanded = false.obs;

  RxBool isUserRequested =false.obs;

  RxBool isEventDone =false.obs;
  RxBool isEventStartRequested =false.obs;
  RxBool isEventRunningRequested =false.obs;

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


  ///Retrive all invitation event notification by volunteer
  RxBool notificationInvitationEventLodding = false.obs;

  RxList<RetriveNotificationEventInviteResponeModel> notificationInvitaionEventList = <RetriveNotificationEventInviteResponeModel>[].obs;

  Future<void> notificationInvitationEventShow() async{

    notificationInvitationEventLodding.value=true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.inviteVolunteerEvent(userId: userId));

    try{
      if (response.statusCode == 200) {

        notificationInvitaionEventList.value = List.from(response.body["data"].map((m)=> RetriveNotificationEventInviteResponeModel.fromJson(m)));

        debugPrint("notificationInvitaionList:${organizationShowList.value}");

        notificationInvitationEventLodding.value=false;
        refresh();

      } else {

        notificationInvitationEventLodding.value=false;

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

    }
  }


  ///Retrive all invitation mission notification by volunteer
   RxBool notificationInvitationMissionLodding = false.obs;
  RxList<RetriveNotificationMissionInviteResponeModel> notificationInvitaionMissionList = <RetriveNotificationMissionInviteResponeModel>[].obs;

  Future<void> notificationInvitationMissionShow() async{

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.inviteVolunteerMission(userId: userId));

    try{
      if (response.statusCode == 200) {

        notificationInvitaionMissionList.value = List.from(response.body["data"].map((m)=> RetriveNotificationMissionInviteResponeModel.fromJson(m)));

        debugPrint("notificationInvitationMissionShow:${notificationInvitaionMissionList.value}");

        refresh();

      } else {

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

    }
  }



///Accept event invitation volunteer ============
  RxBool notificationInvitationEventAcceptLodding = false.obs;

  Future<void> acceptSpecificEvent(String invitationId,bool statue,String eventId,String eventName) async{

    notificationInvitationEventAcceptLodding.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "invitationId": invitationId,
      "volunteerId": userId,
    };

    var response = await ApiClient.patchData(ApiUrl.acceptEventVolunteer,jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      notificationInvitationEventAcceptLodding.value =false;
      notificationInvitationEventShow();

        if(statue==true){

          Get.offNamed(AppRoutes.joinEventDetailsScreen,arguments: [
            {
              "eventId":eventId,
              "inviationId":invitationId,
              "eventName":eventName,
            }
          ]);

        }

      refresh();
    } else {

      notificationInvitationEventAcceptLodding.value =false;

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


  ///Accept mission invitation by invitation Id ============
  RxBool notificationInvitationMissionAcceptLodding = false.obs;

  Future<void> acceptSpecificMission(String invitationId,bool statue,String missionId) async{

    notificationInvitationMissionAcceptLodding.value = true;

    var body = {
      "invitationId": invitationId,
      "missionId":missionId,
    };

    var response = await ApiClient.patchData(ApiUrl.acceptMissionVolunteer(missionId: invitationId),jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      notificationInvitationMissionAcceptLodding.value =false;
      notificationInvitationMissionShow();

      if(statue==true){

        Get.offNamed(AppRoutes.volunteerToMissionJonScreen,arguments: [
          {
            "missionId":missionId,
            "inviationId":invitationId
          }
        ]);

      }

      refresh();
    } else {

      notificationInvitationMissionAcceptLodding.value =false;

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


  ///===================== Reject event invitation by invitaionId =====================
  RxBool eventInvitationDeleteLoading = false.obs;

  Future<void> eventDelete(String invitationId) async{

    eventInvitationDeleteLoading.value = true;

    var response = await ApiClient.deleteData(ApiUrl.deleteEventInviation(invitationId: invitationId));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      eventInvitationDeleteLoading.value =false;

      notificationInvitationEventShow();

    } else {

      eventInvitationDeleteLoading.value =false;

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


  ///===================== Reject mission invitation by invitaionId =====================
  RxBool missionInvitationDeleteLoading = false.obs;
  Future<void> missionDelete(String invitationId) async{
    missionInvitationDeleteLoading.value = true;

    var body = {
      "eventId": "",
    };

    var response = await ApiClient.patchData(ApiUrl.deleteMissionInviation(invitationId: invitationId),jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      missionInvitationDeleteLoading.value =false;

      notificationInvitationMissionShow();

    } else {

      missionInvitationDeleteLoading.value =false;

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



  ///Start work
  RxBool startWorkEventLodding = false.obs;

  Future<void> startWorkEvent(String eventId) async{

    startWorkEventLodding.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "eventId": eventId,
      "volunteerId": userId,
    };

    var response = await ApiClient.patchData(ApiUrl.startWorkEventVolunteer,jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      startWorkEventLodding.value =false;
      refresh();
      retriveSpecificByEventShow(eventId);
    } else {

      debugPrint("jsonEncode:${jsonEncode(body)}");

      startWorkEventLodding.value =false;

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


///End work event
  RxBool endWorkEventLodding = false.obs;

   RxDouble totalWorkedHour=0.0.obs;

  RxDouble mileage=0.0.obs;

  Rx<TextEditingController> totalWorkedHourController = TextEditingController().obs;

  Rx<TextEditingController> mileageController = TextEditingController().obs;

  Future<void> endWorkEvent(String eventId) async{

    startWorkEventLodding.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "eventId": eventId,
      "volunteerId": userId,
    };

    var response = await ApiClient.patchData(ApiUrl.endWorkEventVolunteer,jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      totalWorkedHour.value = response.body["data"]["totalWorkedHour"];

      mileage.value = response.body["data"]["mileage"];

      totalWorkedHourController.value.text =totalWorkedHour.value.round().toString();

      mileageController.value.text =mileage.value.round().toString();

      startWorkEventLodding.value =false;
      refresh();
      retriveSpecificByEventShow(eventId);

      Get.back();
    } else {

      startWorkEventLodding.value =false;

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


  ///======Retrive events by specific volunteer =========

  RxList<CompletedEventResponeModel> completedEventShowList = <CompletedEventResponeModel>[].obs;
  RxBool completedEventShowLoading = false.obs;

  Future<void> retriveCompletedEventShow() async{

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    completedEventShowLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.retriveCompletedEventVolunteer(userId: userId));

    if (response.statusCode == 200) {

      completedEventShowList.value = List.from(response.body["data"].map((m)=> CompletedEventResponeModel.fromJson(m)));

      completedEventShowLoading.value =false;
      refresh();

    } else {

      completedEventShowLoading.value =false;

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


  /// select date
  RxString formattedStartDate="".obs;
  Rx<TextEditingController> eventSelectedSearchDateController = TextEditingController().obs;

  void eventSartSearchDate() async {

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      formattedStartDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      searchVolunteerDateEventList(formattedStartDate.toString());

    } else {
      formattedStartDate.value = "Date not selected";
    }
  }


/// Retrive complete events Date by specific volunteer search ====

  RxBool searchVolunteerLoading = false.obs;

  Future<void> searchVolunteerDateEventList(String query) async{

    if (query.isEmpty) {

      retriveCompletedEventShow();
      refresh();

    }else{

      debugPrint("completedEventShowList:${query}");

      var userId = await SharePrefsHelper.getString(AppConstants.userId);

      searchVolunteerLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchVolunteerEventSearch(query: query,userId: userId));

      completedEventShowList.refresh();

      if (response.statusCode == 200) {

        completedEventShowList.value = List.from(response.body["data"].map((m)=> CompletedEventResponeModel.fromJson(m)));

        searchVolunteerLoading.value =false;

        refresh();

      } else {

        searchVolunteerLoading.value =false;

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


  /// in join to event group
  RxInt sliderChatCurrentIndex = 0.obs;
  RxBool conversationLoading = false.obs;
  Rx<ConversationResponseModel> conversationtShowList = ConversationResponseModel().obs;

  Future<void> groupIntoEvent(String eventName,String eventId) async {

    conversationLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var fullName = await SharePrefsHelper.getString(AppConstants.fullName);

    var body = json.encode({
      "sender": {
        "name": "$fullName",
        "senderId": "$userId"
      },
      "receiver": {
        "name": "$eventName",
        "receiverId": "$eventId" // event id
      },
      "type": "group"
    });

    var response = await ApiClient.postData(ApiUrl.createConversation, body);

    if (response.statusCode == 200) {

      //Toast.successToast(response.body['message']);

      conversationtShowList.value = ConversationResponseModel.fromJson(response.body["data"]);

      debugPrint("conversationtShowList:${conversationtShowList.value}");

      refresh();
      conversationLoading.value = false;

      Get.toNamed(AppRoutes.volunteerChartScreen);

    } else {

      conversationLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);

        return;
      } else {

        ApiChecker.checkApi(response);
        conversationLoading.value = false;
        refresh();
        return;
      }
    }
  }



  /// in join to user to user group

  RxBool conversationUserLoading = false.obs;
  Rx<ConversationResponseModel> conversationtUserShowList = ConversationResponseModel().obs;

  Future<void> groupIntoSingleUser(String receiverName,String receiverId) async {

    conversationLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var fullName = await SharePrefsHelper.getString(AppConstants.fullName);

    var body = json.encode({
      "sender": {
        "name": "$fullName",
        "senderId": "$userId"
      },
      "receiver": {
        "name": "$receiverName",
        "receiverId": "$receiverId" // event id
      },
      "type": "direct"
    });

    var response = await ApiClient.postData(ApiUrl.createConversation, body);

    if (response.statusCode == 200) {

   //  Toast.successToast(response.body['message']);

     conversationtUserShowList.value = ConversationResponseModel.fromJson(response.body["data"]);

      debugPrint("groupIntoSingleUser:${conversationtUserShowList.value}");

      refresh();
      conversationLoading.value = false;

      Get.toNamed(AppRoutes.singleMessageScreen);

    } else {

      conversationLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);

        return;
      } else {

        ApiChecker.checkApi(response);
        conversationLoading.value = false;
        refresh();
        return;
      }
    }
  }




  /// Send message
  Rx<TextEditingController> messageController = TextEditingController().obs;

  RxBool sendLoading = false.obs;

  void sendChat(String conversationId)async{

    sendLoading.value=true;
    var body;
    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    if(selectedImages.isNotEmpty){
        body = {
        "conversation": "$conversationId",
        "sender": "$userId",
        "type": 'attachment',
        "content": messageController.value.text,
      };


        List<MultipartBody>? multipartBody = [];

        multipartBody.addAll(selectedImages.map((image)=>MultipartBody("attachment", image)).toList());

        debugPrint("multipartBody:${multipartBody}");

        var response = await ApiClient.postMultipartData(ApiUrl.send_message, body,
            multipartBody:multipartBody
        );

        if (response.statusCode == 201) {



          messageController.value.text="";
          refresh();
          sendLoading.value = false;
          selectedImages.clear();
        } else {

          sendLoading.value = false;
          if (response.statusText == ApiClient.somethingWentWrong) {

            Toast.errorToast(AppStrings.checknetworkconnection);

            return;
          } else {

            ApiChecker.checkApi(response);
            sendLoading.value = false;
            refresh();
            return;
          }
        }

    }else{

      body = {
        "conversation": "$conversationId",
        "sender": "$userId",
        "type": 'text',
        "content": messageController.value.text,
      };


      var response = await ApiClient.postData(ApiUrl.send_message, jsonEncode(body));


      if (response.statusCode == 201) {

        ///Toast.successToast(response.body['message']);

        messageController.value.text="";
        refresh();
        sendLoading.value = false;

      } else {

        sendLoading.value = false;
        if (response.statusText == ApiClient.somethingWentWrong) {

          Toast.errorToast(AppStrings.checknetworkconnection);

          return;
        } else {

          ApiChecker.checkApi(response);
          sendLoading.value = false;
          refresh();
          return;
        }
      }
    }

  }

  ///Retrive all message by conversation event group

  RxList<ConversationRetriveResponseModel> conversationAllMessageShowList = <ConversationRetriveResponseModel>[].obs;
  RxBool conversationAllMessageLoading = false.obs;

  Future<void> conversationAllMessageShow(String conversationId) async{

    conversationAllMessageLoading.value = true;

    var response = await ApiClient.getData(ApiUrl.conversationAllMessage(conversationId: conversationId));

    if (response.statusCode == 201) {

      conversationAllMessageShowList.value = List.from(response.body["data"].map((m)=> ConversationRetriveResponseModel.fromJson(m)));

      conversationAllMessageLoading.value =false;

      debugPrint("conversationAllMessageShowList:${jsonEncode(conversationAllMessageShowList)}");
      refresh();

    } else {

      conversationAllMessageLoading.value =false;

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



/// Retrive conversations by specific user
  RxList<ConversationBySpecificUserResponseModel> conversationBySpecificUserShowList = <ConversationBySpecificUserResponseModel>[].obs;
  RxBool conversationBySpecificMessageLoading = false.obs;

  Future<void> conversationBySpecificUserShow() async{

    conversationBySpecificMessageLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.conversationByspecificUser(userId: userId));

    if (response.statusCode == 200) {

      conversationBySpecificUserShowList.value = List.from(response.body["data"].map((m)=> ConversationBySpecificUserResponseModel.fromJson(m)));

      conversationBySpecificMessageLoading.value =false;

      debugPrint("conversationBySpecificUserShowList:${jsonEncode(conversationBySpecificUserShowList)}");
      refresh();

    } else {

      conversationBySpecificMessageLoading.value =false;

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




  ///listen New all message by conversation
  listenNewMessage()async {
    debugPrint("Faction Socket===========>>>>>>>>>>>>");
     conversationAllMessageShowList.refresh();

    SocketApi.socket.on("newMessage", (dynamic value) async{
      debugPrint("message-receive Socket===========>>>>>>>>>>>>$value");

      var newMessage = ConversationRetriveResponseModel.fromJson(value);

      var currentMessage=conversationAllMessageShowList;
      conversationAllMessageShowList.value = [newMessage, ...currentMessage];
      update();


   /*  if (value is Map<String, dynamic>) {

        String conversationId = value["conversation"] ?? "Unknown ID";
        debugPrint("conversationId:${conversationId}");

        conversationAllMessageShow(conversationId);
      }*/

    });
  }



  ///========= Image Picker GetX Controller Code ===========//

  RxList<File> selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();

  // Method to pick multiple images
  Future<void> pickImagesFromGallery() async {
    try {
      // Pick multiple images
      final pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles != null) {
        // Convert picked files to File objects and add them to the list
        selectedImages.value = pickedFiles.map((e) => File(e.path)).toList();
      } else {
        print('No images selected');
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }


  /// Retrive events Name by specific volunteer search ====
  RxBool searchVolunteerNameLoading = false.obs;
  Future<void> searchVolunteerNameEventList(String query) async{

    if (query.isEmpty) {

      retriveCompletedEventShow();
      refresh();

    }else{

      debugPrint("completedEventNameShowList:${query}");

      var userId = await SharePrefsHelper.getString(AppConstants.userId);

      searchVolunteerNameLoading.value = true;

      var response = await ApiClient.getData(ApiUrl.searchVolunteerEventNameSearch(query: query,userId: userId));

      completedEventShowList.refresh();

      if (response.statusCode == 200) {

        completedEventShowList.value = List.from(response.body["data"].map((m)=> CompletedEventResponeModel.fromJson(m)));

        searchVolunteerNameLoading.value =false;

        refresh();

      } else {

        searchVolunteerNameLoading.value =false;

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


  ///======Retrive My events by specific volunteer =========
  RxInt sliderCurrentIndex = 0.obs;

  ///===================== retrive Specific event by Id event download  =====================
  void startDownload(String url ,String fileName) async {

    String filePath = await downloadPDF(url, fileName);

    if (filePath.isNotEmpty) {
      await showDownloadNotification(filePath);
    }
  }

  Future<void> showDownloadNotification(String filePath) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'image_download_channel',
      'Image Downloads',
      channelDescription: 'Notifications for PDF downloads',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'Tap to open Image',
      platformChannelSpecifics,
      payload: filePath,
    );
  }



  Future<String> downloadPDF(String url, String fileName) async {
    try {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String filePath = '${tempDir.path}/$fileName';

      await Dio().download(url, filePath);

      return filePath;
    } catch (e) {
      print('Download error: $e');
      return '';
    }
  }



/// ===================== Download Image and Show Notification =====================
  void startImageDownload(String url, String fileName) async {
    String filePath = await downloadImage(url, fileName);

    if (filePath.isNotEmpty) {
      await showDownloadImageNotification(filePath);
    }
  }

  Future<String> downloadImage(String url, String fileName) async {
    try {
      // Get device-specific directory for storing images
      Directory dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/$fileName';

      // Download image using Dio
      await Dio().download(url, filePath);

      print('Image saved at: $filePath');
      return filePath;
    } catch (e) {
      print('Download error: $e');
      return '';
    }
  }

/// ===================== Download Image and Show Notification =====================

  Future<void> showDownloadImageNotification(String filePath) async {

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'image_download_channel',
      'Image Downloads',
      channelDescription: 'Notifications for Image downloads',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'Tap to open Image',
      platformChannelSpecifics,
      payload: filePath,
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedOranization.value=false;


  }
}