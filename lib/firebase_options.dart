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
    apiKey: 'AIzaSyDBzivqJGxfmyd9_VbEnrJfcJL7CdfHwRw',
    appId: '1:648642652489:web:6680ffb74112b3f9a81298',
    messagingSenderId: '648642652489',
    projectId: 'chatter-174ab',
    authDomain: 'chatter-174ab.firebaseapp.com',
    storageBucket: 'chatter-174ab.firebasestorage.app',
    measurementId: 'G-F27VWV77K7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9I52oY0QeQ_KNau2PocOreK-IXAojq4o',
    appId: '1:648642652489:android:d7922e9208702b89a81298',
    messagingSenderId: '648642652489',
    projectId: 'chatter-174ab',
    storageBucket: 'chatter-174ab.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-wGWWT1MN4QVHgYBZKT9W5b35HVtsnyc',
    appId: '1:648642652489:ios:a25a1f041a4d4beba81298',
    messagingSenderId: '648642652489',
    projectId: 'chatter-174ab',
    storageBucket: 'chatter-174ab.firebasestorage.app',
    iosBundleId: 'net.poquesoft.chatter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-wGWWT1MN4QVHgYBZKT9W5b35HVtsnyc',
    appId: '1:648642652489:ios:a25a1f041a4d4beba81298',
    messagingSenderId: '648642652489',
    projectId: 'chatter-174ab',
    storageBucket: 'chatter-174ab.firebasestorage.app',
    iosBundleId: 'net.poquesoft.chatter',
  );
}
