// // SHA1: 48:AD:6F:84:93:06:6C:3A:57:ED:43:81:13:E2:58:0F:82:70:C0:C4

// // P8  Key ID:F5J43MKAL2    llave notific

// import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:ultrared/src/api/authentication_client.dart';
// import 'package:ultrared/src/controllers/home_controller.dart';


// class PushNotificationService extends ChangeNotifier {
//   // static final localNotification = LocalNotifications();
//   // static final homeController = HomeController();

//   static FirebaseMessaging messaging = FirebaseMessaging.instance;
//   static String? token;

//   static final StreamController<dynamic> _menssageStream =
//       StreamController.broadcast();

//   static Stream<dynamic> get messageStream => _menssageStream.stream;

//   static Future _backgroundHandler(RemoteMessage message) async {
//    _menssageStream.sink.add('${message.data}');
//     // print('backgroun APP');
//     // print('backgroun APP: ${message.data['notification']}');
//     // print('backgroun APP: ${message.data}');

// // homeController.setPayloadAlerta(message);

//     //  await LocalNotifications.showNotification(
//     //           id: 0,
//     //           title: '${message.notification!.title}',
//     //           body: '${message.notification!.body}',
//     //           payload: '${message.data['payload']}',
//     //         );

//     // print('holAAAA');
//     // print('hola ssssss${message.notification!.title}');
//   }

//   static Future _onMessageHandler(RemoteMessage message) async {
//     // print('onMessageHandler APP');
// //  _menssageStream.sink.add(message.notification!.body ?? 'No data');
//  _menssageStream.sink.add('${message.data}');

//     // _menssageStream.sink.add(message.data['informacion'] ?? 'No data');
//     // homeController.setPayloadAlerta(message);
//     // LocalNotifications.showNotification(
//     //   id: 0,
//     //   title: ' sssss${message.notification!.title}',
//     //   body: ' BODY  ${message.notification!.body}',
//     //   payload: 'PAYLOAD ${message.data}',
//     // );

//     // print('title ${message.notification!.title}');
//     // print('body ${message.notification!.body}');
//     // print('titlesss ${message.data}');
//     // yuyuyu();
//   }

//   static Future _onMessageOpenApp(RemoteMessage message) async {
//         // print('onMessageOpenApp APP');
// //  _menssageStream.sink.add(message.notification!.body ?? 'No data');
//  _menssageStream.sink.add('${message.data}');
//     //  homeController.setPayloadAlerta(message);
//     // _menssageStream.sink.add(message.data['informacion'] ?? 'No data');
//     // LocalNotifications.showNotification(
//     //   id: 0,
//     //   title: 'title OPEN APP',
//     //   body: '${message.data}',
//     //   payload: '${message.data}',
//     // );
//     // print('OPEN APP');
//     print('OPEN APPSSSS: ${message.data}');
//   }

//   static Future initializeApp() async {
//     await Firebase.initializeApp();
//     //  options: DefaultFirebaseOptions.currentPlatform,
//     await requestPermission();
//     token = await FirebaseMessaging.instance.getToken();
//     print('Token FIREBASE ID: $token');

//     // // GUARDO EL TOKEN EL EL DISPOSITIVO//
//     await Auth.instance.saveTokenFireBase(token!);

//     final tokenId = HomeController();
//     // tokenId.setTokennotificacion(token);
//     // await tokenId.sentToken();

//     // Handler
//     FirebaseMessaging.onBackgroundMessage(
//         _backgroundHandler); // Local Notification
//     FirebaseMessaging.onMessage.listen(_onMessageHandler); // Local Notification
//     FirebaseMessaging.onMessageOpenedApp
//         .listen(_onMessageOpenApp); // Local Notification
//   }

//   static requestPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true);

//     print('User push notification status ${settings.authorizationStatus}');
//   }

//   static closeStrems() {
//     _menssageStream.close();
//   }
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  static Future<String?> getFirebaseToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static Future<void> deleteFirebaseInstance() async {
    
    await FirebaseMessaging.instance.deleteToken();


    print('SE Eliminar el token y desconectar la instancia de FirebaseMessaging');
  }

  static void configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Got a message while in the foreground!");
      print("Message data: ${message.data}");

      if (message.notification != null) {
        print("Message also contained a notification: ${message.notification}");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new onMessageOpenedApp event was published!");
      print("Message data: ${message.data}");

      if (message.notification != null) {
        print("Message also contained a notification: ${message.notification}");
      }
    });


    
  }
 
}