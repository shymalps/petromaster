import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  // final String pdfUrl;
  const PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    final String pdfUrl = Get.arguments;
    return  Scaffold(
      body: SfPdfViewer.network(
              pdfUrl)
    );
  }
}