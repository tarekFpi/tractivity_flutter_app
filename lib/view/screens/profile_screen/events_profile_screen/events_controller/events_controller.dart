import 'package:get/get.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';

class EventsController extends GetxController{
  RxInt currentIndex = 0.obs;
  RxList<String> nameList = [
    AppStrings.events,
    AppStrings.profile,

  ].obs;


  final List<String> friendList = [
   AppStrings.seeAllFriends,
   AppStrings.inviteFriends,
   AppStrings.request,
  ];
}