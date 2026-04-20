import 'package:get/get.dart';

class VideoplayerVM extends GetxController {
  final String videourl;
  VideoplayerVM({required this.videourl});


  String getUrl(){
    return videourl;
  }
}