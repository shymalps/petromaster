import 'package:get/get.dart';

import '../viewmodel/tabviewvm.dart';

class Tabbarbdng extends Bindings {

  @override
  void dependencies() {
    Get.put(Tabviewvm());
  } 
}