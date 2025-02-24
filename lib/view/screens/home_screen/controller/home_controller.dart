
import 'package:get/get.dart';


class HomeController extends GetxController{

  RxInt home_currentIndex = 0.obs;

  RxList<String> nameList = [
    "My Events",
    "My Organization",
  ].obs;

  RxBool donationStatues = false.obs;

  RxBool isExpanded = false.obs;


}