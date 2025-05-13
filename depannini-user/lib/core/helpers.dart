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

}