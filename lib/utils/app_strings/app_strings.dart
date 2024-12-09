class   AppStrings {
  static RegExp passRegexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.{8,}$)');
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String fieldCantBeEmpty = "Field can't be empty";
  static const String emailFieldCantBeEmpty = "Please enter your email";
  static const String passwordFieldCantBeEmpty = "Please enter your password";
  static const String checknetworkconnection = "Check network connection";
  static const String enterThe8Character = "Please Enter The 8 character";
  static const String passwordNotMatch = "Passwords do not match";

  //================== Custom Controller String ===================//
  static const String item = "Item";


  ///============================ Commom Auth =========================//
  static const String welcomeBack = "Welcome Back !";
  static const String pleaseEnterYourPersonalData = "Please Enter Your Personal Data";
  static const String email = "Email";
  static const String enterYourName = "Enter Your Name";
  static const String enterYourEmail = "Enter Your Email";
  static const String password = "Password";
  static const String newPassword = "New Password";
  static const String enterYourPassword = "Enter Your Password";
  static const String rememberMe = "Remember me";
  static const String forgotPassword = "Forgot Password?";
  static const String signin = "Sign In!";
  static const String dontHaveAccount = "Don’t have account ? ";
  static const String signUp = "Sign Up";
  static const String hi = "HI !";
  static const String pleaseSelectHowYou = "Pleas select how you want to use this app";
  static const String professional = "Professional";
  static const String user = "User";
  static const String fullName = "Full name";
  static const String phoneNumber = "Phone Number";
  static const String enterYourPhone = "Enter Your Phone No";
  static const String confirmPassword = "Confirm Password";
  static const String iAgree = "I agree with terms of service and ";
  static const String iAgree1 = "I agree with ";
  static const String iAgree2 = "Terms ";
  static const String iAgree3 = "of Service and ";
  static const String privacyPolicy = "Privacy policy";
  static const String termsAndConditions = "Terms and Conditions";
  static const String singUp = "Sing Up";
  static const String singUpText = "SIGN UP";
  static const String singInText = "SIGN IN!";
  static const String haveAnyAccount = "Have any account?";
  static const String logIn = "Log in";
  static const String logOut = "Log Out";
  static const String deleteAccount = "Delete Account";
  static const String yesDelete = "YES,DELETE";
  static const String updatePasswordText = "UPDATE PASSWORD";
  static const String scan = "Order History";
  static const String enterCode = "Enter 4 Digits Code";
  static const String enterTheCodeTitle = "Enter the 6 digits code that you received on your email";
  static const String ididntFind = "I didn't find confirmation code,";
  static const String sendAgain = "Send Again";
  static const String confirm = "CONFIRM";
  static const String yourAccountIsReady = "Your account is ready";
  static const String emailConfirmation = "Email Confirmation";
  static const String enterYourEmailForVerification = "Enter Your email for verification.";
  static const String sendVerificationCode = "Send Verification Code";
  static const String verifyCode = "Verify Code";
  static const String resendConfirmationCode = "Resend Confirmation Code";
  static const String resetPassword = "Reset Password !";
  static const String updatePassword = "Update Password";
  static const String welcome = "Welcome";
  static const String nextAppointment = "Next Appointment";
  static const String popularServices = "Popular services";
  static const String viewAll = "View all";
  static const String offers = "Offers";
  static const String oldPassword = "Old password";
  static const String changePassword = "Change password";
  static const String yourName = "Your Name";
  static const String yourFirstName = "Your First Name";
  static const String userName = "User Name";
  static const String yourLastName = "Your Last Name";


  ///========================== Nav Bar =====================//

  static const String home = "Home";
  static const String friend = "Friend";
  static const String messages = "Messages";
  static const String profile = "Profile";
  static const String team = "Team";
  ///===================================================

  static const String explore = "Explore";
  static const String events = "Events";
  static const String volunteer = "Volunteer";
  static const String profession = "Profession";
  static const String address = "Address";
  static const String profileSetting = "ProfileSetting";
  static const String aboutus = "Aboutus";
  static const String setting = "Setting";


}
