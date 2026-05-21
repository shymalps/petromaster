import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/profile_model.dart';
import '../../../domain/repository/profilerepo.dart';

class Profilevm extends GetxController {
  @override
  void onInit() {
    super.onInit();

    consolePrint(
      '==================> Profile Controller Initialized',
    );
  }

  final api = Profilerepo();
  RxBool isloading = false.obs;
  StudentModel? profileData;

  Future<void> getProfile() async {
    isloading.value = true;
    consolePrint(
      '==================> Profile Controller Initialized',
    );
    try {
      final response = await api.profile();
      if (!ApiResponseHelper.isSuccess(response)) {
        profileData = null;
        consolePrint('==================> Profile Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.mapData(response);
      if (data == null || data.isEmpty) {
        profileData = null;
        consolePrint(
          '==================> Profile Controller API Error',
          'Empty profile data',
        );
        return;
      }

      profileData = StudentModel.fromJson(data);
      consolePrint('profile data $data');
    } catch (e) {
    profileData = null; 
    consolePrint('error', e.toString());
} finally {
      isloading.value = false;
      consolePrint(
        '==================> Profile Controller Completed',
      );
    }
  }

  String timestampToDate(int timestamp, {String format = 'dd-MM-yyyy'}) {
    // Convert seconds to milliseconds (if timestamp is in seconds)
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    // Format the DateTime object
    return DateFormat(format).format(dateTime);
  }
}
