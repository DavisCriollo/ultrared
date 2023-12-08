// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
// import 'package:sincop_app/src/service/notifications_service.dart';

// // import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'package:socket_io_client/socket_io_client.dart' as IO;

// enum ServerStatus {
//   Online,
//   Ofline,
//   Connecting,
// }

// class SocketService extends ChangeNotifier {
//   ServerStatus _serverStatus = ServerStatus.Connecting;

  

// // EXPONER DE MANERA PRIVADA PARA CONTROLAR LA MANERA DE EXPOSICION AL MUBDO , PANTALLA, CLASE
//   late IO.Socket? _socket;

//   ServerStatus get serverStatus => _serverStatus;
//   // String? _serverResponses;
//   // String? get serverResponses => _serverResponses;

//   IO.Socket? get socket => _socket;

//   SocketService() {
   
//     _initConfig();
//   }

//   void _initConfig() {
//     // Dart client
//     // _socket = IO.io('https://contabackend.neitor.com', {
//     // _socket = IO.io('http://192.168.1.4:3000', {
//     //       'transports': ['websocket'],
//     //   'autoConnect': true,
//     // });
//     _socket = IO.io('https://testconta.neitor.com', <String, dynamic>{
//       'transports': ['websocket'],
//       // 'extraHeaders': {
//       //   'rucempresa': authProvider.rucempresa,
//       //   'x-auth-token': authProvider.token,
//       // },
//        'autoConnect': true,
//       'query': {
//         'rucempresa': authProvider.rucempresa,
//         'x-auth-token': authProvider.token,
//       }
   
//     });


 

//     _socket?.onConnect((_) {
//       // print('David conectado desde Flutter !!! ');
//       _serverStatus = ServerStatus.Online;
      
//       // NotificatiosnService.showSnackBarDanger("Bienvenido");


//       notifyListeners();
//     });

//     _socket?.onDisconnect((_) {
//       // print('disconnect fdfdf');
//       _serverStatus = ServerStatus.Ofline;

      

//       // NotificatiosnService.showSnackBarError("Sin conexión a internet");
//       // _socket = null;
//       notifyListeners();
//     });


   
//   }
// }


import 'package:flutter/material.dart';

// class AuthProvider with ChangeNotifier {
//   String _token = "";
//   String _rucempresa = "";

//   String get token => _token;
//   String get rucempresa => _rucempresa;

//   void login(String token, String rucempresa) {
//     _token = token;
//     _rucempresa = rucempresa;

//     notifyListeners();
//   }
// }


class AuthProvider with ChangeNotifier {
  String _token = '';
  String _rucempresa = '';

  String get token => _token;
  String get rucempresa => _rucempresa;

  void setCredentials(String token, String rucempresa) {
    _token = token;
    _rucempresa = rucempresa;
    notifyListeners();
  }
}