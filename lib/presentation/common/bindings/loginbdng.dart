import 'package:get/get.dart';

import '../controller/loginctrl.dart';


class Loginbdng extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginVM());
  }
}