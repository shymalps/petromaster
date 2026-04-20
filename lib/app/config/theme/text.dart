
import 'package:petromaster/app/config/theme/textstyle.dart';
import 'package:flutter/material.dart';


class AppTextHelper {
  static Text mainHead({
    required String text,
    Color fcolor = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text,
      style: AppTextStyles.mainHeadstyle(
        fcolor: fcolor,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text subHead(
      {required String text,
      Color fcolor = Colors.black,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign? textAlign,
      TextOverflow? overflow,
      int? maxLines}) {
    return Text(
      text,
      style:
          AppTextStyles.subHeadstyle(fcolor: fcolor, fontWeight: fontWeight),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static Text caption(
      {required String text,
      Color fcolor = Colors.black,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign? textAlign,
      TextOverflow? overflow,
      int? maxLines}) {
    return Text(
      text,
      style: AppTextStyles.captionstyle(fcolor: fcolor, fontWeight: fontWeight),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
  static Text button(
      {required String text,
      Color fcolor = Colors.black,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign? textAlign,
      TextOverflow? overflow = TextOverflow.ellipsis,
      int? maxLines}) {
    return Text(
      text,
      style:
          AppTextStyles.subHeadstyle(fcolor: fcolor, fontWeight: fontWeight),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
