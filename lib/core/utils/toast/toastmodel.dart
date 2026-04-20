import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../app/config/theme/text.dart';

void showToastmodel(
    context, ToastificationType type, String title, String desc) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.minimal,
    title: AppTextHelper.caption(text: title, fontWeight: FontWeight.bold),
    description: AppTextHelper.caption(
      text: desc,
    ),
    alignment: Alignment.topLeft,
    autoCloseDuration: const Duration(seconds: 4),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    borderRadius: BorderRadius.circular(12.0),
    showProgressBar: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
