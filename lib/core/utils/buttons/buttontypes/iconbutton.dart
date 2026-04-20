import 'package:flutter/material.dart';

import '../../../../app/Di/dimensions.dart';
import '../../../../app/config/theme/colors.dart';
import '../../../../app/config/theme/text.dart';


class IconwithButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isLoading;
  const IconwithButton(
      {super.key,
      required this.text,
      required this.isLoading,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Di.buttonWidth,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          AppTextHelper.button(text: text, fcolor: AppColors.white),
        ],
      ),
    );
  }
}
