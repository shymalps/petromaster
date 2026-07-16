import 'dart:convert';

import 'package:http/http.dart' show get;
import 'package:petromaster/domain/models/appversionmodel.dart';

import '../../core/constant/constants.dart';
import '../../core/utils/debuprint.dart';
import '../endpoints/appendpoints.dart';


class VersionRepo {
  /// Calls the version-check API with the current app version.
  /// Returns [AppVersionModel] with the latest version, or null on failure.
  Future<AppVersionModel?> checkUpdate(String currentVersion) async {
    final url = '${AppEndpoints.checkversion}?version=$currentVersion';

    consolePrint('==================> VersionRepo: checkUpdate started');
    consolePrint('URL: $url');

    try {
      final response = await get(
        Uri.parse(url),
        headers: Constants.header,
      ).timeout(const Duration(seconds: 10));

      consolePrint('Status: ${response.statusCode}');
      consolePrint('Body: ${response.body}');

      if (response.statusCode == 200) {
        final bodyAsJson =
            json.decode(response.body) as Map<String, dynamic>;
        consolePrint('==================> VersionRepo: checkUpdate success');
        return AppVersionModel.fromJson(bodyAsJson);
      } else {
        consolePrint('==================> VersionRepo: checkUpdate failed - ${response.statusCode}');
      }
    } catch (e) {
      // Silently ignore — version check should never crash the app.
      consolePrint('==================> VersionRepo: checkUpdate error - $e');
    }

    return null;
  }
}