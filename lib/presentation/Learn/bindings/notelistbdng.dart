import 'package:get/get.dart';

import '../viewmodel/notelistvm.dart';

class Notelistbdng extends Bindings {
  @override
  void dependencies() {
    final topicId = Get.arguments;
    Get.put(Notelistvm(topicId: topicId));
  }
}