import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/core/helpers/dialougehelper.dart';
// import 'package:oyster_lms/core/utils/debuprint.dart';
// import 'package:oyster_lms/presentation/settings/viewmodel/profilevm.dart';

import '../../../AuthPref.dart';
import '../../../app/config/routes/route_name.dart';
import '../../../core/helpers/dialougehelper.dart';
import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/adnimprofile_model.dart';
import '../../../domain/models/login_model.dart';
import '../../../domain/repository/loginrepo.dart';
import 'profile_controller.dart';

class LoginVM extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadusername();
    consolePrint(
      '==================> Login Controller Initialized',
    );
  }

  final profileVM = Get.find<Profilevm>();

  RxBool obscurePassword = true.obs;

  Future<void> loadusername() async {
    final rememberedUsername = await AuthPreferences.getRememberedUsername();
    emailController.value.text = rememberedUsername ?? '';
  }

  void savelogin(LoginModel usermodel) async {
    consolePrint('usermodel');
    await AuthPreferences.setLoggedIn(true);
    await AuthPreferences.setOnboarded(true);
    await AuthPreferences.setUserId(usermodel.userId.toString());
    await AuthPreferences.setstuId(usermodel.studentId.toString());
    await AuthPreferences.setclassId(usermodel.classId.toString());
    await AuthPreferences.setRememberedUsername(emailController.value.text);
    await profileVM.getProfile();
    if (profileVM.profileData != null) {
      consolePrint('profileVM.profileData!.status');
      consolePrint(profileVM.profileData!.phone);
      consolePrint(profileVM.profileData!.email);
      consolePrint(profileVM.profileData!.name);
      consolePrint(profileVM.profileData!.studentId);
      Get.offAllNamed(RouteName.navbar);
    } else {
      await AuthPreferences.logout();
      Get.offAllNamed(RouteName.appnav);
      Dialougehelper.warning(Get.context, 'Profile Issue',
          'Unable to load your profile. Please log out and login again to continue.');
    }
  }

  //*====================> Variables
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final api = LoginRepo();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  //*====================> Functions
  Future<void> login() async {
    consolePrint('======================>In login VM (function login) Started');
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      Map data = {
        "username": emailController.value.text,
        "password": passwordController.value.text,
      };
      try {
        final response = await api.loginApi(data);
        if (!ApiResponseHelper.isSuccess(response)) {
          Dialougehelper.error(
            Get.context!,
            'Error',
            ApiResponseHelper.message(response),
          );
          return;
        }

        final userData = ApiResponseHelper.mapData(response);
        if (userData == null || userData.isEmpty) {
          Dialougehelper.error(
            Get.context!,
            'Error',
            'Invalid login response received from server',
          );
          return;
        }

        final usermodel = LoginModel.fromJson(userData);
        final response2 = await api.getloginmode();
        consolePrint(response2.toString());
        consolePrint('Died 1');
        if (!ApiResponseHelper.isSuccess(response2)) {
          Dialougehelper.error(
            Get.context!,
            'Error',
            ApiResponseHelper.message(response2),
          );
          return;
        }

        final adminData = ApiResponseHelper.mapData(response2);
        if (adminData == null || adminData.isEmpty) {
          Dialougehelper.error(
            Get.context!,
            'Error',
            'Invalid admin profile response received from server',
          );
          return;
        }

        final adminprofile = AdminProfile.fromJson(adminData);
        consolePrint('Died 12');
        if (Platform.isAndroid) {
          BaseDeviceInfo androidInfo = await DeviceInfoPlugin().deviceInfo;
          String deviceId = androidInfo.data['fingerprint'];
          consolePrint(
              '======================>In login VM (function login) deviceId is $deviceId');
          consolePrint('======================>deviceId is $deviceId ');
          consolePrint(
              '======================>adminprofile.secureMod is ${adminprofile.secureMod}');
          consolePrint(
              '======================>usermodel.deviceId is ${usermodel.deviceId}');
          // if (adminprofile.secureMod == 'none') {
          savelogin(usermodel);
          // } else if (usermodel.deviceId == null || usermodel.deviceId == '') {
          //   await api.storedeviceId(deviceId, usermodel.userId.toString());
          //   savelogin(usermodel);
          // } else if (usermodel.deviceId == deviceId) {
          //   savelogin(usermodel);
          // } else {
          //   Dialougehelper.error(
          //     Get.context!,
          //     'Error',
          //     'Please login with previous device',
          //   );
          // }
        } else if (Platform.isIOS) {
          BaseDeviceInfo iosInfo = await DeviceInfoPlugin().deviceInfo;
          String deviceId = iosInfo.data['identifierForVendor'];
          consolePrint(
              '======================>In login VM (function login) deviceId is $deviceId');
          consolePrint('======================>deviceId is $deviceId ');
          consolePrint(
              '======================>adminprofile.secureMod is ${adminprofile.secureMod}');
          if (adminprofile.secureMod == 'none') {
            savelogin(usermodel);
          } else if (usermodel.deviceId == null || usermodel.deviceId == '') {
            await api.storedeviceId(deviceId, usermodel.userId.toString());
            savelogin(usermodel);
          } else if (usermodel.deviceId == deviceId) {
            savelogin(usermodel);
          } else {
            savelogin(usermodel);
          }
        }
      } catch (e) {
        // Dialougehelper.error(Get.context!, 'Error', e.toString(), );
        consolePrint(
            '======================>In login VM (function login) Error',
            e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      consolePrint(
          '======================>In login VM (function login) Failed');
    }
  }

  //*====================> Validation
  String? emailvalidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordvalidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    consolePrint(
      '==================> Login Controller Closed',
    );
    super.dispose();
  }
}
