

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/helper/time_converter/time_converter.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/specific_mission_event_model/SpecificIdEventsResponeModel.dart';
import 'package:tractivity_app/view/screens/home_screen/completed_event_model/CompletedEventResponeModel.dart';


class VolunteerReportController extends GetxController with StateMixin<List<CompletedEventResponeModel>>{

  ///search date starting
  RxString selectedStartMonthValue="select month".obs;
  RxString selectedStartday="select day".obs;

  RxList<String> monthItems = [
    "select month",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
  ].obs;

  RxList<String> dayItems = [
    "select day",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
  ].obs;


  ///search end date ending
  RxString selectedEndingMonthValue="select month".obs;
  RxString selectedEnding_day="select day".obs;

  RxList<String> monthEndItems = [
    "select month",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
  ].obs;

  RxList<String> dayEndItems = [
    "select day",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
  ].obs;

  ///Retrieve Specific from date filter

  RxString formateDate="".obs;
  RxString formateToDate="".obs;

  Future<void> retriveSpecificFromDateEventReportShow(String fromDate) async{

    change(null, status: RxStatus.loading());

    try{

      var userId = await SharePrefsHelper.getString(AppConstants.userId);
      var response = await ApiClient.getData(ApiUrl.retriveSpecificFromDateEventByUserId(userId: userId,fromDate: fromDate));

      if (response.statusCode == 200) {

        eventShowList.value = List.from(response.body["data"].map((m)=> CompletedEventResponeModel.fromJson(m)));

        change(eventShowList.value, status: RxStatus.success());

        if(eventShowList.isEmpty){

          change(null, status: RxStatus.empty());
        }

        refresh();

        debugPrint("missionEventShowList:${eventShowList.value}");

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


  ///Retrieve Specific from date to date filter
  Future<void> retriveSpecificDateToDateEventReportShow(String fromDate,String toDate) async{

    change(null, status: RxStatus.loading());

    try{
      var userId = await SharePrefsHelper.getString(AppConstants.userId);
      var response = await ApiClient.getData(ApiUrl.retriveSpecificFromDateToDateEventUser(userId: userId,fromDate: fromDate,toDate: toDate));

      if (response.statusCode == 200) {

        eventShowList.value = List.from(response.body["data"].map((m)=> CompletedEventResponeModel.fromJson(m)));

        change(eventShowList.value, status: RxStatus.success());
        /// formateDate.value="";

        if(eventShowList.isEmpty){

          change(null, status: RxStatus.empty());
        }

        refresh();

        debugPrint("retriveSpecificDateToDateEventReportShow:${jsonEncode(eventShowList.value)}");

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

  ///===== Retrive all events by missionId ========================
  RxList<CompletedEventResponeModel> eventShowList = <CompletedEventResponeModel>[].obs;
  RxBool eventShowLoading = false.obs;

  Future<void> retriveAllEventShow() async{

    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    change(null, status: RxStatus.loading());
    eventShowLoading.value=true;
    try{
      var response = await ApiClient.getData(ApiUrl.retriveAllEventReport(userId: userId));

      if (response.statusCode == 200) {

        eventShowList.value = List.from(response.body["data"].map((m)=> CompletedEventResponeModel.fromJson(m)));

        change(eventShowList.value, status: RxStatus.success());

        if(eventShowList.isEmpty){

          change(null, status: RxStatus.empty());
        }
        eventShowLoading.value=false;
        refresh();


        debugPrint("missionEventShowList:${eventShowList.value}");

      } else {
        eventShowLoading.value=false;

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

      change(eventShowList.value, status: RxStatus.success());

    }else{

      try{

        final filteredList = eventShowList.value
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
      change(eventShowList.value, status: RxStatus.success());
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
      final filteredList = eventShowList.value.where((element) {
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
  Rx<TextEditingController> eventStartSelectedSearchDateController = TextEditingController().obs;
  Rx<TextEditingController> eventEndSelectedSearchDateController = TextEditingController().obs;

  Rx<TextEditingController> eventStartSearchDateController = TextEditingController().obs;

  Rx<TextEditingController> eventEndSearchDateController = TextEditingController().obs;

  int selectedYear = DateTime.now().year;

  Future<void> frompickYear() async {

    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(DateTime.now().year), // Set initial date to Jan 1 of the current year
      firstDate: DateTime(1900), // Set the range for year selection
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) => date.month == 1 && date.day == 1, // Only allow Jan 1st of the selected year
    );

    if (picked != null && picked != DateTime.now()) {

      selectedYear = picked.year; // Update the selected year

      eventStartSearchDateController.value.text = picked.year.toString(); // Update the selected year

    }

  }

  Future<void> topickYear() async {

    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(DateTime.now().year), // Set initial date to Jan 1 of the current year
      firstDate: DateTime(1900), // Set the range for year selection
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) => date.month == 1 && date.day == 1, // Only allow Jan 1st of the selected year
    );

    if (picked != null && picked != DateTime.now()) {

      eventEndSearchDateController.value.text = picked.year.toString(); // Update the selected year

    }

  }


  int? selectedMonth;
  int? selectedDay;
  Future<void> pickMonthDay() async {
    if (selectedYear == null) return;

    // Open the month and day picker after selecting the year
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(selectedYear!, 1, 1),
      firstDate: DateTime(selectedYear!, 1, 1),
      lastDate: DateTime(selectedYear!, 12, 31),
    );

    if (picked != null && picked != DateTime(selectedYear!, 1, 1)) {

      selectedMonth = picked.month;  // Set the selected month
      selectedDay = picked.day;  // Set the selected day

      Toast.successToast("selectedDay:${selectedMonth},,selectedDay:${selectedDay}");
    }
  }

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