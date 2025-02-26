import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/model_completed/CompleteEeventResponeModel.dart';

class OrganizerController extends GetxController{

  RxInt currentIndex = 0.obs;

  RxList<String> nameList = [
    "Invited Mission",
    "Mission List",
  ].obs;

  RxList<String> inviteMissionNameList = [
    AppStrings.inviteMission,
    AppStrings.eventList,
  ].obs;


  RxInt adminstratior_currentIndex = 0.obs;

  RxList<String> adminstratiorNameList = [
    "Organization List",
   "Mission List",
  ].obs;




  RxBool missionActiveInactiveStatus = false.obs;

  RxBool missionMarkasActiveStatus = false.obs;


  RxString formattedEndDate="".obs;

  RxString formattedStartDate="".obs;

  Rx<TextEditingController> eventStartSearchDateController = TextEditingController().obs;

  Rx<TextEditingController> eventEndSearchDateController = TextEditingController().obs;

  void eventSartSearchDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(2007, 12, 31), // Latest selectable date
      firstDate: DateTime(2000), // Earliest selectable date
      lastDate: DateTime(2100),  // Needed for future filtering

    );

    if (pickedDate != null) {
      formattedStartDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      eventStartSearchDateController.value.text  = formattedStartDate.value;
    } else {
      formattedStartDate.value = "Date not selected";
    }
  }

  void eventEndSearchDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(2007, 12, 31), // Latest selectable date
      firstDate: DateTime(2000), // Earliest selectable date
      lastDate: DateTime(2100),  // Needed for future filtering

    );

    if (pickedDate != null) {
      formattedEndDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      eventEndSearchDateController.value.text  = formattedEndDate.value;
    } else {
      formattedEndDate.value = "Date not selected";
    }
  }


  ///===================== fetch  completed event show by uid ===============================

   RxList<CompleteEeventResponeModel> completeEventShowList = <CompleteEeventResponeModel>[].obs;

  RxBool completeEventShowLoading = false.obs;

  Future<void> completedEventListShow() async{

    completeEventShowLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retriveCompleleteProfile(userId: userId));


    if (response.statusCode == 200) {

      completeEventShowList.value = List.from(response.body["data"].map((m)=> CompleteEeventResponeModel.fromJson(m)));

      debugPrint("completeEventShowList:${completeEventShowList.value}");


      completeEventShowLoading.value =false;

      refresh();

    } else {

      completeEventShowLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(AppStrings.checknetworkconnection);
        refresh();
        completeEventShowLoading.value =false;
        return;
      } else {

        ApiChecker.checkApi(response);
        completeEventShowLoading.value =false;
        refresh();
        return;
      }
    }
  }


  ///===================== fetch  Running event show by uid ===============================

  RxList<CompleteEeventResponeModel> runningEventShowList = <CompleteEeventResponeModel>[].obs;

  RxBool runningEventShowLoading = false.obs;

  Future<void> runningEventListShow() async{

    runningEventShowLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retriveRunningProfile(userId: userId));


    if (response.statusCode == 200) {

      runningEventShowList.value = List.from(response.body["data"].map((m)=> CompleteEeventResponeModel.fromJson(m)));

      debugPrint("runningEventShowLoading:${runningEventShowList.value}");


      runningEventShowLoading.value =false;

      refresh();

    } else {

      runningEventShowLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(AppStrings.checknetworkconnection);
        refresh();
        runningEventShowLoading.value =false;
        return;
      } else {

        ApiChecker.checkApi(response);
        runningEventShowLoading.value =false;
        refresh();
        return;
      }
    }
  }


  ///===================== get event List lat long get address =====================

  var addressList = <String>[].obs;

  var getSingladdress = "Fetching address...".obs;

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {

      ///Get the list of placemarks for the provided latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      ///Check if placemarks list is not empty
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        ///Construct the address from the placemark
        String address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

        getSingladdress.value=address;

        addressList.add(address);
        //  debugPrint("address:${address}");

        return address;
      } else {
        return "No address found.";
      }
    } catch (e) {
      return "Failed to get address: $e";
    }
  }


  ///===================== running event List lat long get address =====================

  var addressRunningList = <String>[].obs;

  Future<String> getRunningAddressFromLatLng(double latitude, double longitude) async {
    try {

      ///Get the list of placemarks for the provided latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      ///Check if placemarks list is not empty
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        ///Construct the address from the placemark
        String address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

        addressRunningList.add(address);


        return address;
      } else {
        return "No address found.";
      }
    } catch (e) {
      return "Failed to get address: $e";
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    completedEventListShow();

    runningEventListShow();

  }
}