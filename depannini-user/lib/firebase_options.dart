// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAHGVobdVPIAt07HULr4Ut6MR1T7i70EJk',
    appId: '1:1096207007187:web:2170e8e42eabdd23564326',
    messagingSenderId: '1096207007187',
    projectId: 'depannini-7854d',
    authDomain: 'depannini-7854d.firebaseapp.com',
    storageBucket: 'depannini-7854d.firebasestorage.app',
    measurementId: 'G-YVTV17FHSK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGX_s7bm2LqZis-6NzVHT2B8PKzXJob4s',
    appId: '1:1096207007187:android:e2eedf46eae6fcd4564326',
    messagingSenderId: '1096207007187',
    projectId: 'depannini-7854d',
    storageBucket: 'depannini-7854d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEn50lnMdJs6PQlLLWpVD3XaGz4smk-2I',
    appId: '1:1096207007187:ios:ec69b0ed7a827f7f564326',
    messagingSenderId: '1096207007187',
    projectId: 'depannini-7854d',
    storageBucket: 'depannini-7854d.firebasestorage.app',
    iosBundleId: 'com.example.depanniniUser',
  );
}
