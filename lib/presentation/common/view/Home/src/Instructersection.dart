import 'package:petromaster/core/res/assets/images.dart';
import 'package:flutter/material.dart';

import '../../../../../app/Di/dimensions.dart';

class Instructersection extends StatelessWidget {
  const Instructersection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: Di.screenWidth * 0.5,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                AppImages.dottedimg,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
