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
        return macos;
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
    apiKey: 'AIzaSyA-kPlkYtte_0TpPkabOf2OerQrP6RkHrg',
    appId: '1:525477365686:web:d3b43e541bcabcf666a317',
    messagingSenderId: '525477365686',
    projectId: 'phone-authentication-efc94',
    authDomain: 'phone-authentication-efc94.firebaseapp.com',
    storageBucket: 'phone-authentication-efc94.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAu6Qgsa_upinlmdwaM56q22ID7OiE4u7o',
    appId: '1:525477365686:android:b71f9a4c0dbd715c66a317',
    messagingSenderId: '525477365686',
    projectId: 'phone-authentication-efc94',
    storageBucket: 'phone-authentication-efc94.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbg4OqNF-rmNFdhPy0JziQ6-44-gJwJ80',
    appId: '1:525477365686:ios:a1bb56493cd13c4466a317',
    messagingSenderId: '525477365686',
    projectId: 'phone-authentication-efc94',
    storageBucket: 'phone-authentication-efc94.appspot.com',
    iosClientId: '525477365686-9f83qdi7qb1thn4q2f3gi3n3vgfb7fl8.apps.googleusercontent.com',
    iosBundleId: 'com.example.ijloans',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDbg4OqNF-rmNFdhPy0JziQ6-44-gJwJ80',
    appId: '1:525477365686:ios:ec8279fc4d52ef5166a317',
    messagingSenderId: '525477365686',
    projectId: 'phone-authentication-efc94',
    storageBucket: 'phone-authentication-efc94.appspot.com',
    iosClientId: '525477365686-0l4dm84clt3od1cbkcbnq3d1a55ibgob.apps.googleusercontent.com',
    iosBundleId: 'com.example.ijloans.RunnerTests',
  );
}
