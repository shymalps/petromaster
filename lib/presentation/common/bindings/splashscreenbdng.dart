import 'package:get/get.dart';
import '../controller/splashctrl.dart';

class SplashscreenBdng extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashscreeVM());
    // Get.put(ShorebirdViewmodel());
    // Get.put(Profilevm());
  }
}
