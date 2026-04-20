import 'dart:io';

import 'package:petromaster/presentation/common/controller/categoryvm.dart';
import 'package:petromaster/presentation/common/controller/studentresponcecontroller.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:petromaster/presentation/common/view/Home/home_page.dart';
import 'package:petromaster/presentation/common/view/Home/src/courselist.dart';
import 'package:petromaster/presentation/common/view/Splashscren/splashscreen.dart';

import 'app/config/localization/languages.dart';
import 'app/config/routes/routes.dart';
import 'app/config/theme/colors.dart';
import 'core/utils/debuprint.dart';

import 'presentation/common/controller/profile_controller.dart';
import 'presentation/shared/view/custom_flutter_error copy.dart';
import 'presentation/shared/view/network_not_found.dart';
import 'presentation/shared/viewmodel/network_viewmodel.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
Get.put(GetStudentResponseController(), permanent: true); 

  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Profilevm(), permanent: true);
  Get.put(NetworkController(), permanent: true);
  Get.put(CategoryVM());

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    consolePrint("Flutter Error Caught", errorDetails.exception.toString());
    return CustomFlutterErrorWidget(
      errorDetails: errorDetails,
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  secureScreen() async {
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    // await FlutterWindowManager.addFlags(
    //     FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // ShorebirdViewmodel().checkForUpdates(context);
    secureScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Petromaster',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home:CourseGrids() ,
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      getPages: AppRoutes.routes,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              child ?? const SizedBox.shrink(),
              const NetworkNotFound(),
            ],
          ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
