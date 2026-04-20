// import 'package:oyster_lms/data/network/network_api_services.dart';

import '../../core/utils/debuprint.dart';
import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class Topicrepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> topiclist(String subId) async {
    consolePrint(
        '======================>In Topic Repo (function topiclist) Started');
    consolePrint('url ${AppEndpoints.getTopics(subId)}');
    dynamic response = await _apiService.getApi(await AppEndpoints.getTopics(subId));
    consolePrint(
        '======================>In Topic Repo (function topiclist) Completed');
    return response;
  }
}