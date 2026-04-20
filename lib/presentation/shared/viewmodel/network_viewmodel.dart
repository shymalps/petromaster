import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:get/get.dart';

import '../../../core/utils/debuprint.dart';


//?=============> Manages the application's network connectivity status.

class NetworkController extends GetxController {
  
  // consolePrint('Error checking initial connectivity',e.toString())
  final RxBool isConnected = true.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  //?==================> A set of route names that are allowed to function offline
  final Set<String> _offlineAccessibleRoutes = {
    "/DownloadedVideosScreen",
  };
  
  @override
  void onInit() {
    super.onInit();
    _initializeConnectivityListener();
    _checkInitialConnection(); 
    consolePrint('==================> Network Controller Initialized',);
  }

  void _initializeConnectivityListener() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }


  Future<void> _checkInitialConnection() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } catch (e) {
      consolePrint('Error checking initial connectivity',e.toString());
      isConnected.value = false;
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    isConnected.value = !results.contains(ConnectivityResult.none);
    consolePrint("Network Status Changed", isConnected.value.toString());
  }

  bool isOfflinePageRoute(String? routeName) {
    if (routeName == null) return false;
    return _offlineAccessibleRoutes.contains(routeName);
  }

  bool canShowNoInternetScreen(String currentRoute) {
    return _offlineAccessibleRoutes.contains(currentRoute);
  }
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    consolePrint('==================> Network Controller Closed',);
    super.onClose();
  }
}
