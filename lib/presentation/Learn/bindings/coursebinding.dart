import 'package:get/get.dart';

import '../viewmodel/coursedetailvm.dart';

class Coursebinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CoursedetailVM());
  }
}
 