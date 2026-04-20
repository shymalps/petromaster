import '../../core/utils/debuprint.dart';
import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class Lessonrepo {
  final _apiService = NetworkApiServices();
  Future<dynamic> lessonlist(String topicId) async {
    consolePrint(
        '======================>In Topic Repo (function topiclist) Started');
    consolePrint('url ${AppEndpoints.getlessons(topicId)}');
    dynamic response =
        await _apiService.getApi(await AppEndpoints.getlessons(topicId));
    consolePrint(
        '======================>In Topic Repo (function topiclist) Completed');
    return response;
  }
}
