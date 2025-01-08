import 'package:get/get.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';

class ChatController extends GetxController {
  RxList<String> messageTabList = <String>[
    AppStrings.profile,
    AppStrings.profile,
    AppStrings.profile,
  ].obs;

  RxInt tabCurrentIndex = 0.obs;
}