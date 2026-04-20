// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:restart_app/restart_app.dart';
// import 'package:shorebird_code_push/shorebird_code_push.dart';


// class ShorebirdViewmodel extends GetxController {
//   final shorebirdCodePush = ShorebirdUpdater();
//   Future<void> checkForUpdates(context) async {
//     final isUpdateAvailable =
//         await shorebirdCodePush.checkForUpdate();
//     if (isUpdateAvailable) {
//       await shorebirdCodePush.downloadUpdateIfAvailable();
//       // AlertDialog(
//       //   title: const Text("Update Available"), // Dialog starts complaining
//       //   content:const Text("There is an higher version available. Click o to download it."),
//       //   actions: [
//       //     TextButton(
//       //       onPressed: () => Navigator.pop(context),
//       //       child: const Text("OK"),
//       //     ),
//       //   ],
//       // );

//       // Dialougehelper.success(context, 'Update Available', 'Update Downloaded');
//       Future.delayed(const Duration(seconds: 2)).then((_) {
//         Restart.restartApp();
//       });
//     } else {
//       // Dialougehelper.success(context, 'Update Available', 'Update Downloaded');
//     }
//   }
// }
