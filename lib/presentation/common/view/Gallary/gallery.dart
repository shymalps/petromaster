import 'package:petromaster/core/helpers/appbarhelper.dart';
import 'package:flutter/material.dart';

import 'src/stageredview.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbarhelper.pageAppbar(title: 'Gallery', leading: false),
        body: StaggeredGalleryView());
  }
}
