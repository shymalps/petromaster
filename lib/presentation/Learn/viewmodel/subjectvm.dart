import 'package:get/get.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/subject_model.dart';
import '../../../domain/repository/subjectrepo.dart';

class SubjectVM extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getSubjectlist();
    consolePrint(
      '==================> Subject Controller Initialized',
    );
  }

  final api = SubjectRepo();
  RxBool isLoading = false.obs;
  RxList<Subject> subjectList = <Subject>[].obs;
  double getpercent(int index) {
    int viewedcount = subjectList[index].viewedVideoCount +
        subjectList[index].viewedAudioCount +
        subjectList[index].viewedNotesCount;
    int totalcount = subjectList[index].videoCount +
        subjectList[index].audioCount +
        subjectList[index].notesCount;
    if (totalcount == 0) {
      return 0;
    }
    dynamic percent = viewedcount * 100 ~/ totalcount;

    return double.parse((percent).toStringAsFixed(2));
  }

 int _extractNumber(String subjectName) {
    final match = RegExp(r'^\d+').firstMatch(subjectName);
    return match != null ? int.parse(match.group(0)!) : 0;
  }

  Future<void> getSubjectlist() async {
    isLoading.value = true;
    consolePrint('==================> Subject Controller Initialized');
    try {
      final response = await api.getSubjects();
      if (!ApiResponseHelper.isSuccess(response)) {
        subjectList.clear();
        consolePrint('==================> Subject Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      subjectList.value = data.map((e) => Subject.fromJson(e)).toList();
      subjectList.sort((a, b) {
        int aNum = _extractNumber(a.subjectName);
        int bNum = _extractNumber(b.subjectName);
        return aNum.compareTo(bNum);
      });
      consolePrint('subjectlength ${subjectList.length}');
    } catch (e) {
      consolePrint(
          '==================> Subject Controller Error', e.toString());
    } finally {
      isLoading.value = false;
      consolePrint('==================> Subject Controller Completed');
    }
  }
}
