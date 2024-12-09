// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:tractivity_app/view/screens/auth_screen/login_screen/login_screen.dart';
import 'package:tractivity_app/view/screens/friend_screen/friend_screen.dart';
import 'package:tractivity_app/view/screens/auth_screen/signup_screen/signup_screen.dart';
import 'package:tractivity_app/view/screens/onboarding_screen/onboarding_screen.dart';
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
    GetPage(name: loginScreen, page: () => LoginScreen()),

    GetPage(name: signupScreen, page: () => SignupScreen()),



 /*  GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),

    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: verificationScreen, page: () => VerificationScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPassword()),
    GetPage(name: friendScreen, page: () => FriendScreen()),


  ];
}
