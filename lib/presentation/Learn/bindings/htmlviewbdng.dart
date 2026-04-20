import 'package:petromaster/presentation/Learn/viewmodel/typednoteviewervm.dart';
import 'package:get/get.dart';

class Htmlviewerbdng extends Bindings {
  @override
  void dependencies() {
    final data = Get.arguments as Map<String, dynamic>;
    final title = data['title'] as String;
    final content = data['content'] as String;
    Get.put(Htmlviewerctrl(title: title, content: content));
  }
}
