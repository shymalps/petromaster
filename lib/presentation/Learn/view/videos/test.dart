// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_headset_detector/flutter_headset_detector.dart';

// enum HeadsetType { WIRED, WIRELESS }
// enum HeadsetState { CONNECTED, DISCONNECTED }

// class ZoomMeetingScreen extends StatefulWidget {
//   const ZoomMeetingScreen({super.key});

//   @override
//   State<ZoomMeetingScreen> createState() => _ZoomMeetingScreenState();
// }

// class _ZoomMeetingScreenState extends State<ZoomMeetingScreen> {
//   late final WebViewController _controller;
//   bool _meetingEnded = false;
//   bool _permissionsGranted = false;
//   bool _isLoadingPermissions = true;
//   bool _isLoadingHeadset = true;
//   bool _headsetConnected = false;
//   Timer? _meetingCheckTimer;
//   Timer? _headsetCheckTimer;
//   late final HeadsetDetector _headsetDetector;

//   Map<HeadsetType, HeadsetState> _headsetState = {
//     HeadsetType.WIRED: HeadsetState.DISCONNECTED,
//     HeadsetType.WIRELESS: HeadsetState.DISCONNECTED,
//   };

//   bool get isHeadsetConnected {
//     return _headsetState[HeadsetType.WIRED] == HeadsetState.CONNECTED ||
//         _headsetState[HeadsetType.WIRELESS] == HeadsetState.CONNECTED;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initializeHeadsetDetection();
//     _requestPermissions();
//   }

//   @override
//   void dispose() {
//     _meetingCheckTimer?.cancel();
//     _headsetCheckTimer?.cancel();
//     _headsetDetector.removeListener();
//     super.dispose();
//   }

//   Future<void> _initializeHeadsetDetection() async {
//     _headsetDetector = HeadsetDetector();
//     await _updateHeadsetState();

//     // Setup listener
//     _headsetDetector.setListener((event) {
//       _handleHeadsetEvent(event);
//     });

//     // Setup periodic headset check (as backup for unreliable events)
//     headsetCheckTimer = Timer.periodic(const Duration(seconds: 2), () {
//       _updateHeadsetState();
//     });

//     setState(() => _isLoadingHeadset = false);
//   }

//   Future<void> _updateHeadsetState() async {
//     try {
//       final previousConnected = isHeadsetConnected;
//       final currentState = await _headsetDetector.getCurrentState;

//       setState(() {
//         _headsetState = currentState.cast<HeadsetType, HeadsetState>();
//       });

//       // Only handle change if connection status actually changed
//       if (previousConnected != isHeadsetConnected) {
//         _handleHeadsetChange();
//       }
//     } catch (e) {
//       debugPrint('Error checking headset state: $e');
//     }
//   }

//   void _handleHeadsetEvent(HeadsetChangedEvent event) {
//     switch (event) {
//       case HeadsetChangedEvent.WIRED_CONNECTED:
//         setState(() {
//           _headsetState[HeadsetType.WIRED] = HeadsetState.CONNECTED;
//         });
//         break;
//       case HeadsetChangedEvent.WIRED_DISCONNECTED:
//         setState(() {
//           _headsetState[HeadsetType.WIRED] = HeadsetState.DISCONNECTED;
//         });
//         break;
//       case HeadsetChangedEvent.WIRELESS_CONNECTED:
//         setState(() {
//           _headsetState[HeadsetType.WIRELESS] = HeadsetState.CONNECTED;
//         });
//         break;
//       case HeadsetChangedEvent.WIRELESS_DISCONNECTED:
//         setState(() {
//           _headsetState[HeadsetType.WIRELESS] = HeadsetState.DISCONNECTED;
//         });
//         break;
//     }

//     _handleHeadsetChange();
//   }

//   void _handleHeadsetChange() {
//     if (!mounted) return;

//     if (isHeadsetConnected) {
//       // Headset connected
//       if (!_headsetConnected) {
//         setState(() => _headsetConnected = true);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Headset connected - you can join the meeting'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } else {
//       // Headset disconnected
//       if (_headsetConnected) {
//         setState(() => _headsetConnected = false);
//         if (!_meetingEnded) {
//           _endMeeting(reason: 'Headset disconnected - you left the meeting');
//         }
//       }
//     }
//   }

//   Future<void> _requestPermissions() async {
//     Map<Permission, PermissionStatus> permissions = await [
//       Permission.microphone,
//       Permission.camera,
//     ].request();

//     bool allGranted = permissions.values.every(
//           (status) => status == PermissionStatus.granted,
//     );

//     setState(() {
//       _permissionsGranted = allGranted;
//       _isLoadingPermissions = false;
//     });

//     if (allGranted && isHeadsetConnected) {
//       _initializeWebView();
//       _startMeetingCheckTimer();
//     } else if (allGranted && !isHeadsetConnected) {
//       _showHeadsetRequiredDialog();
//     } else {
//       _showPermissionDialog();
//     }
//   }

//   void _showHeadsetRequiredDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Headset Required'),
//           content: const Text(
//             'You must connect headphones to join this meeting for better audio quality and privacy.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop(); // Exit the meeting screen
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _updateHeadsetState(); // Check again
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showPermissionDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Permissions Required'),
//           content: const Text(
//             'This app needs microphone and camera permissions to join Zoom meetings. Please grant these permissions in app settings.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop(); // Exit the meeting screen
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 openAppSettings();
//               },
//               child: const Text('Open Settings'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _requestPermissions(); // Try again
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _initializeWebView() {
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }

