import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';

import 'package:ultrared/src/routes/routes.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/service/socket_service.dart';

void main() => runApp(const MyApp());

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
  }



  @override
  Widget build(BuildContext context) {
    //  SystemChrome.setPreferredOrientations(
    //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return   MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => SocketService()),
         ChangeNotifierProvider(create: (_) => ChatController()),
         ChangeNotifierProvider(create: (_) => HomeController())
       
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'Utrared App',
        //  initialRoute: 'home',
         initialRoute: 'splash',
         routes: appRoutes,
             scaffoldMessengerKey: NotificatiosnService.messengerKey,
      ),
    );
  }
}