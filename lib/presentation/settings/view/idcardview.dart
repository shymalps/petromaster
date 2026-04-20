import 'package:petromaster/core/helpers/appbarhelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/controller/profile_controller.dart';

class IDCardWebView extends StatefulWidget {
  const IDCardWebView({Key? key}) : super(key: key);

  @override
  State<IDCardWebView> createState() => _IDCardWebViewState();
}

class _IDCardWebViewState extends State<IDCardWebView> {
  late final WebViewController controller;
  final profiledata = Get.find<Profilevm>();

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString('''
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            background-color: #ceeeff;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .id-card-holder {
            width: 225px;
            padding: 4px;
            margin: 0 auto;
            background-color: #1f1f1f;
            border-radius: 5px;
            position: relative;
        }
        .id-card-holder:after {
            content: '';
            width: 7px;
            display: block;
            background-color: #0a0a0a;
            height: 100px;
            position: absolute;
            top: 105px;
            border-radius: 0 5px 5px 0;
        }
        .id-card-holder:before {
            content: '';
            width: 7px;
            display: block;
            background-color: #0a0a0a;
            height: 100px;
            position: absolute;
            top: 105px;
            left: 222px;
            border-radius: 5px 0 0 5px;
        }
        .id-card {
            background-color: #fff;
            padding: 10px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 0 1.5px 0px #b9b9b9;
        }
        .id-card img {
            margin: 0 auto;
            border-radius: 20%;
        }
        .header > img {
            width: 100px;
            margin-top: 15px;
        }
        .photo img {
            width: 80px;
            height: 80px;
            margin-top: 15px;
        }
        .qr-code > img {
            width: 50px;
        }
        .id-card-hook {
            background-color: black;
            width: 70px;
            margin: 0 auto;
            height: 15px;
            border-radius: 5px 5px 0 0;
        }
        .id-card-hook:after {
            content: '';
            background-color: white;
            width: 47px;
            height: 6px;
            display: block;
            margin: 0px auto;
            position: relative;
            top: 6px;
            border-radius: 4px;
        }
        .id-card-tag-strip {
            width: 45px;
            height: 40px;
            background-color: #0f4866;
            margin: 0 auto;
            border-radius: 5px;
            position: relative;
            top: 9px;
            z-index: 1;
            border: 1px solid #0f4866;
        }
        .id-card-tag-strip:after {
            content: '';
            display: block;
            width: 100%;
            height: 1px;
            background-color: #0f4866;
            position: relative;
            top: 10px;
        }
        .id-card-tag {
            width: 0;
            height: 0;
            border-left: 100px solid transparent;
            border-right: 100px solid transparent;
            border-top: 100px solid #0f4866;
            margin: -10px auto -30px auto;
        }
        .id-card-tag:after {
            content: '';
            display: block;
            width: 0;
            height: 0;
            border-left: 50px solid transparent;
            border-right: 50px solid transparent;
            border-top: 100px solid #ceeeff;
            margin: -10px auto -30px auto;
            position: relative;
            top: -90px;
            left: -50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="id-card-tag"></div>
        <div class="id-card-tag-strip"></div>
        <div class="id-card-hook"></div>
        <div class="id-card-holder">
            <div class="id-card">
                <div class="header">
                    <img src="https://petromasteracademy.com/assets/images/1703147133.jpg">
                </div>
                <p style="font-size: 12px;margin: 2px;"><strong>Petromaster</strong></p>
                <p style="font-size: 8px;margin: 2px;"><strong>Arfa Complex, Opposite FIT, Thaikkatukara PO, Aluva - 683106<br>
                2nd floor, Blue moon Tower, Muringoor, Vadakkummuri, Kerala 680307<br>8848042204</strong></p>
                <div class="photo">
                    <img src="${profiledata.profileData!.profImg}">
                </div>
                <h2 style="font-size: 15px;margin: 5px 0;">${profiledata.profileData!.name}</h2>
                <div class="qr-code"></div>
                <h3 style="font-size: 12px;margin: 2.5px 0;font-weight: 300;">Student</h3>
                <h3 style="font-size: 12px;margin: 2.5px 0;font-weight: 300;">${profiledata.profileData!.dob}</h3>
                <p style="font-size: 8px;margin: 2px;">test ,${profiledata.profileData!.address}</p>
                <p style="font-size: 8px;margin: 2px;">Ph: ${profiledata.profileData!.phone}</p>
            </div>
        </div>
    </div>
</body>
</html>
      ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: 'ID Card'),
      body: WebViewWidget(controller: controller),
    );
  }
}
