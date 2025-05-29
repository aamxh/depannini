import 'package:depannini_assistant/app/main/assistant_view_model.dart';
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

  static String? validateRegistrationNumber(String val) {
    RegExp exp = RegExp(r'^\d{4} \d{3} \d{2}$');
    if (val.isEmpty) return 'Empty field!';
    if (!exp.hasMatch(val)) return 'Invalid vehicle registration number!';
    return null;
  }

  static String? vehicleTypeMatchesLicenseCategory(AssistantVM vm) {
    if (vm.serviceType == 0) {
      if (vm.licenseCat != 1) return "You can't do towing with this driving license category!";
      if (vm.vehicleType != 2) return "You can't do towing with this vehicle type!";
    }
    else {
      if (vm.licenseCat == 1) return "You can't do repairing with this driving license category!";
      if (vm.vehicleType == 2) return "You can't do repairing with this vehicle type!";
    }
    return null;
  }

}