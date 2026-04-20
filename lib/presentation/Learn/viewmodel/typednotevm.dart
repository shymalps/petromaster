import 'package:get/get.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/typednote_model.dart';
import '../../../domain/repository/studymaterialrepo.dart';

class TypedNotelistvm extends GetxController {
  final String topicId;
  TypedNotelistvm({required this.topicId});
  @override
  void onInit() {
    super.onInit();
    consolePrint('==================> Note Controller Initialized');
    gettypeNoteslist(topicId);
  }

  final api = Studymaterialrepo();
  RxBool isloading = false.obs;
  RxList<TrainingNote> notelist = <TrainingNote>[].obs;
  // Future<void> noteseen(String noteId) async {
  //   await api.noteseen(noteId);
  // }

  Future<void> gettypeNoteslist(String topicId) async {
    isloading.value = true;
    consolePrint('==================> Note Controller Initialized');
    try {
      final response = await api.gettypednotes(topicId);
      if (!ApiResponseHelper.isSuccess(response)) {
        notelist.clear();
        consolePrint('==================> Note Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      notelist.value = data.map((e) => TrainingNote.fromJson(e)).toList();
    } catch (e) {
      consolePrint('==================> Note Controller Error', e.toString());
    } finally {
      isloading.value = false;
      consolePrint('==================> Note Controller Completed');
    }
  }
}
