import 'package:flutter/material.dart';
// import 'package:oyster_lms/app/config/theme/colors.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';
import '../../../app/Di/dimensions.dart';
import '../../../app/config/theme/colors.dart';
import '../../../app/config/theme/text.dart';
import '../../../core/res/assets/images.dart';

class Emptypage extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const Emptypage({
    super.key,
    this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(Di.screenWidth * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Image.asset(
              AppImages.emptyimg,
              height: Di.screenWidth * 0.4,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: Di.screenWidth * 0.08),

          // Title with gradient text for modern look
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
            ).createShader(bounds),
            child: AppTextHelper.mainHead(
              text: title ?? 'No Data Found',
              fontWeight: FontWeight.bold,
            ),
            // Text(
            //   title ?? 'No Data Found',
            //   style: theme.textTheme.headlineSmall?.copyWith(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 22,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ),

          SizedBox(height: Di.screenWidth * 0.03),

          // Subtitle with softer appearance
          AppTextHelper.caption(
            text: subtitle ?? 'There are no data available ',
            fontWeight: FontWeight.normal,
          ),
          // Text(
          //   subtitle ?? 'There are no data available ',
          //   style: theme.textTheme.bodyMedium?.copyWith(
          //     color: theme.colorScheme.onSurface.withOpacity(0.6),
          //   ),
          //   textAlign: TextAlign.center,
          // ),

          if (buttonText != null) ...[
            SizedBox(height: Di.screenWidth * 0.08),

            // Modern button with gradient
            InkWell(
              onTap: onButtonPressed,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Di.screenWidth * 0.06,
                  vertical: Di.screenWidth * 0.035,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: AppTextHelper.button(
                  text: buttonText!,
                  fcolor: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
