import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/config/theme/colors.dart';
import '../../../../core/res/assets/images.dart';
import '../../../../packages/src/Alp_animated_splashscreen.dart';
import '../../controller/splashctrl.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SplashscreeVM splashscrenVM = Get.find<SplashscreeVM>();
  @override
  void initState() {
    super.initState();
    splashscrenVM.checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      companyname: 'Alp Turnkey Solutions pvt ltd',
      brandnamecolor: AppColors.secondary,
      background: AppColors.primary,
      foregroundcolor: AppColors.white,
      logo: AppImages.logo,
      brandname: '',
    );
  }
}
