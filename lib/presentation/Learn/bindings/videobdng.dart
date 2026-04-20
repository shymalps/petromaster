import 'package:get/get.dart';

import '../viewmodel/videolistvm.dart';

class Videobdng extends Bindings {
  @override
  void dependencies() {
    final topicId = Get.arguments;
    Get.put(VideolistVM(topicId: topicId));
  }
}