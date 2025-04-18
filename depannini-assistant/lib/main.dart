import 'package:depannini_assistant/core/theme_controller.dart';
import 'app/main/welcome_view.dart';
import 'core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
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
      home: WelcomeV(),
    );
  }

}