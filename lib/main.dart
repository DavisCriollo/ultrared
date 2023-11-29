import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/controllers/socket_service.dart';
import 'package:ultrared/src/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return   MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => SocketService()),
         ChangeNotifierProvider(create: (_) => ChatController()),
         ChangeNotifierProvider(create: (_) => HomeController())
       
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'Utrared App',
         initialRoute: 'login',
         routes: appRoutes,
      ),
    );
  }
}