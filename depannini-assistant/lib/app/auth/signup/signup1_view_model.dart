import 'package:depannini_assistant/core/constants.dart';
import 'package:get/get.dart';

class SignUp1VM extends GetxController {

  RxInt serviceType = 0.obs;
  RxInt licenseCat = 0.obs;
  RxInt vehicleType = 0.obs;

  void changeServiceType(int type) => serviceType.value = type;

  void changeLicenseCat(int cat) => licenseCat.value = cat;

  void changeVehicleType(int type) => vehicleType.value = type;

}