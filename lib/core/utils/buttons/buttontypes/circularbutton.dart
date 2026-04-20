import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../app/config/theme/colors.dart';

class CircularButton extends StatelessWidget {
  final bool isLoading;
  final IconData icon;
  final double radius;
  final Color color;

  const CircularButton({
    super.key,
    required this.isLoading,
    required this.icon,
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: isLoading
          ? SpinKitCircle(
              color: AppColors.white,
              size: radius,
            )
          : Center(
              child: Icon(
                icon,
                color: AppColors.white,
              ),
            ),
    );
  }
}
