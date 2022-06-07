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
    apiKey: 'AIzaSyBHZxUeIMWvW9FYinTzcnE-Y3oAKXfaLNM',
    appId: '1:934787248639:web:5f4bc140ae14630b03b7ca',
    messagingSenderId: '934787248639',
    projectId: 'document-bank',
    authDomain: 'document-bank.firebaseapp.com',
    storageBucket: 'document-bank.appspot.com',
    measurementId: 'G-3ESDSX4T7E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyColvOtDdoji8MWphlo4SSRsXjdSbP3zIs',
    appId: '1:934787248639:android:945ff60b99fc395f03b7ca',
    messagingSenderId: '934787248639',
    projectId: 'document-bank',
    storageBucket: 'document-bank.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0B3QVR5xi4J1OWfeV8GBEs_Nw9GWlwhw',
    appId: '1:934787248639:ios:d94951f3b2e1de8303b7ca',
    messagingSenderId: '934787248639',
    projectId: 'document-bank',
    storageBucket: 'document-bank.appspot.com',
    iosClientId:
        '934787248639-bjm3i39rtultcenetr5ne26u7rh7pffk.apps.googleusercontent.com',
    iosBundleId: 'com.workspace.db',
  );
}