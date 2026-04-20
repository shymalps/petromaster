import 'package:get/get.dart';

import '../../common/controller/profile_controller.dart';

class Profilebdng extends Bindings {
  @override
  void dependencies() {
    Get.put(Profilevm());
  }
}
