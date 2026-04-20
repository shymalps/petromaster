import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/Di/dimensions.dart';
import '../../../app/config/theme/colors.dart';
import '../../../app/config/theme/text.dart';
import '../../../core/res/assets/images.dart';
import '../viewmodel/network_viewmodel.dart';

class NetworkNotFound extends StatelessWidget {
  const NetworkNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isConnected = Get.find<NetworkController>().isConnected.value;
        final isOffline = Get.find<NetworkController>()
            .canShowNoInternetScreen(Get.currentRoute);
        return isConnected
            ? const SizedBox.shrink()
            : isOffline
                ? const SizedBox.shrink()
                : Container(
                    color: AppColors.white,
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          height: Di.screenWidth * 0.75,
                          AppImages.noConection,
                        ),
                        AppTextHelper.mainHead(
                          text: 'Oops...',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: Di.screenHeight * 0.01,
                        ),
                        AppTextHelper.caption(
                            text:
                                'It seems there is something wrong with your internet connection. Please connect to the internet and try again.',
                            textAlign: TextAlign.center),
                        // Container(
                        //   color: AppColors.primary,
                        //   decoration: BoxDecoration(),
                        // )
                      ],
                    ),
                  );
      },
    );
  }
}
