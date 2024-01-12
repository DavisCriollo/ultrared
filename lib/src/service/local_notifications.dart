
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/subjects.dart';

// class LocalNotifications {
//   static final _notifications = FlutterLocalNotificationsPlugin();
//   static final onNotification = BehaviorSubject<String?>();





  
//   // String sound = 'notification.mp3';
//   static Future _notificationDetails() async {
//     return  const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'Channel id',
//         'Channel Name',
//         channelDescription: 'Channel description',
//         importance: Importance.max,
//        sound: RawResourceAndroidNotificationSound('notification'),
//       ),
//       iOS: IOSNotificationDetails(
//         sound: 'notification.mp3',
//       ),
//     );
//   }

//   static Future init({bool initScheduled = false}) async {
//     final androide = AndroidInitializationSettings('@mipmap/ic_launcher');
//     final iOS = IOSInitializationSettings();
//     final setting = InitializationSettings(android: androide, iOS: iOS);

// // WHEN APP IS CLOSED

//     final details = await _notifications.getNotificationAppLaunchDetails();

//     if (details != null && details.didNotificationLaunchApp) {
//       onNotification.add(details.payload);
//     }

//     await _notifications.initialize(
//       setting,
//       onSelectNotification: (payload) async {
//         onNotification.add(payload);
//       },
//     );
//   }

//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async =>
//       _notifications.show(
//         id,
//         title,
//         body,
//         await _notificationDetails(),
//         payload: payload,
//       );

// static void cancel(int id)=>_notifications.cancel(id);
// static void cancelAll()=>_notifications.cancelAll();




// }



import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:ultrared/src/controllers/home_controller.dart';



// class NotificationHelper {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: onSelectNotification,
//     );

//     configureFirebaseMessaging();
//   }

//   Future<void> onSelectNotification(String? payload) async {
//     print("Notificación seleccionada con payload: $payload");
//   }

//   void configureFirebaseMessaging() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Manejar la notificación recibida mientras la aplicación está en primer plano
//       print("Notificación recibida: $message");
//       showNotification(
//         title: message.notification?.title ?? 'Notificación',
//         body: message.notification?.body ?? '',
//       );
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Manejar la notificación cuando la aplicación se abre desde la barra de notificaciones
//       print("Notificación abierta desde la aplicación: $message");
//       // Puedes manejar la navegación a una pantalla específica aquí
//     });
//   }

//   Future<void> showNotification({required String title, required String body}) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       'your_channel_description',
//        importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('notificationsapp'),
//       enableVibration: true,
//       icon: '@mipmap/ic_launcher',
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'Notificación payload',
//     );
//   }
// }

// Future<void> requestNotificationPermission() async {
//   final status = await Permission.notification.request();
//   if (status.isGranted) {
//     print('Permiso para notificaciones concedido.');
//   } else {
//     print('Permiso para notificaciones denegado.');
//   }







  
// }










class NotificationHelper {
final _ctrl = HomeController();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );

    configureFirebaseMessaging();
  }

  Future<void> onSelectNotification(String? payload) async {
    print("Notificación seleccionada con payload: $payload");
  }

  void configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Manejar la notificación recibida mientras la aplicación está en primer plano
      // print("Notificación recibida ------> : ${message.data['perNombre']}");

        // if (message.data['perNombre']!= 1719972687) {


            print("Notificación recibida ------> : ${message.data['perNombre']}");
            showNotification(
        title: message.notification?.title ?? 'Notificación',
        body: message.notification?.body ?? '',
      );
          
        // } else {

          
              // print("LA DATA ES DIFERENTE ------> : ${message.data['perNombre']}");

        // }

      





    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Manejar la notificación cuando la aplicación se abre desde la barra de notificaciones
      print("Notificación abierta desde la aplicación: $message");
      // Puedes manejar la navegación a una pantalla específica aquí
    });
  }

  Future<void> showNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      'your_channel_description',
       importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notificationsapp'),
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

      try {
         await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Notificación payload',
    );
      } catch (e) {
         print('Notificacion Show error.');

      }
   
  }
}

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.request();
  if (status.isGranted) {
    print('Permiso para notificaciones concedido.');
  } else {
    print('Permiso para notificaciones denegado.');
  }







  
}