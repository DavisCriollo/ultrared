


// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationProvider with ChangeNotifier {
//   final GlobalKey<NavigatorState> navigatorKey;

//   NotificationProvider(this.navigatorKey) {
//     initialize();
//   }

//   void initialize() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Manejar la notificación recibida mientras la aplicación está en primer plano
//       print("onMessage: $message");
//       // Puedes mostrar una notificación en la aplicación o ejecutar alguna lógica
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Manejar la notificación cuando la aplicación se abre desde la barra de notificaciones
//       print("onMessageOpenedApp: $message");
//       _handleNotificationClick(message);
//     });

//     FirebaseMessaging.onLaunch.listen((RemoteMessage message) {
//       // Manejar la notificación cuando la aplicación está cerrada
//       print("onLaunch: $message");
//       _handleNotificationClick(message);
//     });
//   }

//   Future<void> _handleNotificationClick(RemoteMessage message) async {
//     print("Handling notification click: ${message.notification?.title}");

//     // Aquí es donde puedes implementar la lógica para navegar a la pantalla deseada
//     if (message.data['ruta_destino'] != null) {
//       final String rutaDestino = message.data['ruta_destino'];
//       navigatorKey.currentState?.pushNamed(rutaDestino, arguments: message.data);
//     }
//   }
// }