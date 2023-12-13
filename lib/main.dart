import 'package:audioplayers/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';


import 'package:ultrared/src/routes/routes.dart';
import 'package:ultrared/src/service/local_notifications.dart';
import 'package:ultrared/src/service/notification_push.dart';
import 'package:ultrared/src/service/notifications_service.dart';

import 'package:ultrared/src/service/socket_service.dart';


void main()  async{

   WidgetsFlutterBinding.ensureInitialized();
await FirebaseService.initializeFirebase();

//  final notificationService = NotificationService();
//  await NotificationHelper().initialize();
await Firebase.initializeApp();
  await NotificationHelper().initialize();
  await requestNotificationPermission();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        
      },
    );
    //  FirebaseService.getFirebaseToken().then((token) {
    //   print("Firebase Token: $token");
    // });

    // FirebaseService.configureFirebaseMessaging();
  }


  @override
  Widget build(BuildContext context) {


    return   MultiProvider(
      providers: [
  

         ChangeNotifierProvider(create: (_) => SocketModel()),
         ChangeNotifierProvider(create: (_) => HomeController()),
     ChangeNotifierProvider(create: (_) => ChatController()),



      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'Utrared App',
        //  initialRoute: 'home',
         initialRoute: 'splash', 
        //  initialRoute: 'auxilo',
         routes: appRoutes,
             scaffoldMessengerKey: NotificatiosnService.messengerKey,
      ),
    );
  }
}