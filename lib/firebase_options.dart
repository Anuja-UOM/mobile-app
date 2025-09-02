// Firebase web configuration
// This file contains Firebase configuration for web platform
// Replace these values with your actual Firebase project credentials

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: "AIzaSyCvSnYEIuPUNfSNJrj5vpSFjcaX24YEsM4",
    authDomain: "mobile-app-location-b5ce8.firebaseapp.com",
    databaseURL:
        "https://mobile-app-location-b5ce8-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "mobile-app-location-b5ce8",
    storageBucket: "mobile-app-location-b5ce8.firebasestorage.app",
    messagingSenderId: "1018454247619",
    appId: "1:1018454247619:web:0df27e4eb2979fd6bafa76",
    measurementId: "G-SRFPRP32XM",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIza-demo-key-replace-with-real',
    appId: '1:123456789:android:abcdef123456',
    messagingSenderId: '123456789',
    projectId: 'mobile-app-location-demo',
    databaseURL: 'https://mobile-app-location-demo-default-rtdb.firebaseio.com',
    storageBucket: 'mobile-app-location-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIza-demo-key-replace-with-real',
    appId: '1:123456789:ios:abcdef123456',
    messagingSenderId: '123456789',
    projectId: 'mobile-app-location-demo',
    databaseURL: 'https://mobile-app-location-demo-default-rtdb.firebaseio.com',
    storageBucket: 'mobile-app-location-demo.appspot.com',
    iosBundleId: 'com.example.mobileApp',
  );
}
