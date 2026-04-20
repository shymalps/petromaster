
import 'package:flutter/material.dart';

import '../../Di/dimensions.dart';
import 'colors.dart';

//?==============>Common fontfamily
const String _fontFamily = 'Roboto';

class AppTextStyles {
//?============>Main Head
  static TextStyle mainHeadstyle({
    required Color fcolor,
    required FontWeight fontWeight,
  }) {
    return _baseStyle(
      fontSize: Di.mainHeadfontsize,
      fontWeight: fontWeight,
      color: fcolor,
    );
  }

//?=============>Sub Head
  static TextStyle subHeadstyle({
    Color fcolor = AppColors.fontcolor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return _baseStyle(
      fontSize: Di.subHeadfontsize,
      fontWeight: fontWeight,
      color: fcolor,
      
    );
  }
//?=============>Button
  static TextStyle button({
    Color fcolor = AppColors.fontcolor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return _baseStyle(
      fontSize: Di.buttonfontsize ,
      fontWeight: fontWeight,
      color: fcolor,
      
    );
  }
//?=============>Caption
  static  TextStyle captionstyle ({
     Color fcolor = AppColors.fontcolor,
    FontWeight fontWeight = FontWeight.normal,
  }){
    return _baseStyle(
    fontSize: Di.captionfontsize,
    fontWeight: FontWeight.normal,
    color: fcolor,
  );
  } 
}

//?====================>Dynamic textstyle widget
TextStyle _baseStyle({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.normal,
  Color color = AppColors.fontcolor, // Default text color
  double? letterSpacing,
  double? height,
  TextDecoration? decoration,
}) {
  return TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
    height: height, // Line height
    decoration: decoration,
  );
}
