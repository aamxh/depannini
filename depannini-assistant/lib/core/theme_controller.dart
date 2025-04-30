import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCtrl extends GetxController {

  final _isDark = false.obs;

  bool get isDark => _isDark.value;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  void switchTheme() {
    _isDark.value = !_isDark.value;
    saveTheme(isDark);
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final res = prefs.getBool('isDark') ?? false;
    _isDark.value = res;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

}