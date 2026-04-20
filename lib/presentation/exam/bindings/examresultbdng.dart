import 'package:get/get.dart';

import '../viewmodel/examresultvm.dart';

class Examresultbdng extends Bindings {
  @override
  void dependencies() {
    Get.put(Examresultvm(examid: Get.arguments));
  }
}