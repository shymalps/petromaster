import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:petromaster/core/utils/debuprint.dart';


/// DeviceSecurityService
///
/// Handles device fingerprinting and multi-device prevention.
///
/// How it works
/// ─────────────
/// 1. On first login: the device ID is captured and sent to the server
///    via [LoginRepo.storedeviceId]. It is stored in the user's row.
/// 2. On every subsequent login: the server returns the stored [deviceId]
///    inside [LoginModel]. This service compares it against the current
///    device. If they do not match, login is blocked.
/// 3. The admin can toggle enforcement via [AdminProfile.secureMod]:
///    - `'none'`  → skip device check (open access)
///    - anything else → enforce single-device rule
///
/// Device identifiers used
/// ────────────────────────
/// • Android — `AndroidDeviceInfo.fingerprint`
///   A build-specific string: brand/product/device:release/id/incremental:type/tags
///   Stable across reboots and app reinstalls; changes only on OS/build updates.
///
/// • iOS — `IosDeviceInfo.identifierForVendor`
///   A UUID per (app vendor, device) pair. Persists across app reinstalls
///   when backed up via iCloud. Resets only on full device restore without backup.
class DeviceSecurityService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // ─────────────────────────────────────────────────────────────────────────
  // Device ID
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns the unique ID for the current physical device.
  ///
  /// Throws if [DeviceInfoPlugin] cannot retrieve device information.
  static Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      final id = info.fingerprint.trim();
      consolePrint('📱 [DeviceSecurity] Android device ID: $id');
      return id;
    }

    if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      final id =
          (info.identifierForVendor ?? '').trim().isNotEmpty
              ? info.identifierForVendor!.trim()
              : 'ios-fallback-${DateTime.now().millisecondsSinceEpoch}';
      consolePrint('📱 [DeviceSecurity] iOS device ID: $id');
      return id;
    }

    // Web / Desktop — not enforced
    return 'platform-not-enforced';
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Device name (for error messages)
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns a friendly name for the current device (used in error messages).
  static Future<String> getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return '${_capitalize(info.brand)} ${info.model}';
      }
      if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return '${info.name} (${info.model})';
      }
    } catch (_) {}
    return 'Unknown Device';
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Device check
  // ─────────────────────────────────────────────────────────────────────────

  /// Compares [registeredDeviceId] (from server) with [currentDeviceId]
  /// (from this device) and returns the appropriate [DeviceCheckResult].
  static DeviceCheckResult checkDevice({
    required String? registeredDeviceId,
    required String currentDeviceId,
  }) {
    final registered = registeredDeviceId?.trim() ?? '';

    if (registered.isEmpty) {
      consolePrint(
        '📱 [DeviceSecurity] No device registered — first login on this account.',
      );
      return DeviceCheckResult.notRegistered;
    }

    if (registered == currentDeviceId.trim()) {
      consolePrint('✅ [DeviceSecurity] Device matched.');
      return DeviceCheckResult.matched;
    }

    consolePrint(
      '🚫 [DeviceSecurity] Device mismatch!\n'
      '  Registered : $registered\n'
      '  Current    : $currentDeviceId',
    );
    return DeviceCheckResult.mismatch;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────────────────────────────────

  static String _capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';
}

// ──────────────────────────────────────────────────────────────────────────────
// Result enum
// ──────────────────────────────────────────────────────────────────────────────

/// Outcome of comparing a user's registered device with the current device.
enum DeviceCheckResult {
  /// The user has never logged in before — no device on record.
  /// → Register current device and allow login.
  notRegistered,

  /// Current device matches the registered device.
  /// → Allow login.
  matched,

  /// Current device differs from the registered device.
  /// → Block login and show error.
  mismatch,
}