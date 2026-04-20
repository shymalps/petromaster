import 'package:flutter/material.dart';

import '../../helpers/toasthelper.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget button;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.isLoading = false, 
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        if (!isLoading) {
          onPressed();
        }else{
          ToastHelper.infoToast(context, title: 'Please wait', desc: 'Loading...');
        }
      },
      child: button);
  }
}

