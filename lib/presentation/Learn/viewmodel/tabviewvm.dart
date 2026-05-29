import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/audios/audiolist/audiolist.dart';
import '../view/notes/notelist/notelist.dart';
import '../view/typed_notes/typednotelist.dart';
import '../view/videos/videolist/videolist.dart';

class Tabviewvm extends GetxController {
  RxString selectedTab = 'Videos'.obs;
  List<String> tabs = ['Videos', 'Audios', 'Photos', 'Notes'];
  void updateselection(String tab) {
    selectedTab.value = tab;
  }

  Widget getpage() {
    if (selectedTab.value == 'Videos') {
      return const VideoList();
    } else if (selectedTab.value == 'Audios') {
      return const Audiolist();
    } else if (selectedTab.value == 'Photos') {
      return const NoteList();
    } else {
      return const Typednotelist();
    }
  }
}
