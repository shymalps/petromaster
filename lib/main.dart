import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petromaster/services/screenprotection.dart';

import 'app/config/localization/languages.dart';
import 'app/config/routes/routes.dart';
import 'app/config/theme/colors.dart';

import 'core/utils/debuprint.dart';
import 'presentation/common/controller/categoryvm.dart';
import 'presentation/common/controller/profile_controller.dart';
import 'presentation/common/controller/studentresponcecontroller.dart';
import 'presentation/shared/view/custom_flutter_error copy.dart';
import 'presentation/shared/view/network_not_found.dart';
import 'presentation/shared/viewmodel/network_viewmodel.dart';

Future<void> main() async {
  // Must be called before any async work
  WidgetsFlutterBinding.ensureInitialized();

  // ── Security: block screenshots and screen recording ───────────────────────
  // Android: FLAG_SECURE — screen is black in all capture tools.
  // iOS: UITextField-secure trick + black overlay on recording/background.
  await ScreenProtectionService.enable();

  // ── Skip bad-certificate checks (keep as-is for your backend) ─────────────
  HttpOverrides.global = MyHttpOverrides();

  // ── Global controllers ─────────────────────────────────────────────────────
  Get.put(GetStudentResponseController(), permanent: true);
  Get.put(Profilevm(), permanent: true);
  Get.put(NetworkController(), permanent: true);
  Get.put(CategoryVM());

  // ── Custom Flutter error widget ────────────────────────────────────────────
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    consolePrint('Flutter Error Caught', errorDetails.exception.toString());
    return CustomFlutterErrorWidget(errorDetails: errorDetails);
  };

  runApp(const MyApp());
}

// ─────────────────────────────────────────────────────────────────────────────

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Re-enable protection whenever the app comes back to foreground.
  // (Covers edge cases where another activity temporarily lifted FLAG_SECURE.)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      consolePrint('♻️ [App] Resumed — re-checking screen protection…');
      ScreenProtectionService.enable();
    }
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

// ─────────────────────────────────────────────────────────────────────────────

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}