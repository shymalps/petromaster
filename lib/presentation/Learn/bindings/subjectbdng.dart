import 'package:get/get.dart';

import '../viewmodel/subjectvm.dart';

class Subjectbdng extends Bindings {
  @override
  void dependencies() {
    Get.put(SubjectVM());
  }
}