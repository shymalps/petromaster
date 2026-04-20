import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/config/theme/text.dart';


class AnimatedSplashScreen extends StatefulWidget {
  final Color background;
  final Color foregroundcolor;
  final String logo;
  final String brandname;
  final Color brandnamecolor;
  final String companyname;

  const AnimatedSplashScreen(
      {super.key,
      required this.background,
      required this.foregroundcolor,
      required this.logo,
      required this.brandname,
      this.brandnamecolor = Colors.black,
      this.companyname = ''});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Get screen size and adjust layout
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          // Define logo size based on screen size
          // double logoSize = screenWidth > 600 ? 180 : 120; /// Large size for tablets/desktop, small for phones
          // Define padding and spacing based on screen size
          double horizontalPadding = screenWidth > 600
              ? 180
              : 130; // Larger padding for larger screens
          double verticalSpacing =
              screenHeight > 600 ? 30 : 20; // More spacing for larger screens

          return Container(
            decoration: BoxDecoration(
              color: widget.background,
              // gradient: widget.background
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: CircleAvatar(
                            backgroundColor: widget.foregroundcolor,
                          )
                              .animate()
                              .slideY(
                                  begin: -0.5, end: 0.2, duration: 0.5.seconds)
                              .then(delay: 1.milliseconds)
                              .slideY(end: -0.3, duration: 0.5.seconds)
                              .then(delay: 1.milliseconds)
                              .slideY(end: 0.1, duration: 0.5.seconds)
                              .then(delay: 0.1.seconds)
                              .scaleXY(end: 20, duration: 2.seconds)
                              .then(delay: 2.seconds),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              // height: Dimension.container115,
                              height: 250,
                              child: Image(image: AssetImage(widget.logo))
                                  .animate()
                                  .fadeIn(
                                      delay: 2.seconds,
                                      duration: 900.milliseconds)
                                  .slideX(begin: 3, duration: 0.5.seconds),
                            ),
                            SizedBox(height: verticalSpacing * 2),
                            AppTextHelper.caption(
                                    text: widget.brandname,
                                    fcolor: widget.brandnamecolor)
                                .animate()
                                .fadeIn(
                                  delay: 3.seconds,
                                  duration: 900.milliseconds,
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(children: [
                    widget.companyname == ''
                        ? AppTextHelper.caption(text: '')
                        : AppTextHelper.caption(
                                text: 'Powered By',
                                fcolor: Colors.white)
                            .animate()
                            .fadeIn(
                                delay: 2.5.seconds, duration: 900.milliseconds),
                    AppTextHelper.caption(
                            text: widget.companyname,
                            fontWeight: FontWeight.bold)
                        .animate()
                        .fadeIn(delay: 2.5.seconds, duration: 900.milliseconds),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
