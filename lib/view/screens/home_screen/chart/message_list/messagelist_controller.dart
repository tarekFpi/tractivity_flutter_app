
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
import 'package:tractivity_app/view/screens/home_screen/chart/conversation_allmessage_model/ConversationRetriveResponseModel.dart';
import 'package:tractivity_app/view/screens/home_screen/chart/conversation_model/ConversationResponseModel.dart';
import 'package:tractivity_app/view/screens/home_screen/chart/message_list/conversationBySpecificUser_model/conversationBySpecificUserResponseModel.dart';


class MessagelistController extends GetxController with StateMixin<List<ConversationBySpecificUserResponseModel>>  {


  /// Retrive conversations by specific user list home page
  RxList<ConversationBySpecificUserResponseModel> conversationBySpecificUserShowList = <ConversationBySpecificUserResponseModel>[].obs;
  RxBool conversationBySpecificMessageLoading = false.obs;

  Future<void> conversationBySpecificUserShow() async{

    try{

      conversationBySpecificMessageLoading.value = true;

      change(null, status: RxStatus.loading());

      var userId = await SharePrefsHelper.getString(AppConstants.userId);

      var response = await ApiClient.getData(ApiUrl.conversationByspecificUser(userId: userId));

      if (response.statusCode == 200) {

        conversationBySpecificUserShowList.value = List.from(response.body["data"].map((m)=> ConversationBySpecificUserResponseModel.fromJson(m)));

        conversationBySpecificMessageLoading.value =false;

        change(conversationBySpecificUserShowList.value, status: RxStatus.success());

        if(conversationBySpecificUserShowList.isEmpty){

          change(null, status: RxStatus.empty());
          refresh();
        }

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
    }catch(e){

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }


  ///===================== search message list =====================
  Future<void> searchMessageList(String query) async{

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(conversationBySpecificUserShowList.value, status: RxStatus.success());

    }else{

      try{

        final filteredList = conversationBySpecificUserShowList.value
            .where((element) =>element.receiver!.name.toString().toLowerCase().contains(query.toLowerCase().trim())
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




  /// slider
  RxInt sliderChatCurrentIndex = 0.obs;


  ///Retrive all message by conversation single user group
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





  ///listen New all message by conversation
  listenNewMessage()async {
    debugPrint("Faction Socket===========>>>>>>>>>>>>");
    conversationAllMessageShowList.refresh();

    SocketApi.socket.on("newMessage", (dynamic value) async{
      debugPrint("message-receive Socket===========>>>>>>>>>>>>$value");

 /*     var newMessage = ConversationRetriveResponseModel.fromJson(value);

      var currentMessage=conversationAllMessageShowList;
      conversationAllMessageShowList.value = [newMessage, ...currentMessage];
      update();*/


     if (value is Map<String, dynamic>) {

        String conversationId = value["conversation"] ?? "Unknown ID";
        debugPrint("conversationId:${conversationId}");

        conversationAllMessageShow(conversationId);
      }

    });
  }



  /// in join to user to user group

  RxBool conversationUserLoading = false.obs;
  Rx<ConversationResponseModel> conversationtUserShowList = ConversationResponseModel().obs;

  Future<void> groupIntoSingleUser(String receiverName,String receiverId) async {

    conversationUserLoading.value = true;

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

    debugPrint("groupIntoSingleUser:${body}");

  /*  var response = await ApiClient.postData(ApiUrl.createConversation, body);

    if (response.statusCode == 200) {

      //  Toast.successToast(response.body['message']);

      conversationtUserShowList.value = ConversationResponseModel.fromJson(response.body["data"]);

      debugPrint("groupIntoSingleUser:${jsonEncode(conversationtUserShowList)}");

      refresh();
      conversationUserLoading.value = false;

      Get.toNamed(AppRoutes.singleMessageScreen);

    } else {

      conversationUserLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);

        return;
      } else {

        ApiChecker.checkApi(response);
        conversationUserLoading.value = false;
        refresh();
        return;
      }
    }*/
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

  // Remove image by index
  void removeImage(int index) {
    selectedImages.removeAt(index);
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


}
