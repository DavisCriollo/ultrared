import 'package:flutter/material.dart';
import 'package:ultrared/src/pages/acceso_gps_page.dart';
import 'package:ultrared/src/pages/auxilio_page.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/pages/foto_casa_page.dart';
import 'package:ultrared/src/pages/foto_perfil_page.dart';
import 'package:ultrared/src/pages/home_page.dart';
import 'package:ultrared/src/pages/lista_notificaciones.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/password_page.dart';
import 'package:ultrared/src/pages/pruebas.dart';
import 'package:ultrared/src/pages/registro_page.dart';
import 'package:ultrared/src/pages/selecciona_planes_page.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';
import 'package:ultrared/src/pages/splash_screen.dart';
import 'package:ultrared/src/pages/view_video_page.dart';







final Map<String, Widget Function(BuildContext)> appRoutes = {
  'splash': (_) => const SplashPage(),
  'gps': (_) => const AccesoGPSPage(),
  'login': (_) => const LoginPage(),
  // 'home': (_) => const SocketStatusScreen(),
  'serCliente': (_) => const SerClientePage(),
  // 'login': (_) => const SerClientePage(),

  'home': (_) => const HomePage(),

  // 'home': (_) => const FotosPerfilPage(),
  'auxilo': (_) => const AuxilioPage(),
  'notificaciones': (_) => const ListaNotificaciones(),
  'prueba': (_) =>  MyApp(),

  
  // 'home': (_) =>   ChatPage()
  // 'home': (_) => const PasswordPage(),
  // 'home': (_) => const RegistroPage(),
  // 'password': (_) =>  const PasswordPage(),
  // 'home': (_) => const HomePage(),
  // 'home': (_) =>  MyHomePage(),

 
  
};

