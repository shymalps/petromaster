import 'package:get/get.dart';
// import 'package:oyster_lms/domain/repository/studymaterialrepo.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/videolist_model.dart';
import '../../../domain/repository/studymaterialrepo.dart';

class VideolistVM extends GetxController {
  final String topicId;
  VideolistVM({required this.topicId});

  @override
  void onInit() {
    super.onInit();
    getVideolist(topicId);
    consolePrint(
      '==================> Video Controller Initialized',
    );
  }

  final api = Studymaterialrepo();
  RxBool isLoading = false.obs;
  RxList<VideoModel> videoList = <VideoModel>[].obs;
  Future<void> videoseen(String videoId) async {
    await api.videoseen(videoId);
  }

  Future<void> getVideolist(String topicId) async {
    isLoading.value = true;
    consolePrint('==================> Video Controller Initialized');
    try {
      final response = await api.getVideos(topicId);
      if (!ApiResponseHelper.isSuccess(response)) {
        videoList.clear();
        consolePrint('==================> Video Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      videoList.value = data.map((e) => VideoModel.fromJson(e)).toList();
    } catch (e) {
      consolePrint('==================> Video Controller Error', e.toString());
    } finally {
      isLoading.value = false;
      consolePrint('==================> Video Controller Completed');
    }
  }
}
