

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_mission_event_model/SpecificIdEventsResponeModel.dart';


class MissionToReportController extends GetxController with StateMixin<List<SpecificIdEventsResponeModel>>{


  ///===== Retrive all events by missionId ========================

  RxList<SpecificIdEventsResponeModel> missionEventShowList = <SpecificIdEventsResponeModel>[].obs;
  
  Future<void> retriveAllEventByMissionShow(String missionId) async{

    change(null, status: RxStatus.loading());

  try{
    var response = await ApiClient.getData(ApiUrl.retriveAllEventByMissionId(missionId: missionId));

    if (response.statusCode == 200) {

      missionEventShowList.value = List.from(response.body["data"].map((m)=> SpecificIdEventsResponeModel.fromJson(m)));

      change(missionEventShowList.value, status: RxStatus.success());

      if(missionEventShowList.isEmpty){

        change(null, status: RxStatus.empty());
      }

      refresh();
      refresh();

      debugPrint("missionEventShowList:${missionEventShowList.value}");

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

    change(null, status: RxStatus.error(e.toString()));

  }
  }



  ///=====================   search MissionReport  =====================
  Future<void> searchMissionReport(String query) async{

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(missionEventShowList.value, status: RxStatus.success());

    }else{

      try{

        final filteredList = missionEventShowList.value
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



  ///=====================  search date filter MissionReport  =====================

  Future<void> filterDateToDateMissionReport(String startDate, String endDate) async {
    change(null, status: RxStatus.loading());

    if ((startDate == null || startDate.isEmpty) ||
        (endDate == null || endDate.isEmpty)) {
      // If either date is null or empty, return the original list unfiltered
      change(missionEventShowList.value, status: RxStatus.success());
    } else {
      try {
        // Parse the start and end dates
        DateTime start = DateTime.parse(startDate);
        DateTime end = DateTime.parse(endDate);

        // Ensure end date is after start date
        if (end.isBefore(start)) {
          // Handle invalid date range (e.g., show an error message)
          change([], status: RxStatus.error('End date cannot be before start date.'));
          return;
        }

        // Filter the list based on the date range
        final filteredList = missionEventShowList.value.where((element) {
          DateTime eventDate = DateTime.parse(element.date.toString());
          return eventDate.isAfter(start) && eventDate.isBefore(end);
        }).toList();

        if (filteredList.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(filteredList, status: RxStatus.success());
        }


      } catch (e) {
        debugPrint(e.toString());
        change([], status: RxStatus.error('An error occurred while filtering events.'));
      }
    }
  }

/// filtered date to
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

}