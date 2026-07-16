import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../../../app/config/routes/route_name.dart';
import '../../../../../app/config/theme/text.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';

class ExamViolationScreen extends StatefulWidget {
  const ExamViolationScreen({
    super.key,
  });

  @override
  State<ExamViolationScreen> createState() => _ExamViolationScreenState();
}

class _ExamViolationScreenState extends State<ExamViolationScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated header
              _buildHeader(theme, isDark),
              const SizedBox(height: 32),
              _buildViolationCard(theme, isDark),
              const SizedBox(height: 24),
              _buildActionButton(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isDark) {
    return Column(
      children: [
        Icon(
          Icons.warning_rounded,
          size: 72,
          color: Colors.red[600],
        ).animate().shake(duration: 600.ms).then(delay: 300.ms).scale(
              begin: const Offset(1, 1),
            ),
        const SizedBox(height: 16),
        AppTextHelper.mainHead(
          text: 'Exam Terminated',
          fontWeight: FontWeight.bold,
          fcolor: Colors.red[600] ?? Colors.red,
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 200.ms)
            .slide(begin: const Offset(0, -0.1)),
        AppTextHelper.subHead(
          text: 'Rule Violation Detected',
          fontWeight: FontWeight.w600,
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 400.ms)
            .slide(begin: const Offset(0, -0.1)),
      ],
    );
  }

  Widget _buildViolationCard(ThemeData theme, bool isDark) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: isDark ? Colors.grey[850] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: isDark ? Colors.orange[300] : Colors.red[600],
                ),
                const SizedBox(width: 12),
                AppTextHelper.subHead(
                  text: 'App Switching Detected',
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextHelper.caption(
              text:
                  'You switched to another application during the exam, which violates the exam rules.As a result, your exam has been terminated and your answers will not be graded.',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings_rounded,
                    color: isDark ? Colors.orange[300] : Colors.red[600],
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                      child: AppTextHelper.caption(
                    text:
                        'The administrator has been notified about this violation.',
                    fcolor: Colors.red[600] ?? Colors.red,
                    fontWeight: FontWeight.bold,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slide(
          begin: const Offset(0.2, 0),
        );
  }

  Widget _buildActionButton(ThemeData theme) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        backgroundColor: theme.colorScheme.errorContainer,
        foregroundColor: theme.colorScheme.onErrorContainer,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        // Reset system UI to normal mode BEFORE navigating,
        // so the dashboard navbar safe area renders correctly.
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
        Get.offAllNamed(RouteName.navbar);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home_rounded),
          const SizedBox(width: 12),
          AppTextHelper.button(text: 'Go to Home', fcolor: Colors.red[600] ?? Colors.red),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 1000.ms).slide(
          begin: const Offset(0, 0.2),
        );
  }

  @override
  void dispose() {
    // Do NOT call SystemChrome.setEnabledSystemUIMode(edgeToEdge) here.
    // Doing so in dispose() causes the bottom navbar safe area to disappear
    // on the dashboard screen after navigation.
    super.dispose();
  }
}