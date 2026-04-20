import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final imageurl = Get.arguments;
    return Scaffold(
      body: Center(
        child: _buildImage(imageurl),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      // Network image
      return Image.network(imageUrl);
    } else if (imageUrl.startsWith('file://')) {
      // Local file path
      return Image.file(File(imageUrl.replaceFirst('file://', '')));
    } else {
      // Asset image
      return Image.asset(imageUrl);
    }
  }
}