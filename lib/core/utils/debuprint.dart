import 'package:flutter/foundation.dart';

void consolePrint(String message, [String? response]) {
  if (kDebugMode) {
    final output =
        response != null ? '$message=============>$response' : message;
    print(output);
  }
}
