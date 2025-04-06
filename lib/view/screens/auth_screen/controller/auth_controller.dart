import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/helper/shared_prefe/shared_prefe.dart';
import 'package:tractivity_app/service/api_check.dart';
import 'package:tractivity_app/service/api_client.dart';
import 'package:tractivity_app/service/api_url.dart';
import 'package:tractivity_app/utils/SocketApi.dart';
import 'package:tractivity_app/utils/ToastMsg/toast_message.dart';
import 'package:tractivity_app/utils/app_const/app_const.dart';
import 'package:tractivity_app/utils/app_strings/app_strings.dart';
import 'package:tractivity_app/utils/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tractivity_app/view/screens/auth_screen/user_profile_model/UserProfileShowResponseModel.dart';

class AuthController extends GetxController {


  RxBool agreeStatue = false.obs;

  RxString checkValueStatues = "".obs;


  ///======================================>> picker Cover photo  <<================================

  final ImagePicker pickerCover = ImagePicker();
  //File? imagePath;
  RxString chooseUserImage = "".obs;

  Future<void> chooseUserPhoto() async {
    try {
      final XFile? pickedFile =
      await pickerCover.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Convert XFile to File if needed

        chooseUserImage.value = pickedFile.path;
        chageProfile();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ///Change profile picture
  RxBool changeProfileLoading = false.obs;
  Future<void> chageProfile() async{

    changeProfileLoading.value = true;
    var userId = await SharePrefsHelper.getString(AppConstants.userId);

    var body = {
      "name": "",
    };

    var response = await ApiClient.patchMultipartData(ApiUrl.chageProfile(userId: userId), body,
        multipartBody: [MultipartBody('image', File(chooseUserImage.value))]);

    if (response.statusCode == 200) {

      Toast.successToast("User profile change successfully");

      changeProfileLoading.value =false;

    } else {

      changeProfileLoading.value =false;

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        refresh();
        return;
      } else {

        ApiChecker.checkApi(response);

        refresh();
        return;
      }
    }
  }


  ///======================================>> users-profile-show <<================================

  Rx<UserProfileShowResponseModel> userProfileShow = UserProfileShowResponseModel().obs;

  RxBool userInfoShowLoading = false.obs;

  Future<void> userInformationShow() async {

    userInfoShowLoading.value=true;

    var userId= await SharePrefsHelper.getString(AppConstants.userId);

    var response = await ApiClient.getData(ApiUrl.userProfileShow(userId: userId));

    if (response.statusCode == 200) {

      userProfileShow.value = UserProfileShowResponseModel.fromJson(response.body["data"]);

      debugPrint("userProfileResponseModel:${userProfileShow.value.toJson()}");

      editfullNameController.value.text =userProfileShow.value.fullName.toString();
      edittalentSkillController.value.text = userProfileShow.value.profession.toString();
     editphoneNumberController.value.text =  userProfileShow.value.phone.toString();
     editlocationController.value.text = userProfileShow.value.address.toString();


      userProfileShow.value.roles?.forEach((role) {
        if (role == "organizer") {
          organizer.value = true;
          editRolesList.add("organizer");

        } if (role == "administrator") {

          administrator.value = true;
          editRolesList.add("administrator");

        } if (role == "volunteer") {

          volunteer.value = true;
          editRolesList.add("volunteer");
        }
        debugPrint("editRolesList: $role");
      });

      refresh();

      userInfoShowLoading.value=false;

    } else {

      userInfoShowLoading.value=false;
      refresh();
      if (response.statusText == ApiClient.somethingWentWrong) {

        showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);

        return;
      } else {
        ApiChecker.checkApi(response);
        return;
      }
    }
  }

  ///Update specific user
  Rx<TextEditingController> editfullNameController = TextEditingController().obs;
  Rx<TextEditingController> edittalentSkillController = TextEditingController().obs;
  Rx<TextEditingController> editphoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> editlocationController = TextEditingController().obs;

  RxList<String>editRolesList = <String>[].obs;

  RxBool userInfoUpdateShowLoading = false.obs;

