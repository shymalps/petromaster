import 'package:flutter/material.dart';


import '../../app/config/theme/colors.dart';
import '../utils/buttons/buttonmodel.dart';
import '../utils/buttons/buttontypes/circularbutton.dart';
import '../utils/buttons/buttontypes/iconbutton.dart';
import '../utils/buttons/buttontypes/normalbutton.dart';

enum IconPosition { before, after, none }

class Buttonhelper {
  static Widget circularButton(
          {required VoidCallback onPressed,
          required bool isLoading,
          IconPosition iconPosition = IconPosition.none,
          IconData icon = Icons.arrow_forward,
          Widget? loader}) =>
      CustomButton(
        onPressed: onPressed,
        button: CircularButton(
          icon: icon,
          isLoading: isLoading,
          radius: 20,
          color: AppColors.primary,
        ),
      );

  static Widget normalButton(
          {required String text,
          required VoidCallback onPressed,
          required bool isLoading,
          IconPosition iconPosition = IconPosition.none,
          IconData icon = Icons.arrow_forward,
          Widget? loader}) =>
      Normalbutton(
        text: text,
        isLoading: isLoading,
        onPressed: onPressed,
      );

  static Widget iconbutton(
          {required String text,
          required VoidCallback onPressed,
          required bool isLoading,
          // IconPosition iconPosition = IconPosition.none,
          IconData icon = Icons.arrow_forward,
          Widget? loader}) =>
      CustomButton(
          onPressed: onPressed,
          button: IconwithButton(
            text: text,
            isLoading: false,
            icon: icon,
          ));
}
