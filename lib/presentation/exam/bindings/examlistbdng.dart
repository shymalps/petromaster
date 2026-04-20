import 'package:get/get.dart';


import '../viewmodel/examlistvm.dart';

class Examlistbdng extends Bindings {
  @override
  void dependencies() {
    Get.put(Examlistvm());
  }
}