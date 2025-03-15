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

  ///=================== Retrive  Specific fromDate events by missionId========================================
  static String retriveSpecificFromDateEventByMissionId ({required String missionId,required String fromDate}) =>"/organizer/event/retrive/report/mission/$missionId?fromDate=$fromDate";

  ///=================== Retrive  Specific fromDate events by missionId========================================
  static String retriveSpecificFromDateToDateEventByMissionId ({required String missionId,required String fromDate,required String toDate}) =>"/organizer/event/retrive/report/mission/$missionId?fromDate=$fromDate&toDate=$toDate";


  ///=================== Retrive  Specific fromDate  mission report ========================================
  static String retriveSpecificFromDateMissionByReport ({required String missionId,required String fromDate}) =>"/mission/retrive/organization/report/$missionId?fromDate=$fromDate";

  ///=================== Retrive  Specific fromDate mission by mission ========================================
  static String retriveSpecificFromDateToDateMissionReport ({required String missionId,required String fromDate,required String toDate}) =>"/mission/retrive/organization/report/$missionId?fromDate=$fromDate&toDate=$toDate";

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


  ///Get all organizations except me as a volunteer
   static String retriveOrganizationVolunteer ({required String userId}) =>"/volunteer/retrieve/organizations/without/$userId";

  ///Join organization as volunteer
  static String joinOrganizationVolunteer ="/volunteer/join-organization";


  /// Retrieve volunteers for sending invitation by mission Id
  static String retrieveVolunteerToMissionInvite ({required String missionId}) =>"/organizer/retrieve-volunteers/$missionId";


  /// Invite volunteers to a specific mission by mission Id
  static String inviteVolunteerToMissionByMission ({required String missionId}) =>"/organizer/invite-volunteers/$missionId";

  ///Create new event
  static String createEvent ="/organizer/event/create";

  /// inviteVolunteer event to event
  static String inviteVolunteer({required String missionId}) =>"/organizer/event/volunteer/mission/$missionId";



  ///================== Volunteer api endpoint =============================


  ///Retrive all invitation event notification by volunteer
  static String inviteVolunteerEvent({required String userId}) =>"/volunteer/notification/$userId?type=event";

  ///Retrive all invitation mission notification by volunteer
  static String inviteVolunteerMission({required String userId}) =>"/volunteer/notification/$userId?type=mission";

  ///Accept event invitation
  static String acceptEventVolunteer="/volunteer/join-invitation";


  ///Accept mission invitation by invitation Id
  static String acceptMissionVolunteer({required String missionId}) =>"/volunteer/mission/invitation/accept/$missionId";



  ///=================== delete event invitation   ==============
  static String deleteEventInviation ({required String eventId}) =>"/volunteer/mission/invitation/accept/67c72ba6f5955bf766441917";


  ///=================== delete mission invitation   ==============
  static String deleteMissionInviation ({required String invitationId}) =>"/organizer/reject-invitation/$invitationId";

  ///Accept event Start work
  static String startWorkEventVolunteer="/volunteer/event/start-work";

  ///Accept event End work
  static String endWorkEventVolunteer="/volunteer/event/end-work";

  ///Retrive events by specific volunteer
  static String retriveMyEventVolunteer({required String userId})=>"/volunteer/event/$userId/search?status=running";

  /// volunteer completed event
  static String retriveCompletedEventVolunteer({required String userId})=>"/volunteer/event/$userId/search?status=complete";

  ///=================== search  volunteer completed event date  ==============
  static String searchVolunteerEventSearch ({required String userId,required String query}) =>"/volunteer/event/$userId/search?status=complete&date=$query";

  ///=================== search  volunteer completed event name  ==============
  static String searchVolunteerEventNameSearch ({required String userId,required String query}) =>"/volunteer/event/$userId/search?query=$query&status=complete";


  ///=================== volunteer  My event list  ==============
  static String volunteerMyEventName ({required String userId}) =>"/volunteer/event/$userId/search?status=running";

}