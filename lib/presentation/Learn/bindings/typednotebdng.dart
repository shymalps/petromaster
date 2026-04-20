import 'package:get/get.dart';

import '../viewmodel/typednotevm.dart';

class Typednotebdng extends Bindings {
  @override
  void dependencies() {
    final topicId = Get.arguments;
    Get.put(TypedNotelistvm(topicId: topicId));
  }
}
