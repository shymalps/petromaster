import '../../core/utils/debuprint.dart';
import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class SubjectRepo {

  final _apiService = NetworkApiServices();

  Future<dynamic> getSubjects() async {
    consolePrint('======================>In subject Repo (function subjectApi) Started');
    consolePrint('url ${AppEndpoints.getSubjects()}');
    dynamic response = await _apiService.getApi(await AppEndpoints.getSubjects());
    consolePrint('======================>In subject Repo (function subjectApi) Completed');
    return response;
  }
}