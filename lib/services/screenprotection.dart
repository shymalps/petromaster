import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petromaster/app/config/theme/colors.dart';
import 'package:petromaster/core/utils/debuprint.dart';
import 'package:screen_protector/screen_protector.dart';


/// out), via [ScreenProtector.protectDataLeakageOn].

class ScreenProtectionService {
  static bool _isEnabled = false;


  static Future<void> enable() async {
    print("screen protect enable....  ");
    if (_isEnabled) return;
    print("screen protect enable.... 2  ");
    try {

      if (Platform.isAndroid) {
     
        await ScreenProtector.preventScreenshotOn();
        print("screenshort prevent....");
        consolePrint(
          '🛡️ [ScreenProtection] Android FLAG_SECURE — enabled',
        );
      } else if (Platform.isIOS) {
      
        await ScreenProtector.preventScreenshotOn();
      
        await ScreenProtector.protectDataLeakageOn();
        consolePrint(
          '🛡️ [ScreenProtection] iOS screenshot-block + overlay — enabled',
        );
      }
      _isEnabled = true;
    } catch (e) {
      print("screen protect error....  ");
      print("screen protect error....  $e");
      consolePrint('❌ [ScreenProtection] enable() failed', e.toString());
    }
  }

  static Future<void> disable() async {
    if (!_isEnabled) return;
    try {
      await ScreenProtector.preventScreenshotOff();
      if (Platform.isIOS) {
        await ScreenProtector.protectDataLeakageOff();
      }
      _isEnabled = false;
      consolePrint('🔓 [ScreenProtection] Disabled');
    } catch (e) {
      consolePrint('❌ [ScreenProtection] disable() failed', e.toString());
    }
  }


  static bool get isEnabled => _isEnabled;

  /// Temporarily disables protection, runs [action], then re-enables.
  ///
  /// Useful for pages where a screenshot is acceptable (e.g. ID-card export).
  static Future<void> runWithoutProtection(
    Future<void> Function() action,
  ) async {
    await disable();
    try {
      await action();
    } finally {
      await enable();
    }
  }
}