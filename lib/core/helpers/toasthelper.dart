// import 'package:oyster_lms/core/utils/toast/toastmodel.dart';
import 'package:toastification/toastification.dart';

import '../utils/toast/toastmodel.dart';

class ToastHelper {
  static void successToast(context,
      {required String title, required String desc}) {
    ToastificationType type = ToastificationType.success;
    showToastmodel(context, type, title, desc);
  }

  static void infoToast(context,
      {required String title, required String desc}) {
    ToastificationType type = ToastificationType.info;
    showToastmodel(context, type, title, desc);
  }

  static void errorToast(context,
      {required String title, required String desc}) {
    ToastificationType type = ToastificationType.error;
    showToastmodel(context, type, title, desc);
  }

  static void warningToast(context,
      {required String title, required String desc}) {
    ToastificationType type = ToastificationType.warning;
    showToastmodel(context, type, title, desc);
  }
}