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
    } else {

    }
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