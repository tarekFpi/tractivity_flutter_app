

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

    // Check if either startDate or endDate is empty or null
    if (startDate.isEmpty || endDate.isEmpty) {
      // If either date is empty, return the original list unfiltered
      change(missionEventShowList.value, status: RxStatus.success());
      return;
    }

    try {
      // Parse the start and end dates. Handle year-based filtering (e.g., "2024").
      DateTime start;
      DateTime end;

      // If only the year is provided, set the date to January 1st and December 31st of that year
      if (startDate.length == 4 && endDate.length == 4) {
        // For year-based filtering (e.g., "2024" to "2024")
        start = DateTime(int.parse(startDate), 1, 1); // Start of the year
        end = DateTime(int.parse(endDate), 12, 31, 23, 59, 59, 999); // End of the year
      } else {
        // Handle full date range (e.g., "2025-03-08" to "2025-03-09")
        start = DateTime.parse(startDate);
        end = DateTime.parse(endDate);
      }

      // Ensure the end date is after the start date
      if (end.isBefore(start)) {
        change([], status: RxStatus.error('End date cannot be before start date.'));
        return;
      }

      // Filter the list based on the date range
      final filteredList = missionEventShowList.value.where((element) {
        DateTime eventDate = DateTime.parse(element.date.toString());

        // Ensure the event date is within the range (inclusive of start and end dates)
        return !eventDate.isBefore(start) && eventDate.isBefore(end);
      }).toList();

      // Handle empty or valid filtered results
      if (filteredList.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(filteredList, status: RxStatus.success());
      }

      debugPrint("filteredList:${jsonEncode(filteredList)}, Start: ${start}, End: ${end}");

    } catch (e) {
      // Handle any errors related to date parsing or filtering
      debugPrint("Error: ${e.toString()}");
      change([], status: RxStatus.error('An error occurred while filtering events: ${e.toString()}'));
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