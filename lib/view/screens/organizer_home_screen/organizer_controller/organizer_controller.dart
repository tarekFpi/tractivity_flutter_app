import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/model_invited_mission/retriveInvitedMissionsResponse.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/retrieve_volunteer_mission_model/RetriVolunteerTomissionResponeModel.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/retrive_active_mission_model/RetriveActiveMissionResponeModel.dart';

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


  ///===================== Retrive invited missions by organizer ===============================
   RxList<RetriveInvitedMissionsResponse> retriveInvitedMissionsList = <RetriveInvitedMissionsResponse>[].obs;

  RxBool retriveInvitedMissionsLoading = false.obs;

  Future<void> retriveInvitedMissionsShow() async{

    retriveInvitedMissionsLoading.value = true;


    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retriveInvitedMissionOrganizer(userId: userId));

    if (response.statusCode == 200) {

      retriveInvitedMissionsList.value = List.from(response.body["data"].map((m)=> RetriveInvitedMissionsResponse.fromJson(m)));
      retriveInvitedMissionsLoading.value =false;

      debugPrint("retriveInvitedMissionsResponse:${retriveInvitedMissionsList.toJson()},,${retriveInvitedMissionsLoading.value}");

      refresh();

    } else {

      retriveInvitedMissionsLoading.value =false;
      refresh();
      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(AppStrings.checknetworkconnection);
        refresh();
        retriveInvitedMissionsLoading.value =false;
        return;
      } else {

        ApiChecker.checkApi(response);
        retriveInvitedMissionsLoading.value =false;
        refresh();
        return;
      }
    }
  }


  ///accept mission invitation for organizer
  RxBool acceptMissionsInvitationLoading = false.obs;

  Future<void> acceptMissionsInvitationShow(String invitationId) async{

    acceptMissionsInvitationLoading.value = true;

    var body = {
      "name": "",
    };

    var response = await ApiClient.patchData(ApiUrl.acceptmissionInvitation(invit_Id: invitationId),jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']!);

      acceptMissionsInvitationLoading.value =false;

      showJoinMissionDialog();
      refresh();
      retriveInvitedMissionsShow();

    } else {

      refresh();
      acceptMissionsInvitationLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(AppStrings.checknetworkconnection);
        refresh();
        acceptMissionsInvitationLoading.value =false;
        return;
      } else {

        ApiChecker.checkApi(response);
        acceptMissionsInvitationLoading.value =false;
        refresh();
        return;
      }
    }
  }


