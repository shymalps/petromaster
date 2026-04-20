import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

void customDialouge(context, QuickAlertType type, String title, String text) {
  QuickAlert.show(
    disableBackBtn: true,
    context: context,
    type: type,
    title: title,
    text: text,
  );
}

Future<bool> showConfirmationDialog(BuildContext context,
    {required String title,
    required String text,
    required bool singleButton}) async {
  final completer = Completer<bool>();

  await QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    title: title,
    text: text,
    confirmBtnColor: Colors.green,
    onConfirmBtnTap: () {
      if (!completer.isCompleted) {
        completer.complete(true);
        Navigator.pop(context);
      }
      // return false; // Prevent automatic pop
    },
    onCancelBtnTap: () {
      if (!completer.isCompleted) {
        completer.complete(false);
        Navigator.pop(context);
      }
      // return false; // Prevent automatic pop
    },
  );

  return await completer.future;
}
//?===========> Alert Types
//QuickAlertType.success
//QuickAlertType.error
//QuickAlertType.info
//QuickAlertType.warning
//QuickAlertType.confirm
//QuickAlertType.loading