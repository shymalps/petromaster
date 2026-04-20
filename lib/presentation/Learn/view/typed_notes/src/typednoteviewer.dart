import 'package:petromaster/core/helpers/appbarhelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../viewmodel/typednoteviewervm.dart';

class HtmlViewer extends StatefulWidget {
  // final String title;
  // final String content;
  // final String? appBarTitle;

  const HtmlViewer({
    super.key,
    // required this.title,
    // required this.content,
    // this.appBarTitle,
  });

  @override
  State<HtmlViewer> createState() => _HtmlViewerState();
}

class _HtmlViewerState extends State<HtmlViewer> {
  late final WebViewController controller;
  final notelistVM = Get.find<Htmlviewerctrl>();
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_buildHtmlContent());
  }

  String _buildHtmlContent() {
    return '''
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  body {
    font-size: 18px;
    line-height: 1.6;
    padding: 10px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  h4 {
    font-size: 22px;
    color: #333;
    margin-bottom: 16px;
  }
  .content {
    color: #444;
    text-align: justify;
  }
</style>
</head>
<body>
  <h4>${notelistVM.title}</h4>
  <div class="content">
    ${notelistVM.content}
  </div>
</body>
</html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(
        title: notelistVM.appBarTitle ?? notelistVM.title,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
