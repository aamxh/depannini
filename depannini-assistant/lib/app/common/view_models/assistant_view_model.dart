import 'package:get/get.dart';

class AssistantVM extends GetxController {

  final Rx<String> _name = ''.obs;
  final Rx<String> _email = ''.obs;
  final Rx<String> _password = ''.obs;
  final Rx<String> _phoneNumber = ''.obs;
  final RxDouble _currentLat = 0.0.obs;
  final RxDouble _currentLng = 0.0.obs;
  final Rx<String> _serviceType = 'towing'.obs;
  final Rx<String> _drivingLicenseCat = ''.obs;
  final Rx<String> _vehicleType = ''.obs;
  final RxInt _vehicleRegistrationNum = 0.obs;
  final Rx<String> _drivingLicenseNum = ''.obs;
  final Rx<String> _drivingLicenseExpiry = '10:02:26'.obs;

  set name(String val) => _name.value = val;
  set phoneNumber(String val) => _phoneNumber.value = val;
  set email(String val) => _email.value = val;
  set password(String val) => _password.value = val;
  set currentLat(double val) => _currentLat.value = val;
  set currentLng(double val) => _currentLng.value = val;
  set serviceType(String val) => _serviceType.value = val;
  set drivingLicenseCat(String val) => _drivingLicenseCat.value = val;
  set vehicleType(String val) => _vehicleType.value = val;
  set vehicleRegistrationNum(int val) => _vehicleRegistrationNum.value = val;
  set drivingLicenseNum(String val) => _drivingLicenseNum.value = val;
  set drivingLicenseExpiry(String val) => _drivingLicenseExpiry.value = val;

  String get name => _name.value;
  String get phoneNumber => _phoneNumber.value;
  String get password => _password.value;
  String get email => _email.value;
  double get currentLat => _currentLat.value;
  double get currentLng => _currentLng.value;
  String get serviceType => _serviceType.value;
  String get drivingLicenseCat => _drivingLicenseCat.value;
  String get vehicleType => _vehicleType.value;
  int get vehicleRegistrationNum => _vehicleRegistrationNum.value;
  String get drivingLicenseNum => _drivingLicenseNum.value;
  String get drivingLicenseExpiry => _drivingLicenseExpiry.value;

}