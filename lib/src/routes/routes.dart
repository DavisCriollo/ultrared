import 'package:flutter/material.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/pages/foto_casa_page.dart';
import 'package:ultrared/src/pages/foto_perfil_page.dart';
import 'package:ultrared/src/pages/home_page.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/password_page.dart';
import 'package:ultrared/src/pages/pruebas.dart';
import 'package:ultrared/src/pages/registro_page.dart';
import 'package:ultrared/src/pages/selecciona_planes_page.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';







final Map<String, Widget Function(BuildContext)> appRoutes = {
  // 'splash': (_) => const SplashPage(),
  // 'login': (_) => const LoginPage(),
  // 'home': (_) => const SocketStatusScreen(),
  // 'home': (_) => const SerClientePage(),
  'login': (_) => const SerClientePage(),
  // 'home': (_) => const SeleccionaPlanPage(),
  // 'home': (_) => const FotosPerfilPage(),
  // 'home': (_) => const FotosCasaPage()
  // 'home': (_) => const FotosCasaPage()
  // 'home': (_) => const ListaUsuariosChat()
  // 'home': (_) =>   ChatPage()
  // 'home': (_) => const PasswordPage(),
  // 'home': (_) => const RegistroPage(),
  // 'password': (_) =>  const PasswordPage(),
  // 'home': (_) => const HomePage(),
  // 'home': (_) =>  MyHomePage(),

 
  
};

