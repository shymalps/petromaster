import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
// import 'package:oyster_lms/app/config/theme/colors.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';
// import 'package:oyster_lms/core/helpers/buttonhelper.dart';

import '../../../../../app/config/routes/route_name.dart';
import '../../../../../app/config/theme/colors.dart';
import '../../../../../app/config/theme/text.dart';
import '../../../../../core/helpers/buttonhelper.dart';

class ModernTimeoutPage extends StatefulWidget {
  @override
  _ModernTimeoutPageState createState() => _ModernTimeoutPageState();
}

class _ModernTimeoutPageState extends State<ModernTimeoutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Illustration
                  SizedBox(
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFEEEE),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const HugeIcon(
                          icon: HugeIcons.strokeRoundedTimer02,
                          color: AppColors.secondary,
                          size: 100,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppTextHelper.mainHead(
                      text: 'You\'re out of time!',
                      fontWeight: FontWeight.w600),
                  const SizedBox(height: 16),
                  AppTextHelper.caption(
                    text:
                        'The exam session has ended automatically.\nYour answers have been submitted.',
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Buttonhelper.normalButton(
                    text: 'View Detailed Results',
                    isLoading: false,
                    onPressed: () {
                      Get.offAllNamed(RouteName.navbar);
                    },
                  ),
                  // Action Button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder for results page - replace with your actual page
