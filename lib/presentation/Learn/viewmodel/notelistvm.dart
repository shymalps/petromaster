import 'package:get/get.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/notesdata_model.dart';
import '../../../domain/repository/studymaterialrepo.dart';

class Notelistvm extends GetxController {
  final String topicId;
  Notelistvm({required this.topicId});
  @override
  void onInit() {
    super.onInit();
    consolePrint('==================> Note Controller Initialized');
    getNoteslist(topicId);
  }

  final api = Studymaterialrepo();
  RxBool isloading = false.obs;
  RxList<NoteModel> notelist = <NoteModel>[].obs;
  Future<void> noteseen(String noteId) async {
    await api.noteseen(noteId);
  }

  Future<void> getNoteslist(String topicId) async {
    isloading.value = true;
    consolePrint('==================> Note Controller Initialized');
    try {
      final response = await api.getnotes(topicId);
      if (!ApiResponseHelper.isSuccess(response)) {
        notelist.clear();
        consolePrint('==================> Note Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      notelist.value = data.map((e) => NoteModel.fromJson(e)).toList();
    } catch (e) {
      consolePrint('==================> Note Controller Error', e.toString());
    } finally {
      isloading.value = false;
      consolePrint('==================> Note Controller Completed');
    }
  }
}
