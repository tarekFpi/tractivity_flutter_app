// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/adminstratior_eventlist_screen.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/adminstrator_event_details_screen.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/adminstrator_home_screen.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/adminstrator_mission_details_screen.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/adminstrator_organization_details_screen.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/adminstrator_organization_report_screen.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/event_complete_screen.dart';
import 'package:tractivity_app/view/screens/adminstrator_home_screen/member/adminstrator_member.dart';
import 'package:tractivity_app/view/screens/auth_screen/signup_screen/location_map_screen.dart';
import 'package:tractivity_app/view/screens/chat_screen/chat_screen.dart';
import 'package:tractivity_app/view/screens/chat_screen/inner_widget/group_message_screen.dart';
import 'package:tractivity_app/view/screens/chat_screen/inner_widget/single_message_screen.dart';
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
import 'package:tractivity_app/view/screens/friend_screen/remove_friend_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/donation_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_complete_details_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_completed_event.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/event_member_details_screen/event_member_details_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/exolore_event_screen/exolore_event_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/home_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/join_event_screen/join_details_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/join_event_screen/join_event_details_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/join_event_screen/join_event_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/join_organization_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/member_screen/event_compleate_member.dart';
import 'package:tractivity_app/view/screens/home_screen/member_screen/member_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/recent_event_explore_details.dart';
import 'package:tractivity_app/view/screens/home_screen/user_event_profile/user_event_profile.dart';
import 'package:tractivity_app/view/screens/home_screen/user_event_profile/volunteer_report_screen.dart';
import 'package:tractivity_app/view/screens/home_screen/volunteer_chart_screen.dart';
import 'package:tractivity_app/view/screens/notification/notification_screen.dart';
import 'package:tractivity_app/view/screens/onboarding_screen/onboarding_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/Invite_member_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/mission_to_volunteers_invite_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organization_event_list_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organize_details_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_active_mission_details.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_inactive_mission_details.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_invite_mission_screen/mission_event_report_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_invite_mission_screen/organizer_create_event.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_mission_details_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_recent_event_details.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_home_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_invite_mission_screen/organize_map.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/organizer_invite_mission_screen/organizer_invite_mission_screen.dart';
import 'package:tractivity_app/view/screens/profile_screen/edit_profile_screen.dart';
import 'package:tractivity_app/view/screens/organizer_home_screen/explore_event_screen.dart';
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
  static const String locationMapScreen = "/LocationMapScreen";




  ////============ Mededi =================

  static const String settingScreen = "/SettingScreen";
  static const String aboutUsScreen = "/AboutUsScreen";
  static const String privacyPolicyScreen = "/PrivacyPolicyScreen";
  static const String friendScreen = "/FriendScreen";
  static const String createTeamScreen = "/CreateTeamScreen";
  static const String allMemberScreen = "/AllMemberScreen";
  static const String addEventsScreen = "/AddEventsScreen";
  static const String historyScreeen = "/HistoryScreeen";
  static const String massageListScreen = "/MassageListScreen";
  static const String messageScreen = "/MessageScreen";
  static const String singleMessageScreen = "/SingleMessageScreen";
  static const String chatScreen = "/ChatScreen";
  static const String signupScreen = "/SignupScreen";
  static const String verificationMailScreen = "/VerificationMailScreen";
  static const String verificationScreen = "/VerificationScreen";
  static const String forgotPassword = "/ForgotPassword";
  static const String exploreEventScreen = "/ExploreEventScreen";
  static const String organizerRecentEventDetails = "/OrganizerRecentEventDetails";
  static const String recentEventExploreDetails = "/RecentEventExploreDetails";
  static const String removeFriendScreen = "/RemoveFriendScreen";
  static const String exoloreCompleteDetailsScreen = "/ExoloreCompleteDetailsScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String exoloreEventScreen = "/ExoloreEventScreen";
  static const String adminstratiorEventListScreen = "/AdminstratiorEventListScreen";
  static const String donationScreen = "/DonationScreen";
  static const String eventMemberDetailsScreen = "/EventMemberDetailsScreen";
  static const String organizerHomeScreen = "/OrganizerHomeScreen";
  static const String organizerInviteMissionScreen = "/OrganizerInviteMissionScreen";
  static const String adminstratorHomeScreen = "/AdminstratorHomeScreen";
  static const String eventCompleateMember = "/EventCompleateMember";
  static const String userEventProfile = "/UserEventProfile";
  static const String joinEventScreen = "/JoinEventScreen";
  static const String memberScreen = "/MemberScreen";
  static const String adminstratorMember = "/AdminstratorMember";
  static const String eventCompleteScreen = "/EventCompleteScreen";
  static const String termsConditionScreen = "/TermsConditionScreen";
  static const String organizerApprovedScreen = "/OrganizerApprovedScreen";
  static const String organizeDetailsScreen = "/OrganizeDetailsScreen";
  static const String organizeMapScreen = "/OrganizeMapScreen";
  static const String joinDetailsScreen = "/JoinDetailsScreen";
  static const String joinEventDetailsScreen = "/JoinEventDetailsScreen";
  static const String addMemberScreen = "/AddMemberScreen";
  static const String editPersonProfileScreen = "/EditPersonProfileScreen";
  static const String exoloreEventCompletedScreen = "/ExoloreEventCompletedScreen";
  static const String adminstratorEventDetailsScreen = "/AdminstratorEventDetailsScreen";
  static const String organizationEventListScreen = "/OrganizationEventListScreen";
  static const String volunteerChartScreen = "/VolunteerChartScreen";
  static const String volunteerEventReportScreen = "/VolunteerEventReportScreen";
  static const String organizerMissionDetailsScreen = "/OrganizerMissionDetailsScreen";
  static const String organizerInactiveMissionDetails = "/OrganizerInactiveMissionDetails";
  static const String organizerActiveMissionDetails = "/OrganizerActiveMissionDetails";
  static const String missionToVolunteersInviteScreen = "/MissionToVolunteersInviteScreen";
  static const String missionEventReportScreen = "/MissionEventReportScreen";
  static const String organizerEventCreateScreen = "/OrganizerEventCreateScreen";
  static const String adminstratorOrganizationDetailsScreen = "/AdminstratorOrganizationDetailsScreen";
  static const String joinOrganizationScreen = "/joinOrganizationScreen";
  static const String adminstratorOrganizationReportScreen = "/AdminstratorOrganizationReportScreen";

  static List<GetPage> routes = [

    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: locationMapScreen, page: () => LocationMapScreen()),

    GetPage(name: verificationMailScreen, page: () => VerificationMailScreen()),
    GetPage(name: verificationScreen, page: () => VerificationScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPassword()),



    GetPage(name: settingScreen, page: () => SettingScreen()),
    GetPage(name: aboutUsScreen, page: () => AboutUsScreen()),
    GetPage(name: privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
    GetPage(name: termsConditionScreen, page: () => TermsConditionScreen()),
    GetPage(name: friendScreen, page: () => FriendScreen()),
    GetPage(name: createTeamScreen, page: () => CreateTeamScreen()),
    GetPage(name: allMemberScreen, page: () => AllMemberScreen()),
    GetPage(name: memberScreen, page: () => MemberScreen()),
    GetPage(name: addEventsScreen, page: () => AddEventsScreen()),
    GetPage(name: historyScreeen, page: () => HistoryScreeen()),
    GetPage(name: massageListScreen, page: () => MassageListScreen()),
    GetPage(name: messageScreen, page: () => MessageScreen()),
    GetPage(name: singleMessageScreen, page: () => SingleMessageScreen()),
    GetPage(name: removeFriendScreen, page: () => RemoveFriendScreen()),
    GetPage(name: chatScreen, page: () => ChatScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: exploreEventScreen, page: () => ExploreEventScreen()),
    GetPage(name: exoloreCompleteDetailsScreen, page: () => ExoloreCompleteDetailsScreen()),
    GetPage(name: eventCompleateMember, page: () => EventCompleateMember()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: exoloreEventScreen, page: () => ExoloreEventScreen()),
    GetPage(name: exoloreEventCompletedScreen, page: () => ExoloreEventCompletedScreen()),
    GetPage(name: eventMemberDetailsScreen, page: () => EventMemberDetailsScreen()),
    GetPage(name: organizerHomeScreen, page: () => OrganizerHomeScreen()),
    GetPage(name: organizerInviteMissionScreen, page: () => OrganizerInviteMissionScreen()),
    GetPage(name: adminstratorHomeScreen, page: () => AdminstratorHomeScreen()),
    GetPage(name: recentEventExploreDetails, page: () => RecentEventExploreDetails()),
    GetPage(name: adminstratorMember, page: () => AdminstratorMember()),

    GetPage(name: donationScreen, page: () => DonationScreen()),
    GetPage(name: userEventProfile, page: () => UserEventProfile()),
    GetPage(name: joinEventScreen, page: () => JoinEventScreen()),
    GetPage(name: eventCompleteScreen, page: () => EventCompleteScreen()),
    GetPage(name: termsConditionScreen, page: () => TermsConditionScreen()),
    GetPage(name: organizeMapScreen, page: () => OrganizeMapScreen()),
    GetPage(name: addMemberScreen, page: () => InviteMemberScreen()),

    GetPage(name: editPersonProfileScreen, page: () => EditPersonProfileScreen()),

    GetPage(name: organizerRecentEventDetails, page: () => OrganizerRecentEventDetails()),
    GetPage(name: joinDetailsScreen, page: () => JoinDetailsScreen()),
    GetPage(name: joinEventDetailsScreen, page: () => JoinEventDetailsScreen()),
    GetPage(name: adminstratorEventDetailsScreen, page: () => AdminstratorEventDetailsScreen()),
    GetPage(name: organizeDetailsScreen, page: () => OrganizeDetailsScreen()),
    GetPage(name: organizationEventListScreen, page: () => OrganizationEventListScreen()),
    GetPage(name: adminstratiorEventListScreen, page: () => AdminstratiorEventListScreen()),
    GetPage(name: volunteerChartScreen, page: () => VolunteerChartScreen()),

    GetPage(name: volunteerEventReportScreen, page: () => VolunteerEventReportScreen()),
    GetPage(name: organizeDetailsScreen, page: () => OrganizeDetailsScreen()),
    GetPage(name: organizerInactiveMissionDetails, page: () => OrganizerInactiveMissionDetails()),
    GetPage(name: organizerActiveMissionDetails, page: () => OrganizerActiveMissionDetails()),

    GetPage(name: missionToVolunteersInviteScreen, page: () => MissionToVolunteersInviteScreen()),
    GetPage(name: missionEventReportScreen, page: () => MissionEventReportScreen()),
    GetPage(name: organizerEventCreateScreen, page: () => OrganizerEventCreateScreen()),
    GetPage(name: organizerMissionDetailsScreen, page: () => OrganizerMissionDetailsScreen()),
    GetPage(name: adminstratorOrganizationDetailsScreen, page: () => AdminstratorOrganizationDetailsScreen()),
    GetPage(name: joinOrganizationScreen, page: () => JoinOrganizationScreen()),
    GetPage(name: adminstratorOrganizationReportScreen, page: () => AdminstratorOrganizationReportScreen()),
  ];

}
