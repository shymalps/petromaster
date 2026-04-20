import 'dart:io';
import 'package:petromaster/core/constant/constants.dart';
import 'package:petromaster/core/utils/debuprint.dart';
import 'package:petromaster/data/app_exceptions.dart';
import 'package:petromaster/data/network/network_api_services.dart';
import 'package:petromaster/domain/endpoints/appendpoints.dart';
import 'package:petromaster/presentation/Learn/viewmodel/getstudentresponse.dart';
import 'package:http/http.dart' as http;

import '../../presentation/Learn/viewmodel/getstudentresponse.dart';

class studentResponcerepo {
  final NetworkApiServices _apiService = NetworkApiServices();

   Future<dynamic> getStudentResponse() async {
    consolePrint(
        '======================>In Topic Repo (function topiclist) Started');
    consolePrint('url ${AppEndpoints.getStudentResponse()}');
    dynamic response =
        await _apiService.getApi(await AppEndpoints.getStudentResponse());
    consolePrint(
        '======================>In Topic Repo (function topiclist) Completed');
    return response;
  }
}
