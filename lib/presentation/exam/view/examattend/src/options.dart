import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/core/utils/debuprint.dart';
// import 'package:oyster_lms/presentation/exam/viewmodel/examattendvm.dart';

import '../../../../../app/config/theme/colors.dart';
import '../../../../../app/config/theme/text.dart';
import '../../../../../core/utils/debuprint.dart';
import '../../../viewmodel/examattendvm.dart';

class OptionsView extends StatelessWidget {
  OptionsView({
    super.key,
    required this.options,
  });
  final List<String> options;
  final examattendVM = Get.find<Examattendvm>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _buildOption(
                0, 'A', options[0], examattendVM.selectedoption.value == 'A'),
            const SizedBox(height: 12),
            _buildOption(
                1, 'B', options[1], examattendVM.selectedoption.value == 'B'),
            const SizedBox(height: 12),
            _buildOption(
                2, 'C', options[2], examattendVM.selectedoption.value == 'C'),
            const SizedBox(height: 12),
            _buildOption(
                3, 'D', options[3], examattendVM.selectedoption.value == 'D'),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index, String letter, String text, bool isSelected) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        consolePrint('index $letter');
        examattendVM.updateselection(letter);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE5E7EB),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? AppColors.primary : const Color(0xFFD1D5DB),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: AppTextHelper.subHead(
                  text: letter,
                  fontWeight: FontWeight.bold,
                  fcolor: isSelected ? Colors.white : const Color(0xFF6B7280),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppTextHelper.subHead(
                text: text,
                fontWeight: FontWeight.w600,
                fcolor: const Color(0xFF1F2937),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