///Reject mission invitation for both
  RxBool rejectMissionsInvitationLoading = false.obs;

  Future<void> rejectMissionsInvitation(String invitationId) async{

    rejectMissionsInvitationLoading.value = true;

    var body = {
      "name": "",
    };

    var response = await ApiClient.patchData(ApiUrl.rejectMissionInvitation(invit_Id: invitationId),jsonEncode(body));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']!);

      rejectMissionsInvitationLoading.value =false;

      retriveInvitedMissionsShow();
      refresh();

    } else {

      refresh();
      rejectMissionsInvitationLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(AppStrings.checknetworkconnection);
        refresh();
        rejectMissionsInvitationLoading.value =false;
        return;
      } else {

        ApiChecker.checkApi(response);
        rejectMissionsInvitationLoading.value =false;
        refresh();
        return;
      }
    }
  }



  ///==================== Retrieve all Active missions by organizer ========================
  RxBool retrieveMissionsActiveLoading = false.obs;

  RxList<RetriveActiveMissionResponeModel> retriveActivieMissionsList = <RetriveActiveMissionResponeModel>[].obs;

  Future<void> retrieveMissionsActive() async{

    retrieveMissionsActiveLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retrieveMissionActivie(userId: userId));

    if (response.statusCode == 200) {

      retriveActivieMissionsList.value = List.from(response.body["data"].map((m)=> RetriveActiveMissionResponeModel.fromJson(m)));
      retrieveMissionsActiveLoading.value = false;
      refresh();

    } else {

      refresh();
      retrieveMissionsActiveLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(AppStrings.checknetworkconnection);
        refresh();
        retrieveMissionsActiveLoading.value =false;
        return;
      } else {

        ApiChecker.checkApi(response);
        retrieveMissionsActiveLoading.value =false;
        refresh();
        return;
      }
    }
  }


  ///==================== Retrieve all InActive missions by organizer ========================
  RxBool retrieveMissionsInactiveLoading = false.obs;

  RxList<RetriveActiveMissionResponeModel> retriveInactivieMissionsList = <RetriveActiveMissionResponeModel>[].obs;

  Future<void> retrieveMissionsInActive() async{

    retrieveMissionsInactiveLoading.value = true;

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.retrieveMissionInActivie(userId: userId));

    if (response.statusCode == 200) {

      retriveInactivieMissionsList.value = List.from(response.body["data"].map((m)=> RetriveActiveMissionResponeModel.fromJson(m)));
      retrieveMissionsInactiveLoading.value = false;
      refresh();

    } else {

      refresh();
      retrieveMissionsInactiveLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {
        Toast.errorToast(AppStrings.checknetworkconnection);
        refresh();
        retrieveMissionsInactiveLoading.value =false;
        return;
      } else {

        ApiChecker.checkApi(response);
        retrieveMissionsInactiveLoading.value =false;
        refresh();
        return;
      }
    }
  }


  ///===================== fetch Mission delete by uid =====================
  RxBool missionInactiveDeleteLoading = false.obs;

  Future<void> missionDelete(String mission_Id) async{

    missionInactiveDeleteLoading.value = true;

    var response = await ApiClient.deleteData(ApiUrl.deleteMission(mission_Id: mission_Id));

    if (response.statusCode == 200) {

      Toast.successToast(response.body['message']);

      missionInactiveDeleteLoading.value =false;

      retrieveMissionsInActive();

    } else {

      missionInactiveDeleteLoading.value =false;

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




  void showJoinMissionDialog() {
    if (Get.context != null) {
      showDialog(
        context: Get.context!,
        builder: (ctx) => LayoutBuilder(builder: (context,constraints){

          final isTablet = constraints.maxWidth > 600;

          return AlertDialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.all(8),
            contentPadding: EdgeInsets.all(8),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Mission Joined",
                  fontSize: 24,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  bottom: 8,
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close,
                    size: 32,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/join_mission.png',
                      height: isTablet ? 200.h : 170.h,
                      width: MediaQuery.of(Get.context!).size.width,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/check.png", width: 24.w, height: 24.h),
                        SizedBox(width: 8),
                        CustomText(
                          text: "Joined",
                          fontSize: isTablet ? 8.sp : 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          bottom: 8,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: "Thanks for joining the mission 🎉",
                      fontSize: isTablet ? 8.sp : 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      bottom: 8,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    }
  }


  ///===================== Retrieve  active to inactive missions by organizer =====================
  Rx<TextEditingController> missionEditNameController = TextEditingController().obs;

  Rx<TextEditingController> missionEditDescriptionController = TextEditingController().obs;

  RxBool updateActiveMissionLoading = false.obs;

  RxString missionStatus = "".obs;
  RxBool missionActiveStatus = false.obs;

  Future<void> editActiveMission(String missionId) async {

    updateActiveMissionLoading.value = true;

    if(missionActiveStatus.value==true){
      missionStatus.value="inactive";
    }

    var body = {
      "name": missionEditNameController.value.text,
      "description": missionEditDescriptionController.value.text,
      "status": missionStatus.value
    };

    debugPrint("editActiveMission:${jsonEncode(body)}");

  var response = await ApiClient.patchData(ApiUrl.editMission(editId: missionId), jsonEncode(body));

    if (response.statusCode == 200) {

      updateActiveMissionLoading.value = false;

      Toast.successToast(response.body['message']!);

      debugPrint("response:${body}");

      retrieveMissionsActive();

      retrieveMissionsInActive();

      missionEditNameController.value.clear();
      missionEditDescriptionController.value.clear();
      missionStatus.value="";

    } else {

      updateActiveMissionLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        return;

      } else {

        ApiChecker.checkApi(response);
        return;
      }
    }
  }

///


  //========= Image Picker GetX Controller Code ===========//

  final RxList<File> selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();

// Pick multiple images from the gallery
  Future<void> pickImagesFromGallery() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      selectedImages.addAll(images.map((image) => File(image.path)));
    }
  }


  ///===================== Retrieve  Inactive to active missions by organizer =====================
  RxBool updateInActiveMissionLoading = false.obs;

  RxString missionInStatus = "".obs;
  RxBool missionInActiveStatus = false.obs;

  Future<void> editInActiveMission(String missionId) async {

    updateInActiveMissionLoading.value = true;

    if(missionInActiveStatus.value==true){
      missionInStatus.value="active";
    }

    var body = {
      "name": missionEditNameController.value.text,
      "description": missionEditDescriptionController.value.text,
      "status": missionInStatus.value
    };

    debugPrint("editInActiveMission:${jsonEncode(body)}");

   var response = await ApiClient.patchData(ApiUrl.editMission(editId: missionId), jsonEncode(body));

    if (response.statusCode == 200) {

      updateInActiveMissionLoading.value = false;

      Toast.successToast(response.body['message']!);

      debugPrint("response:${body}");

       missionEditNameController.value.clear();
       missionEditDescriptionController.value.clear();
        missionInStatus.value="";

      retrieveMissionsInActive();
      retrieveMissionsActive();
    } else {

      updateInActiveMissionLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        return;

      } else {

        ApiChecker.checkApi(response);
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

     retriveInvitedMissionsShow();

    retrieveMissionsActive();

    retrieveMissionsInActive();
  }
}