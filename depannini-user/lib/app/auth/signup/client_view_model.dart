import 'package:get/get.dart';

class ClientVM extends GetxController {

  String name = '';
  String email = '';
  String password = '';
  String num = '';

  void changeNum(String val) {
    num = val;
    update();
  }

  void changeName(String val) {
    name = val;
    update();
  }

  void changeEmail(String val) {
    email = val;
    update();
  }

  void changePassword(String val) {
    password = val;
    update();
  }

}