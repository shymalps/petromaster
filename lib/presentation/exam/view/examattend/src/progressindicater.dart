import 'package:flutter/material.dart';

import '../../../../../app/config/theme/colors.dart';
import '../../../../../app/config/theme/text.dart';
import 'timer.dart';

class ProgressIndicater extends StatelessWidget {
  const ProgressIndicater({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions, 
    required this.onTimerFinish, required this.minutes,
  });

  final int currentQuestion;
  final int totalQuestions;
  final int minutes;
  final Function(bool) onTimerFinish;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextHelper.subHead(
                text: 'Question $currentQuestion/$totalQuestions',
                fontWeight: FontWeight.w600),
            const SizedBox(width: 48),
            CountdownTimer(
              time: minutes,
              onTimerFinish: onTimerFinish,
            ), // Balance the header
          ],
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: currentQuestion / totalQuestions,
          backgroundColor: const Color(0xFFE0E7FF),
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
