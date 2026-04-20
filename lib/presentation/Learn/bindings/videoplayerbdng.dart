import 'package:get/get.dart';

import '../viewmodel/videoplayervm.dart';

class Videoplayerbdng extends Bindings {
  @override

  void dependencies() {
    final videourl = Get.arguments;
    Get.put(VideoplayerVM(videourl: videourl));
  }
}