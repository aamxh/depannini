import 'package:depannini_assistant/app/auth/signup/signup1_view_model.dart';

class MyHelpers {

  MyHelpers._();

  static String? validatePassword(String val) {
    if (val.length < 5) return 'Password must be at least 5 characters long.';
    return null;
  }

  static String? validateRegistrationNumber(String val) {
    RegExp exp = RegExp(r'^\d{4} \d{3} \d{2}$');
    if (val.isEmpty) return 'Empty field!';
    if (!exp.hasMatch(val)) return 'Invalid vehicle registration number!';
    return null;
  }

  static String? vehicleTypeMatchesLicenseCategory(SignUp1VM vm) {
    if (vm.serviceType.value == 0) {
      if (vm.licenseCat.value != 1) return "You can't do towing with this driving license category!";
      if (vm.vehicleType.value != 2) return "You can't do towing with this vehicle type!";
    }
    else {
      if (vm.licenseCat.value == 1) return "You can't do repairing with this driving license category!";
      if (vm.vehicleType.value == 2) return "You can't do repairing with this vehicle type!";
    }
    return null;
  }

}