import 'package:petromaster/data/app_exceptions.dart';

import 'dart:convert';
import 'dart:io';

import '../../core/constant/constants.dart';
import '../../core/utils/debuprint.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    consolePrint('Get Api Call Started with url=========>', url);
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: Constants.header)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
    // throw UnimplementedError();
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data, headers: Constants.header)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    consolePrint('Api response got with status code =========>',
        response.statusCode.toString());
    consolePrint('Api response body is =========>', response.body.toString());
    switch (response.statusCode) {
      case 200:
        consolePrint('Api response is =========>', response.body);
        return jsonDecode(response.body);
      case 400:
        throw InvalidurlException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
