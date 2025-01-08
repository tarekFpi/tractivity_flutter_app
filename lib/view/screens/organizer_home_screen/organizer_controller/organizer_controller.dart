import 'package:get/get.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';

class OrganizerController extends GetxController{
  RxInt currentIndex = 0.obs;
  RxList<String> nameList = [
    AppStrings.recentEvents,
    AppStrings.completeEvent,
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



}