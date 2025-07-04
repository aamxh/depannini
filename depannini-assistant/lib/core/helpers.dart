import 'package:depannini_assistant/app/common/view_models/assistant_view_model.dart';
import 'package:depannini_assistant/app/common/models/assistant.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHelpers {

  MyHelpers._();

  static String? validatePassword(String val) {
    if (val.length < 5) return 'Password must be at least 5 characters long.';
    return null;
  }

  static bool resIsOk(int? code) {
    if (code == null) return false;
    if (code < 200) return false;
    if (code >= 300) return false;
    return true;
  }

  static Future<void> makePhoneCall(String num) async {
    final Uri url = Uri(scheme: 'tel', path: num);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  static String? validateRegistrationNumber(String val) {
    if (val.isEmpty) return 'Empty field!';
    if (!val.isNum) return 'Invalid vehicle registration number!';
    if (val.length < 8) return 'Invalid vehicle registration number!';
    return null;
  }

  static String? vehicleTypeMatchesLicenseCategory(AssistantVM vm) {
    if (vm.serviceType == 'towing') {
      if (vm.drivingLicenseCat != 'c') return "You can't do towing with this driving license category!";
      if (vm.vehicleType != 'truck') return "You can't do towing with this vehicle type!";
    }
    else {
      if (vm.drivingLicenseCat == 'c') return "You can't do repairing with this driving license category!";
      if (vm.vehicleType == 'truck') return "You can't do repairing with this vehicle type!";
    }
    return null;
  }

  static Map<String, dynamic> modifySignUpDataFormat(Assistant assistant) {
    Map<String, dynamic> assistantMap = assistant.toJson();
    assistantMap.addAll({
    'password_confirm': assistantMap['password'],
    'user_type': "assistant"
    });
    assistantMap.remove('email');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'phoneNumber');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'serviceType');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'vehicleType');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'currentLat');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'currentLng');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'drivingLicenseCat');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'drivingLicenseNum');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'drivingLicenseExpiry');
    assistantMap = modifyCamelToSnakeForOneKey(assistantMap, 'vehicleRegistrationNum');
    return assistantMap;
  }

  static Map<String, dynamic> modifyCamelToSnakeForOneKey(Map<String, dynamic> map, String key) {
    final val = map[key];
    map.remove(key);
    map[camelToSnake(key)] = val;
    return map;
  }

  static String camelToSnake(String input) {
    return input.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
          (Match m) => '${m.group(1)}_${m.group(2)}',
    ).toLowerCase();
  }

}