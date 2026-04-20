import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimension {
  static double get screenHeight => Get.context?.height ?? 0.0;
  static double get screenWidth => Get.context?.width ?? 0.0;

  ///Container

  static double pageViewContainer = screenHeight / 4.16;
  static double pageViewContainerBig = screenHeight / 2.8;
  static double textViewContainer = screenHeight / 7.05;
  static double iconContainer40 = screenHeight / 22.9;
  static double container125 = screenHeight / 7.336;
  static double container120 = screenHeight / 7.641;
  static double container115 = screenHeight / 7.973;
  static double container350 = screenHeight / 2.62;

  ///radius

  static double radius30 = screenHeight / 30.5;
  static double radius15 = screenHeight / 61.13;
  static double radius20 = screenHeight / 45.85;

  ///fontSize

  static double bigFontSize = screenHeight / 47.6;
  static double smallFontSize = screenHeight / 19.5;
  static double fontSize18 = screenHeight / 50.9;
  static double fontSize26 = screenHeight / 35.26;
  static double fontSize15 = screenHeight / 61.13;

  /// Font size common

  static final double mainHeadingFontSize =
      screenHeight / 25; // ~32 sp for a 800px height screen
  static final double secondaryHeadingFontSize =
      screenHeight / 30; // ~26.6 sp for a 800px height screen
  static final double tertiaryHeadingFontSize =
      screenHeight / 40; // ~22.8 sp for a 800px height screen
  static final double bodyTextFontSize =
      screenHeight / 50; // ~16 sp for a 800px height screen
  static final double secondaryBodyTextFontSize =
      screenHeight / 60; // ~13.3 sp for a 800px height screen
  static final double captionFontSize =
      screenHeight / 70; // ~11.4 sp for a 800px height screen
  static final double buttonTextFontSize =
      screenHeight / 45; // ~16 sp for a 800px height screen
  static final double smallPrintFontSize =
      screenHeight / 80; // ~10 sp for a 800px height screen

  static TextStyle mainHeadingStyle =
      TextStyle(fontSize: mainHeadingFontSize, fontWeight: FontWeight.bold);
  static TextStyle secondaryHeadingStyle = TextStyle(
      fontSize: secondaryHeadingFontSize, fontWeight: FontWeight.bold);
  static TextStyle tertiaryHeadingStyle =
      TextStyle(fontSize: tertiaryHeadingFontSize, fontWeight: FontWeight.bold);
  static TextStyle bodyTextStyle = TextStyle(fontSize: bodyTextFontSize);
  static TextStyle secondaryBodyTextStyle =
      TextStyle(fontSize: secondaryBodyTextFontSize);
  static TextStyle captionStyle =
      TextStyle(fontSize: captionFontSize, color: Colors.grey);
  static TextStyle buttonTextStyle =
      TextStyle(fontSize: buttonTextFontSize, fontWeight: FontWeight.bold);
  static TextStyle smallPrintStyle =
      TextStyle(fontSize: smallPrintFontSize, color: Colors.grey);

  ///Icon Size

  static double iconSize = screenHeight / 74.41;
  static double iconSize20 = screenHeight / 45.85;

  ///Sized Box

  static double sizedBox20 = screenHeight / 45.85;
  static double sizedBox10 = screenHeight / 91.7;
  static double sizedBox15 = screenHeight / 61.13;
  static double sizedBox5 = screenHeight / 183.4;
  static double sizedBox30 = screenHeight / 30.56;
  static double sizedBox12 = screenHeight / 76.41;

  ///Padding

  static double padding20 = screenHeight / 45.85;
  static double padding15 = screenHeight / 61.13;
  static double padding8 = screenHeight / 114.62;
  static double padding10 = screenHeight / 91.7;
  static double padding12 = screenHeight / 76.41;
  static double padding4 = screenHeight / 229.25;

  ///Margin

  static double margin50 = screenHeight / 18.34;
  static double margin12 = screenHeight / 76.41;
  static double margin8 = screenHeight / 114.62;
  static double margin10 = screenHeight / 91.7;
  static double margin4 = screenHeight / 229.25;
  static double margin15 = screenHeight / 61.13;
  static double margin20 = screenHeight / 45.85;

  /// Button Height
  static double buttonHeight =
      screenHeight / 17.3; // Approx. 56dp for a standard 800px height screen

  /// Input Field Height
  static double inputFieldHeight =
      screenHeight / 12.5; // Approx. 48dp for a standard 800px height screen

  /// Card Height
  static double cardHeight = screenHeight / 5.6; // Responsive card height

  /// Icon Size
  static double iconSize24 = screenHeight / 38.2; // Responsive icon size

  /// AppBar Height
  static double appBarHeight =
      screenHeight / 12.0; // Approx. 56dp for a standard 800px height screen

  /// TabBar Height
  static double tabBarHeight =
      screenHeight / 15.0; // Approx. 48dp for a standard 800px height screen

  /// Drawer Width
  static double drawerWidth = screenWidth / 1.5; // Responsive drawer width

  /// Bottom Navigation Bar Height
  static double bottomNavBarHeight =
      screenHeight / 10.0; // Approx. 56dp for a standard 800px height screen

  /// Floating Action Button Size
  static double fabSize =
      screenHeight / 12.0; // Approx. 56dp for a standard 800px height screen

  /// Dialog Height
  static double dialogHeight = screenHeight / 2.5; // Responsive dialog height

  /// Toast Height
  static double toastHeight =
      screenHeight / 20.0; // Approx. 48dp for a standard 800px height screen
}