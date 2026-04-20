import 'package:get/get.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/audiomodel.dart';
import '../../../domain/repository/studymaterialrepo.dart';

class Audiolistvm extends GetxController {
  final String topicId;
  Audiolistvm({required this.topicId});
  @override
  void onInit() {
    super.onInit();
    getAudiolist(topicId);
    consolePrint('==================> Audio Controller Initialized');
  }

  final api = Studymaterialrepo();
  RxBool isLoading = false.obs;
  RxList<AudioData> audiolist = <AudioData>[].obs;
  Future<void> getAudiolist(String topicId) async {
    isLoading.value = true;
    consolePrint('==================> Audio Controller Initialized');
    try {
      final response = await api.getaudio(topicId);
      if (!ApiResponseHelper.isSuccess(response)) {
        audiolist.clear();
        consolePrint('==================> Audio Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      audiolist.value = data.map((e) => AudioData.fromJson(e)).toList();
    } catch (e) {
      consolePrint('==================> Audio Controller Error', e.toString());
    } finally {
      isLoading.value = false;
      consolePrint('==================> Audio Controller Completed');
    }
  }

  Future<void> audioseen(String audioId) async {
    await api.audioseen(audioId);
  }
}
