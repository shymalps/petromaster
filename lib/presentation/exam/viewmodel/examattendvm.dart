import 'package:get/get.dart';
// import 'package:oyster_lms/core/helpers/dialougehelper.dart';

import '../../../app/config/routes/route_name.dart';
import '../../../core/utils/api_response_helper.dart';
import '../../../core/helpers/dialougehelper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/examdata_model.dart';
import '../../../domain/models/questionlist_model.dart';
import '../../../domain/repository/examrepo.dart';

class Examattendvm extends GetxController {
  final String examid;
  Examattendvm({required this.examid});
  @override
  void onInit() {
    super.onInit();
    getQuestions(examid);
    consolePrint(
      '==================> Exam Attend Controller Initialized',
    );
  }

  final api = Examrepo();
  RxInt currentindex = 0.obs;
  RxString selectedoption = ''.obs;
  RxBool isloading = false.obs;
  RxList<Question> questions = <Question>[].obs;
  final examData = Rxn<ExamDataModel>();

  int timeconvert(String time) {
    List<String> parts = time.split(':');

    // Parse hours and minutes as integers
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Calculate total minutes
    return (hours * 60) + minutes;
  }

  Future<void> nextquestion(String qusId, String ans) async {
    consolePrint(
        'Current Index ${currentindex.value}, ${questions.length - 1}');
    if (currentindex.value < questions.length - 1) {
      final status = await submitanswer(qusId, ans);
      if (status) {
        currentindex.value++;
        selectedoption.value = '';
      } else {
        Dialougehelper.error(Get.context, 'Error', 'Failed to submit answer');
      }
    } else if (currentindex.value == questions.length - 1) {
      final status = await submitanswer(qusId, ans);
      if (status) {
        await api.submitexam(examid);
        Get.offNamed(RouteName.navbar);
      } else {
        Dialougehelper.error(Get.context, 'Error', 'Failed to submit answer');
      }
    }
  }

  void previousquestion() {
    if (currentindex.value > 0) {
      currentindex.value--;
    }
  }

  void handleTimerFinish(bool finished) {
    Get.offNamed(RouteName.timeout);
  }

  void updateselection(String option) {
    if (selectedoption.value == option) {
      selectedoption.value = '';
    } else {
      selectedoption.value = option;
    }

    consolePrint('index ${selectedoption.value}');
  }

  Future<bool> submitanswer(String qusId, String ans) async {
    consolePrint(
        '==================>In Exam Attend VM (function submitanswer) Initialized');
    try {
      final response = await api.submitanswer(qusId, ans, examid);
      if (!ApiResponseHelper.isSuccess(response)) {
        consolePrint('==================> Exam Attend VM API Error',
            ApiResponseHelper.message(response));
        return false;
      }
      return true;
    } catch (e) {
      consolePrint(
          '==================> Exam Attend VM (function submitanswer) Error',
          e.toString());
      return false;
    } finally {
      consolePrint(
          '==================> Exam Attend VM (function submitanswer) Completed');
    }
  }

  Future<void> getQuestions(String examid) async {
    consolePrint(
        '==================>In Exam Attend VM (function getQuestions) Initialized');
    try {
      isloading.value = true;
      final response = await api.questions(examid);
      if (!ApiResponseHelper.isSuccess(response)) {
        questions.clear();
        examData.value = null;
        consolePrint('==================> Exam Attend VM API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      questions.value = data.map((e) => Question.fromJson(e)).toList();
      if (response is Map && response['exam'] is Map<String, dynamic>) {
        examData.value = ExamDataModel.fromJson(response['exam']);
      } else {
        examData.value = null;
      }
      // questions.assignAll(response.map((json) => Question.fromJson(json)).toList());
    } catch (e) {
      consolePrint(
          '==================> Exam Attend VM (function getQuestions) Error',
          e.toString());
    } finally {
      isloading.value = false;
      consolePrint(
          '==================> Exam Attend VM (function getQuestions) Completed');
    }
  }

  @override
  void onClose() {
    super.onClose();
    consolePrint('==================> Exam Attend Controller Closed');
  }
  // final response = [
  //   {
  //     "id": "2",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "<p>1300</p>",
  //     "optionb": "<p>200&nbsp;</p>",
  //     "optionc": "<p>500</p>",
  //     "optiond": "<p>450</p>",
  //     "optione": "<p>None of these</p>",
  //     "qns": "<p>500+800</p>",
  //     "ans": "A",
  //     "explanation": "",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "6",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "z",
  //     "optionb": "zfbfb",
  //     "optionc": "vcbcvb",
  //     "optiond": "cvbcvzb",
  //     "optione": "None of these",
  //     "qns": "gdfgfdg",
  //     "ans": "A",
  //     "explanation": "",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "18",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "electronic device",
  //     "optionb": "rrrtttt",
  //     "optionc": "yuuiiii",
  //     "optiond": "yyuuiii",
  //     "optione": "None of these",
  //     "qns": "what is computer",
  //     "ans": "A",
  //     "explanation": "etgtyyuujj",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "19",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "To eliminate hydrogen",
  //     "optionb": "To retard the cooling rate of the weld",
  //     "optionc": "To eliminate the atmosphere",
  //     "optiond": "To ensure maximum heat input",
  //     "optione": "",
  //     "qns": "Why is a welding arc shielded?",
  //     "ans": "C",
  //     "explanation": "",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "26",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "Cellulosic",
  //     "optionb": "Non consumable",
  //     "optionc": "Consumable",
  //     "optiond": "None of the above",
  //     "optione": "",
  //     "qns": "The TIG welding process utilizes an electrode that is:",
  //     "ans": "B",
  //     "explanation": "",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "28",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "Knowledge and experience",
  //     "optionb": "Literacy",
  //     "optionc": "Honesty and integrity",
  //     "optiond": "All of the above",
  //     "optione": "",
  //     "qns": "A welding inspector?s main attribute includes:",
  //     "ans": "D",
  //     "explanation": "",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "34",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "Cellulosic",
  //     "optionb": "Non consumable",
  //     "optionc": "Consumable",
  //     "optiond": "None of the above",
  //     "optione": "",
  //     "qns": "The TIG welding process utilizes an electrode that is:",
  //     "ans": "B",
  //     "explanation": "",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "36",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "Knowledge and experience",
  //     "optionb": "Literacy",
  //     "optionc": "Honesty and integrity",
  //     "optiond": "All of the above",
  //     "optione": "",
  //     "qns": "A welding inspector?s main attribute includes:",
  //     "ans": "D",
  //     "explanation": "",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "65",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "1",
  //     "optionb": "2",
  //     "optionc": "3",
  //     "optiond": "4",
  //     "optione": "",
  //     "qns": "question",
  //     "ans": "B",
  //     "explanation": "",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   },
  //   {
  //     "id": "66",
  //     "staffid": null,
  //     "class_id": "2",
  //     "subject_id": "2",
  //     "topic_id": "3",
  //     "optiona": "adsadx",
  //     "optionb": "dqwwsdxsaxq",
  //     "optionc": "qqsx",
  //     "optiond": "dxqasdxq",
  //     "optione": "None of thesedwq",
  //     "qns": "dwqdqwd",
  //     "ans": "B",
  //     "explanation": "qwdqwxwqxx",
  //     "passagecode": null,
  //     "passageparent": "0",
  //     "passage": null,
  //     "status": "1"
  //   }
  // ];
}
