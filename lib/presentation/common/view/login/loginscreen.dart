import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/res/assets/images.dart';
import '../../controller/loginctrl.dart';
import 'src/loginform.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginVM = Get.find<LoginVM>();
    List<String> bgImg = [
      AppImages.loginbg1,
      AppImages.loginbg2,
      AppImages.loginbg3,
      AppImages.loginbg4
    ];
    final random = Random();
    int randomIndex = random.nextInt(bgImg.length);
    // String randomBgImg = bgImg[randomIndex];

    return Scaffold(
      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImg[randomIndex]),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Loginform(loginVM: loginVM),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
