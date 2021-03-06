// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWsjkYEz070f107M_hYQ9zffACE4J9Ne0',
    appId: '1:429141041642:android:b3fd5dec2f9532e1701293',
    messagingSenderId: '429141041642',
    projectId: 'todoooze-f207a',
    storageBucket: 'todoooze-f207a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkorR8c7wNkQN96DLsFENCcYEO918XDOU',
    appId: '1:429141041642:ios:5e6fa4bbe718bace701293',
    messagingSenderId: '429141041642',
    projectId: 'todoooze-f207a',
    storageBucket: 'todoooze-f207a.appspot.com',
    iosClientId: '429141041642-gga6htlj2rbb56gmd2rdf6gm7qj9qhs6.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoooze',
  );
}
