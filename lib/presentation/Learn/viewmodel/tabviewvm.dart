import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/audios/audiolist/audiolist.dart';
import '../view/notes/notelist/notelist.dart';
import '../view/typed_notes/typednotelist.dart';
import '../view/videos/videolist/videolist.dart';

class Tabviewvm extends GetxController {
  RxString selectedTab = 'Notes'.obs;
  List<String> tabs = ['Notes', 'Photos', 'Videos', 'Audios'];
  void updateselection(String tab) {
    selectedTab.value = tab;
  }

  Widget getpage() {
    if (selectedTab.value == 'Notes') {
      return const Typednotelist();
    } else if (selectedTab.value == 'Photos') {
      return const NoteList();
    } else if (selectedTab.value == 'Videos') {
      return const VideoList();
    } else {
      return const  Audiolist();
    }
  }
}
