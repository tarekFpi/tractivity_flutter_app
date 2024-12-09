// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:tractivity_app/view/screens/chat_screen/chat_screen.dart';
import 'package:tractivity_app/view/screens/chat_screen/inner_widget/message_screen.dart';
import 'package:tractivity_app/view/screens/chat_screen/massage_list_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/add_events_screen/add_events_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/all_member_screen/all_member_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/create_team_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/history_screeen/history_screeen.dart';
import 'package:tractivity_app/view/screens/friend_screen/friend_screen.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_profile_screen.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/setting_screen/about_us_screen.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/setting_screen/privacy_policy_screen.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/setting_screen/setting_screen.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/setting_screen/terms_condition_screen.dart';
import 'package:tractivity_app/view/screens/splash_screen/splash_screen.dart';

///=========================App Routes=========================
class AppRoutes {
  static const String splashScreen = "/SplashScreen";
  static const String homeScreen = "/HomeScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String loginScreen = "/LoginScreen";





  ////============ Mededi =================
  static const String eventsProfileScreen = "/EventsProfileScreen";
  static const String settingScreen = "/SettingScreen";
  static const String aboutUsScreen = "/AboutUsScreen";
  static const String privacyPolicyScreen = "/PrivacyPolicyScreen";
  static const String termsConditionScreen = "/TermsConditionScreen";
  static const String friendScreen = "/FriendScreen";
  static const String createTeamScreen = "/CreateTeamScreen";
  static const String allMemberScreen = "/AllMemberScreen";
  static const String addEventsScreen = "/AddEventsScreen";
  static const String historyScreeen = "/HistoryScreeen";
  static const String massageListScreen = "/MassageListScreen";
  static const String messageScreen = "/MessageScreen";
  static const String chatScreen = "/ChatScreen";



  static List<GetPage> routes = [

    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => SplashScreen()),
   // GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    //GetPage(name: loginScreen, page: () => LoginScreen()),




    ///===========================Mededi==========================
    GetPage(name: eventsProfileScreen, page: () => EventsProfileScreen()),
    GetPage(name: settingScreen, page: () => SettingScreen()),
    GetPage(name: aboutUsScreen, page: () => AboutUsScreen()),
    GetPage(name: privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
    GetPage(name: termsConditionScreen, page: () => TermsConditionScreen()),
    GetPage(name: friendScreen, page: () => FriendScreen()),
    GetPage(name: createTeamScreen, page: () => CreateTeamScreen()),
    GetPage(name: allMemberScreen, page: () => AllMemberScreen()),
    GetPage(name: addEventsScreen, page: () => AddEventsScreen()),
    GetPage(name: historyScreeen, page: () => HistoryScreeen()),
    GetPage(name: massageListScreen, page: () => MassageListScreen()),
    GetPage(name: messageScreen, page: () => MessageScreen()),
    GetPage(name: chatScreen, page: () => ChatScreen()),


  ];
}
