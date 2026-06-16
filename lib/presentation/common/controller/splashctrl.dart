import 'dart:async';

import 'package:get/get.dart';
import 'package:petromaster/presentation/common/controller/appupdtevm.dart';

import '../../../AuthPref.dart';
import '../../../app/config/routes/route_name.dart';
import '../../../core/helpers/dialougehelper.dart';

import 'profile_controller.dart';

class SplashscreeVM extends GetxController {
  final _profileVM = Get.find<Profilevm>();


  final _updateVM = AppUpdateVM();

  bool isloggedin = false;

  Future<void> checklogin() async {

    await _updateVM.checkForUpdate();


    isloggedin = await AuthPreferences.isLoggedIn();

    if (isloggedin) {
      await _profileVM.getProfile();
      final profileData = _profileVM.profileData;

      if (profileData != null) {
        if (profileData.status == '2') {
          await AuthPreferences.logout();
          Get.offAllNamed(RouteName.login);
          Dialougehelper.warning(
            Get.context,
            'Blocked Account',
            'Your account has been blocked. Please contact support for further assistance.',
          );
        } else if (profileData.feeStatus.toLowerCase().trim() != 'active') {
          Get.offAllNamed(RouteName.login);
          Dialougehelper.warning(
            Get.context,
            'Subscription Expired',
            'Your subscription has expired. Please renew your subscription to continue using our services.',
          );
        } else {
          Timer(
            const Duration(seconds: 4),
            () => Get.offAllNamed(RouteName.navbar),
          );
        }
      } else {
        await AuthPreferences.logout();
        Get.offAllNamed(RouteName.login);
        Dialougehelper.warning(
          Get.context,
          'Profile Issue',
          'Unable to load your profile. Please log out and login again to continue.',
        );
      }
    } else {
      Timer(
        const Duration(seconds: 4),
        () => Get.offAllNamed(RouteName.appDetails),
      );
    }
  }
}