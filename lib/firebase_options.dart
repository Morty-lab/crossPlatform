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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAdGym7WKE941-0PqOX-vHBHMr_F4ixqeA',
    appId: '1:428400188287:web:e9020243bede3b9306184a',
    messagingSenderId: '428400188287',
    projectId: 'crossplatform-c44c4',
    authDomain: 'crossplatform-c44c4.firebaseapp.com',
    storageBucket: 'crossplatform-c44c4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1rsOIWl2e_rLiMLpXN7kHgR4PbaUC9Fs',
    appId: '1:428400188287:android:28ca68e670b7d86b06184a',
    messagingSenderId: '428400188287',
    projectId: 'crossplatform-c44c4',
    storageBucket: 'crossplatform-c44c4.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAdGym7WKE941-0PqOX-vHBHMr_F4ixqeA',
    appId: '1:428400188287:web:3dea922cc8d0da5906184a',
    messagingSenderId: '428400188287',
    projectId: 'crossplatform-c44c4',
    authDomain: 'crossplatform-c44c4.firebaseapp.com',
    storageBucket: 'crossplatform-c44c4.appspot.com',
  );
}
