import 'package:get/get.dart';
import 'package:tractivity_app/view/components/custom_Controller/custom_controller.dart';
import 'package:tractivity_app/view/screens/chat_screen/chat_controller/chat_controller.dart';
import 'package:tractivity_app/view/screens/home_screen/controller/home_controller.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_controller/organizer_controller.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_controller/events_controller.dart';
class DependencyInjection extends Bindings {

  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => EventsController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => CustomController(), fenix: true);
    Get.lazyPut(() => OrganizerController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);



  }
}
