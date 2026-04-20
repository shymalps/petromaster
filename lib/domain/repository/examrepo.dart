import '../../AuthPref.dart';
import '../../core/utils/debuprint.dart';
import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class Examrepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> examslist() async {
    consolePrint(
        '======================>In Exam Repo (function getExamslist) Started');
    var data = {
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint('data $data');
    consolePrint('url ${AppEndpoints.examlist}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.examlist);
    consolePrint(
        '======================>In Exam Repo (function getExamslist) Completed');
    return response;
  }

  Future<dynamic> questions(String examid) async {
    consolePrint(
        '======================>In Exam Repo (function questions) Started');
    var data = {
      'user_id': await AuthPreferences.getUserId(),
      'examid': examid,
    };
    consolePrint('data $data');
    consolePrint('url ${AppEndpoints.questions}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.questions);
    consolePrint(
        '======================>In Exam Repo (function questions) Completed');
    return response;
  }

  Future<dynamic> submitanswer(String qusId , String ans , String examid) async {
    consolePrint(
        '======================>In Exam Repo (function submitanswer) Started');
    var data = {
      'qnsid' : qusId,
      'ans' : ans,
      'examid' : examid,
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint('data $data');
    consolePrint('url ${AppEndpoints.nextquestion}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.nextquestion);
    consolePrint(
        '======================>In Exam Repo (function submitanswer) Completed');
    return response;
  }

  Future<dynamic> submitexam(String examid) async {
    consolePrint(
        '======================>In Exam Repo (function submitexam) Started');
    var data = {
      'examid': examid,
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint('data $data');
    consolePrint('url ${AppEndpoints.completeexam}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.completeexam);
    consolePrint(
        '======================>In Exam Repo (function submitexam) Completed');
    return response;
  }

  Future<dynamic> examresult(String examid) async {
    consolePrint(
        '======================>In Exam Repo (function examresult) Started');
    var data = {
      'examid': examid,
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint('data $data');
    consolePrint('url ${AppEndpoints.examresult}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.examresult);
    consolePrint(
        '======================>In Exam Repo (function examresult) Completed');
    return response;
  }
}
