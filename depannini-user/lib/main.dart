import 'package:depannini_user/app/auth/common/auth_wrapper_view.dart';
import 'package:depannini_user/core/theme_controller.dart';
import 'core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(MyApp());
}

Future<void> _initializeApp() async {
  Get.put(ThemeCtrl());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  final theme = Get.find<ThemeCtrl>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
        home: AuthWrapperV(),
      ),
    );
  }

}