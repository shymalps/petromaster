import 'package:quickalert/models/quickalert_type.dart';

import '../utils/dialogue/dialougemodel.dart';
// import 'package:oyster_lms/core/utils/dialogue/dialougemodel.dart';

class Dialougehelper {
  static void info(context, String title, String message) => customDialouge(
        context,
        QuickAlertType.info,
        title,
        message,
      );
  static void success(context, String title, String message) =>
      customDialouge(context, QuickAlertType.success, title, message);
  static void error(context, String title, String message) =>
      customDialouge(context, QuickAlertType.error, title, message);
  static void warning(context, String title, String message) =>
      customDialouge(context, QuickAlertType.warning, title, message);
  static Future<bool> confirmation(
          context, String title, String message) async =>
      await showConfirmationDialog(
        context,
        title: title,
        text: message,
        singleButton: false,
      );
  
  
}
