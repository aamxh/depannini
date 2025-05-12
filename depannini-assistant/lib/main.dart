import 'package:depannini_assistant/app/main/enable_location_view.dart';
import 'package:depannini_assistant/core/theme_controller.dart';
import 'core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _initializeApp();
  runApp(MyApp());
}

Future<void> _initializeApp() async {
  //  await Firebase.initializeApp(
  //    options: DefaultFirebaseOptions.currentPlatform,
  //  );
  Get.put(ThemeCtrl());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  final themeCtrl = Get.find<ThemeCtrl>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: themeCtrl.isDark ? ThemeMode.dark : ThemeMode.light,
      home: EnableLocationV(),
    );
  }

}