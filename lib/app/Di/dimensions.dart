import 'package:get/get.dart';

//?====================> App Dimensions
class Di {

  //?==================> Getting Display Size
  static double get screenHeight => Get.context?.height ?? 0.0;
  static double get screenWidth => Get.context?.width ?? 0.0;

  //?==================>Multiple fontsizes
  static double get mainHeadfontsize => screenWidth*0.05;
  static double get subHeadfontsize => screenWidth*0.035;
  static double get buttonfontsize => screenWidth*0.04;
  static double get captionfontsize => screenWidth*0.03;

  //?==================>Button width
  static double get buttonWidth => Di.screenWidth*0.5;

  //?==================>Padding
  static double get sidepadding =>Di.screenWidth*0.04;
  static double smallPadding = width(0.02); // 2% of screen width
  static double mediumPadding = width(0.04); // 4% of screen width
  static double largePadding = width(0.08); 
  // static double get mediumPading =>20;
  // static double get smallPading =>10;
  static double width(double percentage) {
    return screenWidth * percentage;
  }
  static double height(double percentage) {
    return screenHeight * percentage;
  }
}