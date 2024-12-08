// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:tractivity_app/view/screens/onboarding_screen/onboarding_screen.dart';
import 'package:tractivity_app/view/screens/splash_screen/splash_screen.dart';

///=========================App Routes=========================
class AppRoutes {

  static const String splashScreen = "/SplashScreen";
  static const String homeScreen = "/HomeScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String loginScreen = "/LoginScreen";
  static const String signupScreen = "/SignupScreen";
  static const String verificationScreen = "/VerificationScreen";
  static const String forgotPassword = "/ForgotPassword";
  static const String friendScreen = "/FriendScreen";
  static const String friendProfileScreen = "/FriendProfileScreen";
  static const String chatScreen = "/ChatScreen";
  static const String massageListScreen = "/MassageListScreen";
  static const String messageScreen = "/MessageScreen";
  static const String notificationsScreen = "/NotificationsScreen";
  static const String personProfileScreen = "/PersonProfileScreen";
  static const String editPersonProfileScreen = "/EditPersonProfileScreen";
  static const String settingScreen = "/SettingScreen";
  static const String aboutUsScreen = "/AboutUsScreen";
  static const String privacyPolicyScreen = "/PrivacyPolicyScreen";
  static const String termsConditionScreen = "/TermsConditionScreen";
  static const String meetUpListScreen = "/MeetUpListScreen";
  static const String invitedAnotherUserScreen = "/InvitedAnotherUserScreen";
  static const String meetUpProfileScreen = "/MeetUpProfileScreen";
  static const String inviteFriendScreen = "/InviteFriendScreen";
  static const String removeSomeoneScreen = "/RemoveSomeoneScreen";
  static const String verificationMailScreen = "/VerificationMailScreen";
  static const String creationScreen = "/CreationScreen";
  static const String pinListScreen = "/PinListScreen";
  static const String pinCreationScreen = "/PinCreationScreen";
  static const String pinTitleSubtitleScreen = "/PinTitleSubtitleScreen";




  static List<GetPage> routes = [

    ///===========================Authentication==========================

    GetPage(name: splashScreen, page: () => SplashScreen()),

    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),

 /*  GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: verificationScreen, page: () => VerificationScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPassword()),
    GetPage(name: friendScreen, page: () => FriendScreen()),
    GetPage(name: friendProfileScreen, page: () => FriendProfileScreen()),*/

  ];
}
