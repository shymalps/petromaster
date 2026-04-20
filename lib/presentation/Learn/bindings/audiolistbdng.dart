import 'package:get/get.dart';

import '../viewmodel/audiolistvm.dart';

class Audiolistbdng extends Bindings {
  @override
  void dependencies() {
    final topicId = Get.arguments;
    Get.put(Audiolistvm(topicId: topicId));
  }
}
