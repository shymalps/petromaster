import 'package:get/get.dart';

import '../controller/categoryvm.dart';

class Catorybdng extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryVM());
  }
}
