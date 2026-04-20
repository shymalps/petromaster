import 'package:get/get.dart';

import '../viewmodel/topicvm.dart';

class Topicbdng extends Bindings {

  @override
  void dependencies() {
    final subID = Get.arguments;
    Get.put(TopicVM(subjectId: subID));
  }
}