import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petromaster/app/config/theme/colors.dart';
import 'package:petromaster/core/utils/debuprint.dart';
import 'package:screen_protector/screen_protector.dart';


/// out), via [ScreenProtector.protectDataLeakageOn].

class ScreenProtectionService {
  static bool _isEnabled = false;

  // ─────────────────────────────────────────────────────────────────────────
  // Public API
  // ─────────────────────────────────────────────────────────────────────────

  /// Enables full screen protection.
  ///
  /// Safe to call multiple times — subsequent calls are no-ops.
  static Future<void> enable() async {
    if (_isEnabled) return;
    try {
      if (Platform.isAndroid) {
        // FLAG_SECURE: all screenshots and screen recordings will be black.
        await ScreenProtector.preventScreenshotOn();
        consolePrint(
          '🛡️ [ScreenProtection] Android FLAG_SECURE — enabled',
        );
      } else if (Platform.isIOS) {
        // Step 1 — block static screenshots using UITextField secure trick.
        await ScreenProtector.preventScreenshotOn();
        // Step 2 — overlay a black screen when recording is detected
        //          or the app goes to background (prevents OS preview leak).
        await ScreenProtector.protectDataLeakageOn();
        consolePrint(
          '🛡️ [ScreenProtection] iOS screenshot-block + overlay — enabled',
        );
      }
      _isEnabled = true;
    } catch (e) {
      consolePrint('❌ [ScreenProtection] enable() failed', e.toString());
    }
  }

  /// Disables screen protection.
  ///
  /// Only call this if you explicitly need to allow screenshots (e.g. for
  /// a payment redirect flow that opens a WebView). Re-enable afterwards.
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

  /// Whether screen protection is currently active.
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