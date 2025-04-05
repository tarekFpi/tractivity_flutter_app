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
import 'package:tractivity_app/view/screens/home_screen/completed_event_model/CompletedEventResponeModel.dart';


class DonationController extends GetxController  {


  Rx<TextEditingController> queryRunningCompleteEventController = TextEditingController().obs;

   ///Create new donation
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> fristNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> amountController = TextEditingController().obs;
  Rx<TextEditingController> cardNumberController = TextEditingController().obs;
  Rx<TextEditingController> expirationDateController = TextEditingController().obs;
  Rx<TextEditingController> securityCodeController = TextEditingController().obs;

  RxBool donationStatues = false.obs;

  RxString donationStatus ="".obs;
  RxBool donationLoading = false.obs;

  Future<void> donationCreate() async {

    donationLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = json.encode({
      "doner": {
        "donerId": userId,
        "name": fristNameController.value.text,
        "donerRole": "volunteer"
      },
      "email": emailController.value.text,
      "firstName": fristNameController.value.text,
      "lastName": lastNameController.value.text,
      "amount": {
        "value": amountController.value.text,
        "currency": "USD"
      },
      "source": {
        "type": "card",
        "number": cardNumberController.value.text,
        "transactionId": securityCodeController.value.text
      },
      "isUSBanks": true
    });


    var response = await ApiClient.postData(ApiUrl.createDonation, body);

    if (response.statusCode == 201) {

      Toast.successToast(response.body['message']);

      refresh();
      donationLoading.value = false;

      emailController.value.clear();
      fristNameController.value.clear();
      lastNameController.value.clear();
      amountController.value.clear();
      cardNumberController.value.clear();
      expirationDateController.value.clear();
      securityCodeController.value.clear();


    } else {

      donationLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);

        return;
      } else {

        ApiChecker.checkApi(response);
        donationLoading.value = false;
        refresh();
        return;
      }
    }
  }


  ///======================================>> get donation api <<================================
  var donationText="".obs;

  RxBool donationTextLoading = false.obs;

  Future<void> showDonationText() async{

    donationTextLoading.value=true;

    try{
      var response = await ApiClient.getData(ApiUrl.getDonationText);

      if (response.statusCode == 200) {

        donationText.value = response.body["data"]["text"];

      } else {

        donationTextLoading.value=false;
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

      donationTextLoading.value=false;
      Toast.errorToast(e.toString());
      debugPrint(e.toString());
    }
  }

/*
  ///Retrive all invitation event notification by volunteer
  RxString queryEvent = "".obs;

  RxBool runningCompleteEventLodding = false.obs;

  RxList<CompletedEventResponeModel> runningCompleteEventList = <CompletedEventResponeModel>[].obs;

  Future<void> runningCompleteEventShow() async{

    runningCompleteEventLodding.value=true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.runningCompleteEvent(userId: userId));

    try{
      if (response.statusCode == 200) {

        runningCompleteEventList.value = List.from(response.body["data"].map((m)=> CompletedEventResponeModel.fromJson(m)));


        if(runningCompleteEventList.isEmpty){


          refresh();
        }

        debugPrint("notificationInvitaionEventList:${runningCompleteEventList.value}");

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
*/



}