//     final WebViewController controller = WebViewController.fromPlatformCreationParams(
//       params,
//       onPermissionRequest: (WebViewPermissionRequest request) {
//         _handleWebViewPermissionRequest(request);
//       },
//     );

//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onNavigationRequest: (request) {
//             return NavigationDecision.navigate;
//           },
//           onUrlChange: (change) {
//             debugPrint('URL changed to: ${change.url}');
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse("https://us05web.zoom.us/wc/join/82484024032"));

//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController androidController =
//       controller.platform as AndroidWebViewController;
//       androidController
//         ..setMediaPlaybackRequiresUserGesture(false)
//         ..setOnShowFileSelector(_androidFileSelectorHandler);
//     }

//     _controller = controller;
//   }

//   Future<void> _handleWebViewPermissionRequest(WebViewPermissionRequest request) async {
//     debugPrint('WebView permission request for: ${request.types}');

//     bool needsMicrophone = request.types.contains(WebViewPermissionResourceType.microphone);
//     bool needsCamera = request.types.contains(WebViewPermissionResourceType.camera);

//     bool hasAppPermissions = true;
//     if (needsMicrophone) {
//       final micStatus = await Permission.microphone.status;
//       hasAppPermissions = hasAppPermissions && micStatus.isGranted;
//     }
//     if (needsCamera) {
//       final cameraStatus = await Permission.camera.status;
//       hasAppPermissions = hasAppPermissions && cameraStatus.isGranted;
//     }

//     if (hasAppPermissions) {
//       await request.grant();
//     } else {
//       await request.deny();
//       if (mounted) {
//         _showWebViewPermissionDialog();
//       }
//     }
//   }

//   void _showWebViewPermissionDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Permission Required'),
//           content: const Text(
//             'Zoom needs access to your microphone and camera to join the meeting. Please enable these permissions.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 openAppSettings();
//               },
//               child: const Text('Open Settings'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<List<String>> _androidFileSelectorHandler(
//       FileSelectorParams params) async {
//     return <String>[];
//   }

//   void _startMeetingCheckTimer() {
//     _meetingCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _checkMeetingStatus();
//     });
//   }

//   Future<void> _checkMeetingStatus() async {
//     final currentUrl = await _controller.currentUrl();
//     debugPrint('Current URL: $currentUrl');

//     if (currentUrl?.contains('zoom.us/postattendee') ?? false) {
//       _endMeeting(reason: 'Meeting has ended');
//     }

//     if (currentUrl?.contains('zoom.us/thankyou') ?? false) {
//       _endMeeting(reason: 'Meeting has ended');
//     }

//     try {
//       final meetingEnded = await _controller.runJavaScriptReturningResult(
//         '''
//         (function() {
//           const endedMessage = document.querySelector('[data-testid="meeting-ended"]') || 
//                                document.querySelector('.meeting-ended') ||
//                                document.querySelector('[aria-label*="meeting has ended"]');
          
//           const isPostMeeting = window.location.href.includes('postattendee') ||
//                                 window.location.href.includes('thankyou') ||
//                                 document.title.toLowerCase().includes('thank you');
          
//           return endedMessage !== null || isPostMeeting;
//         })();
//         ''',
//       );

//       if (meetingEnded.toString() == 'true') {
//         _endMeeting(reason: 'Meeting has ended');
//       }
//     } catch (e) {
//       debugPrint('Error checking meeting status: $e');
//     }
//   }

//   void _endMeeting({String reason = ''}) {
//     if (_meetingEnded) return;

//     setState(() {
//       _meetingEnded = true;
//     });

//     _meetingCheckTimer?.cancel();
//     Navigator.of(context).pop();

//     if (reason.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(reason)),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoadingPermissions || _isLoadingHeadset) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Zoom Meeting'),
//         ),
//         body: const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 16),
//               Text('Checking requirements...'),
//             ],
//           ),
//         ),
//       );
//     }

//     if (!_permissionsGranted) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Zoom Meeting'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.mic_off,
//                 size: 64,
//                 color: Colors.grey,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Microphone and Camera permissions are required',
//                 style: TextStyle(fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Please grant permissions to join the meeting',
//                 style: TextStyle(color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _requestPermissions,
//                 child: const Text('Request Permissions'),
//               ),
//               const SizedBox(height: 8),
//               TextButton(
//                 onPressed: () => openAppSettings(),
//                 child: const Text('Open App Settings'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     if (!isHeadsetConnected) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Zoom Meeting'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.headset_off,
//                 size: 64,
//                 color: Colors.grey,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Headset is required to join this meeting',
//                 style: TextStyle(fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Please connect wired or wireless headphones',
//                 style: TextStyle(color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _updateHeadsetState,
//                 child: const Text('Check Again'),
//               ),
//               const SizedBox(height: 8),
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('Cancel'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Zoom Meeting'),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isHeadsetConnected ? Icons.headset : Icons.headset_off,
//               color: isHeadsetConnected ? Colors.green : Colors.red,
//             ),
//             onPressed: _updateHeadsetState,
//             tooltip: 'Headset Status',
//           ),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () => _endMeeting(reason: 'You left the meeting'),
//             tooltip: 'End Meeting',
//           ),
//         ],
//       ),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }