import 'package:get/get.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/resultdata_model.dart';
import '../../../domain/repository/examrepo.dart';

class Examresultvm extends GetxController {
  final String examid;
  Examresultvm({required this.examid});
  @override
  void onInit() {
    super.onInit();
    getresult(examid);
    consolePrint(
      '==================> Exam Result Controller Initialized, Exam ID: $examid',
    );
  }

  final api = Examrepo();
  RxBool isloading = false.obs;
  RxList<ResultModel> resultData = RxList<ResultModel>([]);
  Future<void> getresult(String examid) async {
    isloading.value = true;
    consolePrint(
      '==================>In Exam Result VM (function getresult) Initialized',
    );
    try {
      final response = await api.examresult(examid);
      if (!ApiResponseHelper.isSuccess(response)) {
        resultData.clear();
        consolePrint('==================> Exam Result API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      resultData.value = data.map((e) => ResultModel.fromJson(e)).toList();
      consolePrint(
        'resultData ${resultData.length}',
      );    
    } catch (e) {
      consolePrint(
        '==================> Exam Result VM (function getresult) Error',
        e.toString(),
      );
    } finally {
      isloading.value = false;
      consolePrint(
        '==================> Exam Result VM (function getresult) Completed',
      );
    }
  }
}
