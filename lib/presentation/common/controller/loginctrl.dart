import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petromaster/services/devicesecurityservice.dart';

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
  // ─────────────────────────────────────────────────────────────────────────
  // Lifecycle
  // ─────────────────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _loadSavedUsername();
    consolePrint('==================> Login Controller Initialized');
  }

  @override
  void dispose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    consolePrint('==================> Login Controller Closed');
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Dependencies
  // ─────────────────────────────────────────────────────────────────────────

  final _profileVM = Get.find<Profilevm>();
  final _api = LoginRepo();

  // ─────────────────────────────────────────────────────────────────────────
  // State
  // ─────────────────────────────────────────────────────────────────────────

  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool obscurePassword = true.obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  // ─────────────────────────────────────────────────────────────────────────
  // Username persistence
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _loadSavedUsername() async {
    final saved = await AuthPreferences.getRememberedUsername();
    emailController.value.text = saved ?? '';
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Save login state & navigate home
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _saveAndNavigate(LoginModel userModel) async {
    consolePrint('💾 [LoginVM] Saving login state…');
    await AuthPreferences.setLoggedIn(true);
    await AuthPreferences.setOnboarded(true);
    await AuthPreferences.setUserId(userModel.userId.toString());
    await AuthPreferences.setstuId(userModel.studentId.toString());
    await AuthPreferences.setclassId(userModel.classId.toString());
    await AuthPreferences.setRememberedUsername(emailController.value.text);

    await _profileVM.getProfile();

    if (_profileVM.profileData != null) {
      consolePrint('✅ [LoginVM] Profile loaded — navigating to NavBar');
      Get.offAllNamed(RouteName.navbar);
    } else {
      await AuthPreferences.logout();
      Get.offAllNamed(RouteName.appnav);
      Dialougehelper.warning(
        Get.context,
        'Profile Issue',
        'Unable to load your profile. Please log out and try again.',
      );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Main login flow
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      consolePrint('⚠️ [LoginVM] Form validation failed');
      return;
    }

    isLoading.value = true;

    try {
      // ── Step 1: Authenticate ─────────────────────────────────────────────
      consolePrint('🔐 [LoginVM] Step 1 — Authenticating…');
      final loginResponse = await _api.loginApi({
        'username': emailController.value.text,
        'password': passwordController.value.text,
      });

      if (!ApiResponseHelper.isSuccess(loginResponse)) {
        _showMessage('Login Failed', ApiResponseHelper.message(loginResponse));
        return;
      }

      final userData = ApiResponseHelper.mapData(loginResponse);
      if (userData == null || userData.isEmpty) {
        _showMessage('Login Failed', 'Invalid response from server.');
        return;
      }

      final userModel = LoginModel.fromJson(userData);
      consolePrint('✅ [LoginVM] Step 1 complete — user: ${userModel.userId}');

      // ── Step 2: Load admin profile (security settings) ───────────────────
      consolePrint('⚙️ [LoginVM] Step 2 — Loading admin security profile…');
      final adminResponse = await _api.getloginmode();

      if (!ApiResponseHelper.isSuccess(adminResponse)) {
        _showMessage('Configuration Error', ApiResponseHelper.message(adminResponse));
        return;
      }

      final adminData = ApiResponseHelper.mapData(adminResponse);
      if (adminData == null || adminData.isEmpty) {
        _showMessage('Configuration Error', 'Unable to load security settings.');
        return;
      }

      final adminProfile = AdminProfile.fromJson(adminData);
      consolePrint('✅ [LoginVM] Step 2 complete — secureMod: ${adminProfile.secureMod}');

      // ── Step 3: Device security check ────────────────────────────────────
      await _runDeviceSecurityCheck(
        userModel: userModel,
        adminProfile: adminProfile,
      );
    } catch (e, stack) {
      consolePrint('❌ [LoginVM] Unexpected error', e.toString());
      consolePrint('Stack', stack.toString());
      _showMessage('Warning', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Device security check — same logic as RN Plus, same popup style
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _runDeviceSecurityCheck({
    required LoginModel userModel,
    required AdminProfile adminProfile,
  }) async {
    // Non-mobile platforms — skip
    if (!Platform.isAndroid && !Platform.isIOS) {
      consolePrint('ℹ️ [DeviceSecurity] Non-mobile — skipping check');
      await _saveAndNavigate(userModel);
      return;
    }

    // Admin set secure_mod = 'none' — skip device check
    if (adminProfile.secureMod.toLowerCase().trim() == 'none') {
      consolePrint('ℹ️ [DeviceSecurity] secureMod=none — skipping check');
      await _saveAndNavigate(userModel);
      return;
    }

    consolePrint('🔒 [DeviceSecurity] Enforcing — secureMod: ${adminProfile.secureMod}');

    // Get this device's ID
    final String currentDeviceId;
    try {
      currentDeviceId = await DeviceSecurityService.getDeviceId();
    } catch (e) {
      consolePrint('❌ [DeviceSecurity] Cannot get device ID', e.toString());
      _showMessage('Warning', 'Unable to identify your device. Please restart the app.');
      return;
    }

    final result = DeviceSecurityService.checkDevice(
      registeredDeviceId: userModel.deviceId,
      currentDeviceId: currentDeviceId,
    );

    switch (result) {

      // First login on this account — register this device
      case DeviceCheckResult.notRegistered:
        consolePrint('📲 [DeviceSecurity] No device on record — registering…');
        try {
          await _api.storedeviceId(currentDeviceId, userModel.userId.toString());
          consolePrint('✅ [DeviceSecurity] Device ID stored');
        } catch (e) {
          consolePrint('⚠️ [DeviceSecurity] Store failed (non-fatal)', e.toString());
        }
        await _saveAndNavigate(userModel);
        break;

      // Same device — allow
      case DeviceCheckResult.matched:
        consolePrint('✅ [DeviceSecurity] Device verified — logging in');
        await _saveAndNavigate(userModel);
        break;

      // Different device — block, show Warning popup (same style as RN Plus)
      case DeviceCheckResult.mismatch:
        consolePrint('🚫 [DeviceSecurity] Device mismatch — login blocked');
        _showMessage('Warning', 'please login with your previous device');
        break;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Warning popup — exact same style as RN Plus showMessage()
  // ─────────────────────────────────────────────────────────────────────────

  void _showMessage(String title, String msg) {
    if (Get.context == null) return;
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Validation
  // ─────────────────────────────────────────────────────────────────────────

  String? emailvalidation(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordvalidation(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}