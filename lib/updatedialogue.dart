import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/config/theme/colors.dart';

// ──────────────────────────────────────────────────────────────────────────────
// 🔧 Change this to your actual Play Store / App Store URL
// ──────────────────────────────────────────────────────────────────────────────
const String _playStoreUrl =
    'https://play.google.com/store/apps/details?id=com.alpts.petromaster';
const String _appStoreUrl =
    'https://apps.apple.com/app/id6764496792';
// ──────────────────────────────────────────────────────────────────────────────

class UpdateDialog extends StatelessWidget {
  final String currentVersion;

  /// If [forceUpdate] is true, the "Later" button is hidden and the dialog
  /// cannot be dismissed by tapping outside.
  final bool forceUpdate;

  const UpdateDialog({
    super.key,
    required this.currentVersion,
    this.forceUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Prevent back-button dismiss when forcing update
      canPop: !forceUpdate,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _DialogContent(
          currentVersion: currentVersion,
          forceUpdate: forceUpdate,
        ),
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  final String currentVersion;
  final bool forceUpdate;

  const _DialogContent({
    required this.currentVersion,
    required this.forceUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Orange header ─────────────────────────────────────────────────
          _Header(),

          // ── Body ──────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                Text(
                  'A new version of Petromaster is ready!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Current version chip
                _VersionChip(
                  label: 'Current Version',
                  version: 'v$currentVersion',
                  backgroundColor: Colors.grey.shade100,
                  textColor: Colors.grey.shade600,
                ),

                const SizedBox(height: 24),

                // Update Now button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _openStore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.system_update_rounded, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Update Now',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Later button (hidden if force update)
                if (!forceUpdate) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey.shade500,
                      ),
                      child: const Text(
                        'Later',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openStore() async {
    // Try Play Store first, fall back to App Store
    final uri = Uri.parse(
      Theme.of(Get.context!).platform == TargetPlatform.iOS
          ? _appStoreUrl
          : _playStoreUrl,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.85),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Animated update icon
       
          // const SizedBox(height: 8),
          const Text(
            'Update Available',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _VersionChip extends StatelessWidget {
  final String label;
  final String version;
  final Color backgroundColor;
  final Color textColor;

  const _VersionChip({
    required this.label,
    required this.version,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: textColor.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            version,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}