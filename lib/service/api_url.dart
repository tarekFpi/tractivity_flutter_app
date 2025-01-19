class ApiUrl {
  static const String baseUrl = "http://192.168.12.100:5005/v1";
  static const String imageUrl = "http://192.168.12.100:5005";
  static  String socketUrl({required String id}) => "http://192.168.12.100:5005?userId=$id";
  // server url : http://115.127.156.14:5002/api/v1
  // local url : http://192.168.12.31:5003/api/v1
//========================= Authentication =========================

  static const String login = "/auth/login";
  static const String forgotPassword = "/auth/forget-password/send-otp";
  static const String otp = "/auth/verify-otp";
  static const String userVerify = "/auth/verify-email";
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

  ///=========================== Leaderboard ===========================




}