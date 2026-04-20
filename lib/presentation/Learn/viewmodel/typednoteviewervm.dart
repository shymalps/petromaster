import 'package:get/get.dart';

class Htmlviewerctrl extends GetxController {
  final String title;
  final String content;
  final String? appBarTitle;
  Htmlviewerctrl({
    required this.title,
    required this.content,
    this.appBarTitle,
  });
}
