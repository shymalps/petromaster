import 'package:get/get.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/topic_model.dart';
import '../../../domain/repository/topicrepo.dart';

class TopicVM extends GetxController {
  final String subjectId;
  TopicVM({required this.subjectId});

  @override
  void onInit() {
    super.onInit();
    getTopics(subjectId);
    consolePrint(
      '==================> Topic Controller Initialized',
    );
  }

  final api = Topicrepo();
  RxBool isLoading = false.obs;
  RxList<TopicData> topicList = <TopicData>[].obs;

  Future<void> getTopics(String subId) async {
    consolePrint('==================> Topic Controller Initialized');
    try {
      isLoading.value = true;
      final response = await api.topiclist(subId);
      if (!ApiResponseHelper.isSuccess(response)) {
        topicList.clear();
        consolePrint('==================> Topic Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      topicList.value = data.map((e) => TopicData.fromJson(e)).toList();
    } catch (e) {
      consolePrint('==================> Topic Controller Error', e.toString());
    } finally {
      isLoading.value = false;
      consolePrint('==================> Topic Controller Completed');
    }
  }
}
