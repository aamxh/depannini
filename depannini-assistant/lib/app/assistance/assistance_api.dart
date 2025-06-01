import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:dio/dio.dart';

class AssistanceAPI {

  AssistanceAPI._();

  static Future<bool> changeAssistantState(bool isActive) async {
    final dio = Dio();
    final baseUrl = MyConstants.djangoApiBaseUrl;
    try {
      final res = await dio.post(
        "$baseUrl/profile/assistant-status/",
        data: {"is_active": isActive},
      );
      if (MyHelpers.resIsOk(res.statusCode)) return true;
      return false;
    } on Exception catch (ex) {
      print(ex);
      return false;
    }
  }

}