// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyAxo6qzXYbBZRqyrVj-y00tWYe2my0VSNM',
    appId: '1:491027401826:web:eb6a3fee05e4daf6cf153b',
    messagingSenderId: '491027401826',
    projectId: 'spendingmanagement-f11ee',
    authDomain: 'spendingmanagement-f11ee.firebaseapp.com',
    storageBucket: 'spendingmanagement-f11ee.appspot.com',
    measurementId: 'G-YNX24WRH9V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRKhi1pzDpkYYsu4SXT-gu_YQMsehLmSo',
    appId: '1:491027401826:android:b904cbdf80eebf91cf153b',
    messagingSenderId: '491027401826',
    projectId: 'spendingmanagement-f11ee',
    storageBucket: 'spendingmanagement-f11ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCO6SGqcywDl7tyq67CtKpl58hUGuNScw',
    appId: '1:491027401826:ios:f315d8858018569bcf153b',
    messagingSenderId: '491027401826',
    projectId: 'spendingmanagement-f11ee',
    storageBucket: 'spendingmanagement-f11ee.appspot.com',
    iosClientId: '491027401826-dhdd7q9vlidvc37di53ajgmq58j2if4q.apps.googleusercontent.com',
    iosBundleId: 'com.example.spendManagement',
  );
}
