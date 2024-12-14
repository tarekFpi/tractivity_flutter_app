// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:tractivity_app/view/screens/chat_screen/chat_screen.dart';
import 'package:tractivity_app/view/screens/chat_screen/inner_widget/message_screen.dart';
import 'package:tractivity_app/view/screens/chat_screen/massage_list_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/add_events_screen/add_events_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/all_member_screen/all_member_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/create_team_screen.dart';
import 'package:tractivity_app/view/screens/create_team_screen/history_screeen/history_screeen.dart';
import 'package:tractivity_app/view/screens/auth_screen/forgot_password/forgot_password.dart';
import 'package:tractivity_app/view/screens/auth_screen/login_screen/login_screen.dart';
import 'package:tractivity_app/view/screens/auth_screen/verification_mail_screen/verification_mail_screen.dart';
import 'package:tractivity_app/view/screens/auth_screen/verification_screen/verification_screen.dart';
import 'package:tractivity_app/view/screens/friend_screen/friend_screen.dart';
import 'package:tractivity_app/view/screens/auth_screen/signup_screen/signup_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/home_screen.dart';
import 'package:tractivity_app/view/screens/notification/notification_screen.dart';
import 'package:tractivity_app/view/screens/onboarding_screen/onboarding_screen.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/events_profile_screen.dart';
import 'package:tractivity_app/view/screens/profile_screen/events_profile_screen/explore_event_screen.dart';

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
  static const String signupScreen = "/SignupScreen";
  static const String verificationMailScreen = "/VerificationMailScreen";
  static const String verificationScreen = "/VerificationScreen";
  static const String forgotPassword = "/ForgotPassword";
  static const String exploreEventScreen = "/ExploreEventScreen";
  static const String notificationScreen = "/NotificationScreen";



  static List<GetPage> routes = [

    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),

    GetPage(name: verificationMailScreen, page: () => VerificationMailScreen()),
    GetPage(name: verificationScreen, page: () => VerificationScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPassword()),



    ///=========================== Mehedi ==========================
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
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: exploreEventScreen, page: () => ExploreEventScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),


  ];
}
