class ApiUrl {
  static const String baseUrl = "http://10.0.60.55:5001/v1";

  static const String imageUrl = "http://10.0.60.55:5001/v1/";

  static  String socketUrl({required String id}) => "http://192.168.12.100:5005?userId=$id";
  // server url : http://115.127.156.14:5002/api/v1
  // local url : http://192.168.12.31:5003/api/v1

///========================= Authentication =========================

  static const String login = "/user/auth/login";
  static const String forgotPassword = "/user/auth/reset-password";
  static const String otp_verify = "/user/auth/verify-otp";
  static const String otp_reset = "/user/auth/forget-password/send-otp";
  static const String forget_password = "/user/auth/forget-password/send-otp";
  static const String forgotCreateNewPassword = "/auth/reset-password";
  static const String signUp = "/user/create";
  static const String register = "/user/create";
  static const String createNewPassword = "/auth/change-password";
  static const String privacyPolicy = "/privacy-policy/retrive";
  static const String termsCondition = "/terms-condition/retrive";
  static const String infoRetrieve = "/info/retrive/all";


  ///============= Profile Apis ===============
  static String getUserProfile({required String userId}) => "/user/$userId";
  static String updateProfile({required String userId}) => "/user/update/$userId";
  static String getReviewMode({required String userId}) => "/review-mode/user/intervals/$userId";
  static String friendSearch({required String cetagory, required String query}) => "/user/search?$cetagory=$query";


  ///=========================== adminstrator api  ===========================

  ///=========================== organization create api  ===========================
  static String createOranizer = "/organization/create";

  ///=========================== organization/update api  ===========================
  static String editOranizer ({required String oranizerId}) => "/organization/update/$oranizerId";

  ///=========================== mission/create api ===========================
  static String createMission = "/mission/create";

  ///=========================== mission/edit api ===========================
  static String editMission ({required String editId}) => "/mission/update/$editId";

  ///=========================== organization retrive by creator id api  ===========================
  static String fetchOrganization ({required String userId}) =>"/organization/retrive/creator/$userId";

  ///=================== search  Organization ==============
  static String searchOrganization ({required String query}) =>"/mission/organization/search?query=$query";

  ///=================== search leader ==============
  static String searchLeader ({required String query}) =>"/mission/organizer/search?query=$query";

  ///=================== deleteOrganization  ==============
  static String deleteOrganization ({required String organization_Id}) =>"/organization/delete/$organization_Id";

  ///=================== leader Show   ==============
  static String leaderShow ="/mission/organizer/search";


  ///=================== deleteOrganization  ==============

  static String deleteMission ({required String mission_Id}) =>"/mission/delete/$mission_Id";



  ///=================== Remove specific organizer from a mission  ==============

  static String removeSpecificOrganizer ({required String missionId}) =>"/mission/remove/organizer/$missionId";


  ///=================== show Mission List ==============
  static String showMission ({required String userId}) =>"/mission/retrive/creator/$userId";


  ///=================== mission id By Event  List ========================================
  static String missionIdByMissionDetails ({required String missionId}) =>"/mission/retrive/$missionId";


  ///=================== Retrieve all mission by specific organization ==================================
  static String organizationByMissionList({required String organizationId}) =>"/mission/retrive/organization/$organizationId";


  ///=================== Retrive all events by missionId========================================

  static String retriveAllEventByMissionId ({required String missionId}) =>"/organizer/event/retrive/mission/$missionId";


///===================== retrive Specific event by Id event show =====================
  static String retriveBySpecificEventList ({required String eventId}) =>"/organizer/event/retrive/$eventId";

  ///===================== retrive user profile show by user Id  =====================
  static String retriveUserProfile ({required String userId}) =>"/user/retrive/$userId";


  ///===================== Retrive invited missions by organizer =====================
  static String retriveInvitedMissionOrganizer({required String userId}) =>"/organizer/invited-missions/$userId";

  ///Accept mission invitation for organizer
   static String acceptmissionInvitation({required String invit_Id}) =>"/organizer/accept-invitation/$invit_Id";

 ///rejectMissionsInvitationLoading
  static String rejectMissionInvitation({required String invit_Id}) =>"/organizer/reject-invitation/$invit_Id";


  ///Retrieve all Active missions by organizer
  static String retrieveMissionActivie({required String userId}) =>"/organizer/all-missions/$userId?status=active";

  ///Retrieve all InActive missions by organizer
  static String retrieveMissionInActivie({required String userId}) =>"/organizer/all-missions/$userId?status=inactive";

  ///===================== retrive running by user Id  =================================
  static String retriveRunningProfile ({required String userId}) =>"/organizer/event/retrive/organizer/$userId?status=running";

}