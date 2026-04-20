import 'package:get/get.dart';

import '../viewmodel/examattendvm.dart';

class Examattendbdng extends Bindings {
  @override
  void dependencies() {
    Get.put(Examattendvm(examid: Get.arguments));
  }
}