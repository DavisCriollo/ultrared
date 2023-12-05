// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// // import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:ultrared/src/controllers/init_provider.dart';
import 'package:ultrared/src/controllers/login_controller.dart';
import 'package:ultrared/src/service/notifications_service.dart';

// enum ServerStatus {
//   Online,
//   Ofline,
//   Connecting,
// }

// class SocketService extends ChangeNotifier {
//   ServerStatus _serverStatus = ServerStatus.Connecting;

//    late String _token;
//    late String _cedula;

// // EXPONER DE MANERA PRIVADA PARA CONTROLAR LA MANERA DE EXPOSICION AL MUBDO , PANTALLA, CLASE
//   late IO.Socket? _socket;

//   ServerStatus get serverStatus => _serverStatus;

//   // String? _serverResponses;
//   // String? get serverResponses => _serverResponses;

//   IO.Socket? get socket => _socket;

//   SocketService() {

//    SocketService(String token, String ruc) {
//     _token = token;
//     _cedula = _cedula;
//     _initConfig();
//   }
//   }

//   void _initConfig() {
//     // Dart client
//     // _socket = IO.io('https://contabackend.neitor.com', {
//     // _socket = IO.io('http://192.168.1.4:3000', {
//     //       'transports': ['websocket'],
//     //   'autoConnect': true,
//     // });
//     _socket = IO.io(

//         'https://testconta.neitor.com',
//         IO.OptionBuilder()
//             .setTransports(['websocket']) // for Flutter or Dart VM
//             .enableAutoConnect()
//             // .setExtraHeaders({'foo': 'bar'}) // optional

//             .build());

//    void _enviarDatos() {
//     if (_socket != null && _socket!.connected) {
//       _socket!.emit('enviarDatos', {'token': _token, 'ruc': _cedula});
//     }
//   }

//     _socket?.onConnect((_) {
//       // print('David conectado desde Flutter !!! ');
//       _serverStatus = ServerStatus.Online;
//     _enviarDatos();
//       // NotificatiosnService.showSnackBarDanger("Bienvenido");
//        print('Usuario conectado desde Flutter !!! ');

//       notifyListeners();
//     });

//  void actualizarDatosParaSocket(String nuevoToken, String nuevoCedula) {
//     _token = nuevoToken;
//     _cedula = nuevoCedula;
//     _enviarDatos(); // Llama a la función para enviar el nuevo token y RUC
//   }

//     _socket?.onDisconnect((_) {
//       // print('disconnect fdfdf');
//       _serverStatus = ServerStatus.Ofline;

//       // NotificatiosnService.showSnackBarError("Sin conexión a internet");
//       // _socket = null;
//       notifyListeners();
//     });

//        // Nuevos métodos públicos para uso externo
//   void enviarDatosExternamente(String token, String ruc) {
//     _token = token;
//     _cedula = ruc;
//     _enviarDatos();
//   }

//   void actualizarDatosExternamente(String nuevoToken, String nuevoRuc) {
//     _token = nuevoToken;
//     _cedula = nuevoRuc;
//     _enviarDatos();
//   }

//        _socket!.on(' server:lista-usuarios', (data) async {
//          print('server:lista-usuarios : $data');

//     });

//    // ======================================== FUNCION PARA RESPONDER AL SOCKET==============================================//
//     // final controllerHome = Provider.of<HomeController>();
//     // final controllerInformes = InformeController();
// // print('========================PAILOAD=================================');
// //     print('$_pyloadDataIniciaTurno');

// //     _socket!.on('server:guardadoExitoso', (data) async {
// //       if (data['tabla'] == 'registro') {

// //         // await Auth.instance.saveTurnoSession(true);
// //         // controllerHome.setValidaBtnTurno(true);
// //         // _validaBtnTurno = true;
// //         NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //         // _socket?.clearListeners();
// //         notifyListeners();
// //         // Navigator.of(context).pop();
// //       }
// //     });
// //     _socket?.on('server:error', (data) {
// //       NotificatiosnService.showSnackBarError(data['msg']);
// //       // _socket?.clearListeners();
// //       notifyListeners();
// //     });