  Future<void> profileUpdate(double latitude,double longitude) async {

    userInfoUpdateShowLoading.value = true;

    var userId= await SharePrefsHelper.getString(AppConstants.userId);

    var body = json.encode({
      "fullName": editfullNameController.value.text,
      "profession": edittalentSkillController.value.text,
      "phone": editphoneNumberController.value.text,
      "roles":editRolesList.value,
      "cords": {
        "lat": latitude,
        "lng": longitude
      },
      "address": editlocationController.value.text,
      "isSocial": false,
      "fcmToken": null
    });

    var response = await ApiClient.patchData(ApiUrl.updateProfile(userId: userId), body);


    if (response.statusCode == 200) {

      Toast.successToast("User modified successfully");
      Get.back();

      refresh();
      userInfoUpdateShowLoading.value = false;

      editfullNameController.value.clear();
      edittalentSkillController.value.clear();
      editphoneNumberController.value.clear();
       editlocationController.value.clear();

    } else {
      userInfoUpdateShowLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);

        return;
      } else {

        ApiChecker.checkApi(response);
        userInfoUpdateShowLoading.value = false;
        refresh();
        return;
      }
    }
  }



  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;

  var  addressAutocomplete="".obs;

  Future<void> getLatLongFromAddress() async {

    try {

      isLoading.value = true;
      List<Location> locations = await locationFromAddress(editlocationController.value.text);

      if (locations.isNotEmpty) {
        latitude.value = locations.first.latitude;
        longitude.value = locations.first.longitude;

          profileUpdate(latitude.value,longitude.value);
          debugPrint("locationFromAddress: ${latitude.value}, Long: ${longitude.value},editlocationController:${editlocationController.value.text}");

      }else{

        profileUpdate(_currentPosition?.latitude??0.0,_currentPosition?.longitude??0.0);
      }
    } catch (e) {

      debugPrint("Location not found: $e");

    } finally {
      isLoading.value = false;
    }
  }


  ///==================== get User Current Location and address ==================
  RxString address = "".obs;

  Position? _currentPosition;

  Future<void> getUserCurrentLocation() async {
    try {

      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition();

      _currentPosition = position;

      locationController.value.text ="${_currentPosition?.latitude},${_currentPosition?.longitude}";


      debugPrint("_currentPosition: ${_currentPosition?.latitude},${_currentPosition?.longitude}");

      List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition?.latitude??0.0, _currentPosition?.longitude??0.0);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        ///  setState(() { });

        address.value ="${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

      } else {
        address.value = "No address found.";
      }

    } catch (e) {
      print("Error getting location: $e");
    }
  }

  RxBool volunteer = false.obs;

  RxBool organizer = false.obs;

  RxBool administrator = false.obs;

 RxList<String>rolesList = <String>[].obs;

 RxList<String>cordsList = <String>[].obs;

  ///====================USER REGISTER CONTROLLER==================
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> talentSkillController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;

  ///=====================USER REGISTER METHOD=====================
  RxBool userRegisterLoading = false.obs;

  Future<void> userRegister() async {

    userRegisterLoading.value = true;
    final nameToFullName = formatName(fullNameController.value.text);

    //debugPrint("fullNameController:${nameToSave}");


   var body = json.encode({
      "fullName": nameToFullName,
      "profession": talentSkillController.value.text,
      "email": emailController.value.text,
      "phone": phoneNumberController.value.text,
      "password": passwordController.value.text,
      "roles":rolesList.value,
      "cords": {
        "lat": _currentPosition?.latitude,
        "lng": _currentPosition?.longitude
      },
      "address": address.value,
      "isSocial": false,
      "fcmToken": null
    });

    var response = await ApiClient.postData(ApiUrl.signUp, body);


    if (response.statusCode == 201) {

      Toast.successToast(response.body['message']);

      Get.offNamed(AppRoutes.verificationEmail_Screen, arguments: [
        {
          "email":emailController.value.text
        }
      ]);


      clearUserRegisterTextFields();
      refresh();
      userRegisterLoading.value = false;

    } else {
      userRegisterLoading.value = false;
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);

        return;
      } else {

        ApiChecker.checkApi(response);
        userRegisterLoading.value = false;
        refresh();
        return;
      }
    }
  }


  String formatName(String name) {
    return name
        .trim()
        .split(' ')
        .map((word) => word.isNotEmpty
        ? word[0].toUpperCase() + word.substring(1).toLowerCase()
        : '')
        .join(' ');
  }


  ///=========== CLEAR USER REGITER TEXT FIELDS =============
  clearUserRegisterTextFields() {
    fullNameController.value.clear();
    emailController.value.clear();
    phoneNumberController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
    locationController.value.clear();
  }

  ///======================VALITATION CONTROLLER=====================

  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<TextEditingController> EmailOtpController = TextEditingController().obs;

  ///=====================VALITATION METHOD=====================

  RxBool otpLoading = false.obs;

  Future<void> otpValidation(String email,String code) async {

    otpLoading.value = true;

    refresh();
    var body = {
      "email": email,
      "otp": code,
    };
    var response = await ApiClient.postData(ApiUrl.otp_verify, jsonEncode(body));
    if (response.statusCode == 200) {
      otpLoading.value = false;
      refresh();

      Toast.successToast(response.body['message']);

      Get.toNamed(AppRoutes.forgotPassword,
          arguments: [
            {
              "email":forgetEmailController.value.text
            }
          ]
      );

    } else {

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        otpLoading.value = false;
        refresh();
        return;

      } else {
        ApiChecker.checkApi(response);
        otpLoading.value = false;
        refresh();
        return;
      }
    }
  }



  RxBool otpResetLoading = false.obs;

  Future<void> otpResetValidation(String email) async {

    otpResetLoading.value = true;

    var body = {
      "email": email,
    };

    var response = await ApiClient.postData(ApiUrl.forget_password, jsonEncode(body));
    if (response.statusCode == 200) {
      otpResetLoading.value = false;
      refresh();

      Toast.successToast(response.body['message']);

      Get.toNamed(AppRoutes.forgotPassword);

    } else {

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        otpResetLoading.value = false;
        refresh();
        return;

      } else {
        ApiChecker.checkApi(response);
        otpResetLoading.value = false;
        refresh();
        return;
      }
    }
  }


  ///===================== verification email singUp  =====================

  RxBool verificationEmailLoading = false.obs;

  Future<void> verificationEmail(String email,String code) async {

    verificationEmailLoading.value = true;

    var body = {
      "email": email,
      "code": code,
    };

    var response = await ApiClient.postData(ApiUrl.verify_email, jsonEncode(body));

    if (response.statusCode == 200) {

      verificationEmailLoading.value = false;
      refresh();

      Toast.successToast(response.body['message']);

      Get.toNamed(AppRoutes.loginScreen);

    } else {

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        verificationEmailLoading.value = false;
        refresh();
        return;

      } else {
        ApiChecker.checkApi(response);
        verificationEmailLoading.value = false;
        refresh();
        return;
      }
    }
  }

  ///===================== verification otpReset  singUp  =====================

  RxBool otpResetEmailOtpLoading = false.obs;

  Future<void> otpResetEmailOtpValidation(String email) async {

    otpResetEmailOtpLoading.value = true;

    var body = {
      "email": email,
    };

    var response = await ApiClient.postData(ApiUrl.verify_otp, jsonEncode(body));
    if (response.statusCode == 200) {
      otpResetEmailOtpLoading.value = false;
      refresh();

      Toast.successToast(response.body['message']);



    } else {

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);
        otpResetEmailOtpLoading.value = false;
        refresh();
        return;

      } else {
        ApiChecker.checkApi(response);
        otpResetEmailOtpLoading.value = false;
        refresh();
        return;
      }
    }
  }

  ///====================FORGET PASSWORD CONTROLLER==================
  Rx<TextEditingController> forgetEmailController = TextEditingController().obs;
  ///================= FORGET PASSWORD METHOD================

  RxBool forgetPasswordLoading = false.obs;

  Future<void> forgetPassword() async {

    forgetPasswordLoading.value = true;
    refresh();
    var body = {"email": forgetEmailController.value.text};

    var response = await ApiClient.postData(ApiUrl.forget_password, jsonEncode(body));

    if (response.statusCode == 200) {

      forgetPasswordLoading.value = false;

      refresh();

      Toast.successToast(response.body['message']);

      Get.toNamed(AppRoutes.verificationScreen,arguments: [
        {
          "email":forgetEmailController.value.text
        }
      ]);

    } else {

      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(response.body['message']);

        forgetPasswordLoading.value = false;
        refresh();
        return;
      } else {
        ApiChecker.checkApi(response);
        forgetPasswordLoading.value = false;
        refresh();
        return;
      }
    }
  }

  ///====================RESET PASSWORD CONTROLLER==================
  Rx<TextEditingController> resetNewPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> resetConfirmPasswordController =
      TextEditingController().obs;

  ///================= RESET PASSWORD METHOD================
  RxBool resetPasswordLoading = false.obs;

  Future<void> restPassword(String email) async {
    resetPasswordLoading.value = true;

    var body = {
      "email": email,
      "newPassword": resetNewPasswordController.value.text,
    };
    var response =
    await ApiClient.postData(ApiUrl.forgotPassword, jsonEncode(body));
    if (response.statusCode == 200) {
      resetPasswordLoading.value = false;
      refresh();

      Toast.successToast("password Reset SuccessFull..");

      Get.toNamed(AppRoutes.loginScreen);

    } else {
      if (response.statusText == ApiClient.somethingWentWrong) {

        Toast.errorToast(AppStrings.checknetworkconnection);

        resetPasswordLoading.value = false;
        refresh();
        return;
      } else {
        ApiChecker.checkApi(response);
        resetPasswordLoading.value = false;
        refresh();
        return;
      }
    }
  }

  ///======================LOGIN CONTROLLER=====================

  Rx<TextEditingController> loginEmailController = TextEditingController(
    text: kDebugMode ? "peraso6002@buides.com" : "", ///fahadhossain0503@gmail.com //taleg84804@citdaca.com
  ).obs;

  Rx<TextEditingController> loginPasswordController = TextEditingController(
    text: kDebugMode ? "12345678" : "", ///12345678
  ).obs;

  ///=====================LOGIN METHOD=====================
  RxBool loginLoading = false.obs;

  Future<void> userLogin() async {
    loginLoading.value = true;
    refresh();
    var body = {
      "email": loginEmailController.value.text,
      "password": loginPasswordController.value.text,
      "isSocial": false,
      "fcmToken": null
    };
    var response = await ApiClient.postData(ApiUrl.login, jsonEncode(body));
    if (response.statusCode == 200) {
      loginLoading.value = false;
      refresh();
    ///  showCustomSnackBar(response.body['message']!, isError: false);

      if(response.body["data"]["isEmailVerified"]==true){

      SharePrefsHelper.setString(AppConstants.bearerToken, response.body["data"]["accessToken"]);

      SharePrefsHelper.setString(AppConstants.userId, response.body["data"]["_id"]);

      SharePrefsHelper.setString(AppConstants.userEmail, response.body["data"]["email"]);
      SharePrefsHelper.setString(AppConstants.fullName, response.body["data"]["fullName"]);

      Get.toNamed(AppRoutes.homeScreen);

      Toast.successToast(response.body['message']!);

      }else{

        Toast.errorToast("Email is not verified..!!");

        Get.toNamed(AppRoutes.verificationEmail_Screen,arguments: [
          {
            "email":loginEmailController.value.text
          }
        ]);

      }

      SocketApi.init();

    } else {

      loginLoading.value = false;
      refresh();
      if (response.statusText == ApiClient.somethingWentWrong) {
        showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        return;
      } else {
        ApiChecker.checkApi(response);
        return;
      }
    }
  }


}

class UserModel {
  final String email;
  final String screenName;
  UserModel(this.email, this.screenName);
}
