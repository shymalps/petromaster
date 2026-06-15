import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:petromaster/core/utils/debuprint.dart';
import 'package:petromaster/domain/repository/version_repo.dart';
import 'package:petromaster/updatedialogue.dart';

class AppUpdateVM extends GetxController {
  final _repo = VersionRepo();

  RxBool isChecking = false.obs;
  String currentVersion = '';

  /// Call this from SplashscreeVM before navigating.
  /// Shows the update dialog and WAITS for user to dismiss it.
  /// Returns true if update popup was shown, false otherwise.
  Future<bool> checkForUpdate() async {
    try {
      isChecking.value = true;

      // 1. Get current app version from pubspec
      final packageInfo = await PackageInfo.fromPlatform();
      currentVersion = packageInfo.version;

      consolePrint(
          '==================> AppUpdateVM: current version = $currentVersion');

      // 2. Hit the API
      final result = await _repo.checkUpdate(currentVersion);

      if (result == null) {
        consolePrint(
            '==================> AppUpdateVM: no result from API, skipping update check');
        return false;
      }

      consolePrint(
          '==================> AppUpdateVM: server says showUpdate = ${result.showUpdate}');

      // 3. Show dialog and WAIT for user action before continuing
      if (result.showUpdate) {
        consolePrint(
            '==================> AppUpdateVM: Update dialog showing');
        await _showUpdateDialog(); // ← await here, navigation blocks until user taps Later/Update
        return true;
      } else {
        consolePrint(
            '==================> AppUpdateVM: Server said hide, skipping dialog');
        return false;
      }
    } catch (e) {
      consolePrint('==================> AppUpdateVM: error - $e');
      return false;
    } finally {
      isChecking.value = false;
    }
  }

  Future<void> _showUpdateDialog() async {
    await Get.dialog(
      UpdateDialog(currentVersion: currentVersion),
      barrierDismissible: false, // user must tap Later or Update Now
    );
  }
}