// //      _socket!.on('server:guardadoExitoso', (data) {

// //       if (data['tabla'] == 'pedido') {
// //         print('payload GUARDA ok======> $data');
// //         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //         // print('data##############> $data');
// // //         // controllerInformes.buscaInformeGuardias('');

// // //  data.remove('rucempresa');
// // //        data.remove('rol');
// // //        data.remove('tabla');
// // //        data.remove('msg');

// // // final listaData=Informe.fromMap(data);

// // // // map.entries.map((e) => list.add({e.key: e.value})).toList();

// // // // controllerInformes.setinformeGuardia(listaData );

// // //         controllerInformes.setInfoBusquedaInformesGuardia([listaData]);

// // //         // _socket?.clearListeners();

// //       }
// //     });
// //        _socket!.on('server:eliminadoExitoso', (data) async {
// //         if (data['tabla'] == 'pedido') {
// // print('payload ELIMIN ok======> $data');
// //           // buscaInformeGuardias('');
// //           // NotificatiosnService.showSnackBarSuccsses(data['msg']);
// //           // serviceSocket.socket?.clearListeners();
// //           // notifyListeners();
// //         }
// //       });
// //       _socket?.on('server:error', (data) {
// //         // _serverResponses = data;
// //         NotificatiosnService.showSnackBarError(data['msg']);
// //         notifyListeners();
// //       });
// //     }

//   }

// }

class InitProvider with ChangeNotifier {
  String _token = "";
  String _rucempresa = "";

  String get token => _token;
  String get rucempresa => _rucempresa;

  void login(String token, String rucempresa) {
    // print('token:$token * rucempresa:$rucempresa');
    _token = token;
    _rucempresa = rucempresa;

    notifyListeners();
  }
}

class SocketService with ChangeNotifier {
  late InitProvider authProvider;
  late IO.Socket socket;

  SocketService(this.authProvider) {
    connectToSocket();
  }

  void updateHeaders() {
    socket.io.options!['extraHeaders'] = {
      'token': authProvider.token,
      'cedula': authProvider._rucempresa
    };
  }

  void connectToSocket() {
    socket = IO.io('https://testconta.neitor.com', <String, dynamic>{
      'transports': ['websocket'],
      // 'extraHeaders': {
      //   'rucempresa': authProvider.rucempresa,
      //   'x-auth-token': authProvider.token,
      // },
       'forceNew': true,
      'query': {
        'rucempresa': authProvider.rucempresa,
        'x-auth-token': authProvider.token,
      }
    });
    //  socket = IO.io(
    //     // 'http://192.168.1.4:3000',
    //     // 'https://contabackend.neitor.com',
    //     // 'https://sigeop.neitor.com',
    //     'https://testconta.neitor.com',
    //     IO.OptionBuilder()
    //         .setTransports(['websocket']) // for Flutter or Dart VM
    //         .enableAutoConnect()
    //       .setExtraHeaders({
    //     'rucempresa': authProvider.rucempresa,
    //     'x-auth-token': authProvider.token,
    //   },) 
    //         .build());



     socket.onConnect((_) {
      print('Conectado al servidor de sockets');
    });
  


    socket.onDisconnect((_) {
      print('Desconectado del servidor de sockets');
    });

      socket.on('server:lista-chats-grupos', (data) async {
      print('server:lista-usuarios dsdsd : $data');
    });
  }

 void disconnectServer() {
    socket.disconnect();
    print('Desconectado del servidor de sockets');
  }
  void sendMessage(String message, Map<String, dynamic> _data) {
    // Actualizar las cabeceras antes de enviar el mensaje
    // updateHeaders();

    // Emitir el mensaje al servidor
    socket.emit(message, _data);

   




  }
}
