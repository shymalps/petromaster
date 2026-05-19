import 'dart:async';

import 'package:get/get.dart';

import '../../../AuthPref.dart';
import '../../../app/config/routes/route_name.dart';
import '../../../core/helpers/dialougehelper.dart';
import 'profile_controller.dart';

class SplashscreeVM extends GetxController {
  final profileVM = Get.find<Profilevm>();
  bool isloggedin = false;
  Future<void> checklogin() async {
    isloggedin = await AuthPreferences.isLoggedIn();

    if (isloggedin) {
      await profileVM.getProfile();
      final profileData = profileVM.profileData;
      if (profileData != null) {
        if (profileData.status == '2') {
          await AuthPreferences.logout();
          Get.offAllNamed(RouteName.login);
          Dialougehelper.warning(
            Get.context,
            'Blocked Account',
            'Your account has been blocked. Please contact support for further assistance.',
          );
        } else if (profileData.feeStatus != 'active') {
          Get.offAllNamed(RouteName.login);
          Dialougehelper.warning(
            Get.context,
            'Subscription Expired',
            'Your subscription has expired. Please renew your subscription to continue using our services.',
          );
        } else {
          Timer(
            const Duration(seconds: 4),
            () => Get.offAllNamed(RouteName.navbar), // Fixed
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
      final isOnboarded = await AuthPreferences.isOnboarded();
      Timer(
        const Duration(seconds: 4),
        () => Get.offAllNamed(
          isOnboarded ? RouteName.login : RouteName.appDetails,
        ),
      );
    }
  }
}
