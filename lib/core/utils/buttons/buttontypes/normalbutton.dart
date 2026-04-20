import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import '../../../../app/config/theme/colors.dart';
import '../../../../app/config/theme/text.dart';

class Normalbutton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;
  const Normalbutton({super.key, required this.text, required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (!isLoading) {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Center(
          child:isLoading?const SpinKitCircle(
        color: AppColors.white,
        size: 25,
      ):
           AppTextHelper.button(
        text: text,
        fcolor: AppColors.white,
        fontWeight: FontWeight.bold,
      )),
    );
  }
}
