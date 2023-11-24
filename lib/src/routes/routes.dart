import 'package:flutter/material.dart';
import 'package:ultrared/src/pages/home_page.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/selecciona_planes_page.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';







final Map<String, Widget Function(BuildContext)> appRoutes = {
  // 'splash': (_) => const SplashPage(),
  // 'login': (_) => const LoginPage(),
  // 'home': (_) => const SocketStatusScreen(),
  // 'home': (_) => const SerClientePage(),
  // 'home': (_) => const LoginPage(),
  'home': (_) => const SeleccionaPlanPage(),
  // 'password': (_) =>  const PasswordPage(),

 
  
};

