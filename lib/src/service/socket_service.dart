// // import 'package:flutter/material.dart';

// // import 'package:provider/provider.dart';

// // // import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:ultrared/src/controllers/init_provider.dart';
// import 'package:ultrared/src/controllers/login_controller.dart';
// import 'package:ultrared/src/service/notifications_service.dart';

// // enum ServerStatus {
// //   Online,
// //   Ofline,
// //   Connecting,
// // }

// // class SocketService extends ChangeNotifier {
// //   ServerStatus _serverStatus = ServerStatus.Connecting;

// //    late String _token;
// //    late String _cedula;

// // // EXPONER DE MANERA PRIVADA PARA CONTROLAR LA MANERA DE EXPOSICION AL MUBDO , PANTALLA, CLASE
// //   late IO.Socket? _socket;

// //   ServerStatus get serverStatus => _serverStatus;

// //   // String? _serverResponses;
// //   // String? get serverResponses => _serverResponses;

// //   IO.Socket? get socket => _socket;

// //   SocketService() {

// //    SocketService(String token, String ruc) {
// //     _token = token;
// //     _cedula = _cedula;
// //     _initConfig();
// //   }
// //   }

// //   void _initConfig() {
// //     // Dart client
// //     // _socket = IO.io('https://contabackend.neitor.com', {
// //     // _socket = IO.io('http://192.168.1.4:3000', {
// //     //       'transports': ['websocket'],
// //     //   'autoConnect': true,
// //     // });
// //     _socket = IO.io(

// //         'https://testconta.neitor.com',
// //         IO.OptionBuilder()
// //             .setTransports(['websocket']) // for Flutter or Dart VM
// //             .enableAutoConnect()
// //             // .setExtraHeaders({'foo': 'bar'}) // optional

// //             .build());

// //    void _enviarDatos() {
// //     if (_socket != null && _socket!.connected) {
// //       _socket!.emit('enviarDatos', {'token': _token, 'ruc': _cedula});
// //     }
// //   }

// //     _socket?.onConnect((_) {
// //       // print('David conectado desde Flutter !!! ');
// //       _serverStatus = ServerStatus.Online;
// //     _enviarDatos();
// //       // NotificatiosnService.showSnackBarDanger("Bienvenido");
// //        print('Usuario conectado desde Flutter !!! ');

// //       notifyListeners();
// //     });

// //  void actualizarDatosParaSocket(String nuevoToken, String nuevoCedula) {
// //     _token = nuevoToken;
// //     _cedula = nuevoCedula;
// //     _enviarDatos(); // Llama a la función para enviar el nuevo token y RUC
// //   }

// //     _socket?.onDisconnect((_) {
// //       // print('disconnect fdfdf');
// //       _serverStatus = ServerStatus.Ofline;

// //       // NotificatiosnService.showSnackBarError("Sin conexión a internet");
// //       // _socket = null;
// //       notifyListeners();
// //     });

// //        // Nuevos métodos públicos para uso externo
// //   void enviarDatosExternamente(String token, String ruc) {
// //     _token = token;
// //     _cedula = ruc;
// //     _enviarDatos();
// //   }

// //   void actualizarDatosExternamente(String nuevoToken, String nuevoRuc) {
// //     _token = nuevoToken;
// //     _cedula = nuevoRuc;
// //     _enviarDatos();
// //   }

// //        _socket!.on(' server:lista-usuarios', (data) async {
// //          print('server:lista-usuarios : $data');

// //     });

// //    // ======================================== FUNCION PARA RESPONDER AL SOCKET==============================================//
// //     // final controllerHome = Provider.of<HomeController>();
// //     // final controllerInformes = InformeController();
// // // print('========================PAILOAD=================================');
// // //     print('$_pyloadDataIniciaTurno');

// // //     _socket!.on('server:guardadoExitoso', (data) async {
// // //       if (data['tabla'] == 'registro') {

// // //         // await Auth.instance.saveTurnoSession(true);
// // //         // controllerHome.setValidaBtnTurno(true);
// // //         // _validaBtnTurno = true;
// // //         NotificatiosnService.showSnackBarSuccsses(data['msg']);
// // //         // _socket?.clearListeners();
// // //         notifyListeners();
// // //         // Navigator.of(context).pop();
// // //       }
// // //     });
// // //     _socket?.on('server:error', (data) {
// // //       NotificatiosnService.showSnackBarError(data['msg']);
// // //       // _socket?.clearListeners();
// // //       notifyListeners();
// // //     });

// // //      _socket!.on('server:guardadoExitoso', (data) {

// // //       if (data['tabla'] == 'pedido') {
// // //         print('payload GUARDA ok======> $data');
// // //         // NotificatiosnService.showSnackBarSuccsses(data['msg']);
// // //         // print('data##############> $data');
// // // //         // controllerInformes.buscaInformeGuardias('');

// // // //  data.remove('rucempresa');
// // // //        data.remove('rol');
// // // //        data.remove('tabla');
// // // //        data.remove('msg');

// // // // final listaData=Informe.fromMap(data);

// // // // // map.entries.map((e) => list.add({e.key: e.value})).toList();

// // // // // controllerInformes.setinformeGuardia(listaData );

// // // //         controllerInformes.setInfoBusquedaInformesGuardia([listaData]);

// // // //         // _socket?.clearListeners();

// // //       }
// // //     });
// // //        _socket!.on('server:eliminadoExitoso', (data) async {
// // //         if (data['tabla'] == 'pedido') {
// // // print('payload ELIMIN ok======> $data');
// // //           // buscaInformeGuardias('');
// // //           // NotificatiosnService.showSnackBarSuccsses(data['msg']);
// // //           // serviceSocket.socket?.clearListeners();
// // //           // notifyListeners();
// // //         }
// // //       });
// // //       _socket?.on('server:error', (data) {
// // //         // _serverResponses = data;
// // //         NotificatiosnService.showSnackBarError(data['msg']);
// // //         notifyListeners();
// // //       });
// // //     }

// //   }

// // }


// // class InitProvider with ChangeNotifier {
// //   String _token = "";
// //   String _rucempresa = "";

// //   String get token => _token;
// //   String get rucempresa => _rucempresa;

// //   void login(String token, String rucempresa) {
// //     // print('token:$token * rucempresa:$rucempresa');
// //     _token = token;
// //     _rucempresa = rucempresa;

// //     notifyListeners();
// //   }
// // }

// // class SocketService with ChangeNotifier {
// //   late InitProvider authProvider;
// //   late IO.Socket socket;

// //   SocketService(this.authProvider) {
// //     connectToSocket();
// //      notifyListeners();
// //   }

// //   void updateHeaders() {
// //     socket.io.options!['extraHeaders'] = {
// //       'token': authProvider.token,
// //       'cedula': authProvider._rucempresa
// //     };
// //   }

// //   void connectToSocket() {
// //     socket = IO.io('https://testconta.neitor.com', <String, dynamic>{
// //       'transports': ['websocket'],
// //       // 'extraHeaders': {
// //       //   'rucempresa': authProvider.rucempresa,
// //       //   'x-auth-token': authProvider.token,
// //       // },
// //        'autoConnect': true,
// //       'query': {
// //         'rucempresa': authProvider.rucempresa,
// //         'x-auth-token': authProvider.token,
// //       }
   
// //     });
   
// //   socket.onConnect((_) {
// //      print('Conectado  servidor de sockets OK');
// //   });


// //     socket.onDisconnect((_) {
// //       print('Desconectado del servidor de sockets');
// //     });

// //       socket.on('server:lista-usuarios', (data) async {
// //       // print('server:lista-usuarios dsdsd : $data')
// //       print('server:lista-chats-grupos dsdsd : $data');
// //     });
// //   }

// //  void disconnectServer() {
// //     socket.disconnect();
// //     print('Desconectado del servidor de sockets');
// //   }
// //   void sendMessage(String message, Map<String, dynamic> _data) {
// //     // Actualizar las cabeceras antes de enviar el mensaje
// //     // updateHeaders();

// //     // itir el mensaje al servidor
// //     socket.emit(message, _data);

   




// //   }
// // }



// // class SocketService with ChangeNotifier {
// //   static const String serverUrl = 'tu_url_del_servidor';
// //   static const String namespace = '/';

// //   late IO.Socket _socket;

// //   IO.Socket get socket => _socket;

// // SocketService();

// //   void initSocket(String usuario, String cedula) {
// //     try {
// //       _socket = IO.io(
// //         serverUrl,
// //         <String, dynamic>{
// //           'transports': ['websocket'],
// //           'autoConnect': true,
// //           'query': {'usuario': usuario, 'cedula': cedula},
// //           'forceNew': true,
// //           'reconnectAttempts': 5,
// //         },
// //       );

// //       _socket.onConnect((_) {
// //         print('Conectado: ${_socket.id}');
// //         notifyListeners();
// //       });

// //       _socket.onDisconnect((_) {
// //         print('Desconectado');
// //         notifyListeners();
// //       });

// //       _socket.on('mensaje', (data) {
// //         print('Mensaje desde el servidor: $data');
// //         // Puedes agregar lógica para manejar el mensaje recibido desde el servidor
// //         notifyListeners();
// //       });
// //     } catch (e) {
// //       print('Error al conectar: $e');
// //     }
// //   }
// // }



// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as IO;

// // // Servicio de Socket
// // class SocketService with ChangeNotifier {
// //   static const String serverUrl = 'tu_url_del_servidor';
// //   late IO.Socket _socket;

// //   IO.Socket get socket => _socket;

// //   SocketService() {
// //     _initializeSocket();
// //   }

// //   void _initializeSocket() {
// //     try {
// //       _socket = IO.io(
// //         serverUrl,
// //         <String, dynamic>{
// //           'transports': ['websocket'],
// //           'autoConnect': true,
// //           'query': {},
// //           'forceNew': true,
// //           'reconnectAttempts': 5,
// //         },
// //       );

// //       _socket.onConnect((_) {
// //         print('Conectado: ${_socket.id}');
// //         notifyListeners();
// //       });

// //       _socket.onDisconnect((_) {
// //         print('Desconectado');
// //         notifyListeners();
// //       });

// //       _socket.on('mensaje', (data) {
// //         print('Mensaje desde el servidor: $data');
// //         // Puedes agregar lógica para manejar el mensaje recibido desde el servidor
// //         notifyListeners();
// //       });
// //     } catch (e) {
// //       print('Error al conectar: $e');
// //       throw e;
// //     }
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as IO;

// // class SocketService with ChangeNotifier {
// //   static const String serverUrl = 'tu_url_del_servidor';
// //   static const String namespace = '/';

// //   late IO.Socket _socket;

// //   IO.Socket get socket => _socket;

// //   SocketService() {
// //     _socket = _initializeSocket();
// //   }

// //   IO.Socket _initializeSocket() {
// //     try {
// //       final socket = IO.io(
// //         'https://testconta.neitor.com',
// //         <String, dynamic>{
// //           'transports': ['websocket'],
// //           'autoConnect': true,
// //           'forceNew': true,
// //           'reconnectAttempts': 5,
// //         },
// //       );

// //       socket.onConnect((_) {
// //         print('Conectado: ${socket.id}');
// //         notifyListeners();
// //       });

// //       socket.onDisconnect((_) {
// //         print('Desconectado');
// //         notifyListeners();
// //       });

// //       socket.on('mensaje', (data) {
// //         print('Mensaje desde el servidor: $data');
// //         // Puedes agregar lógica para manejar el mensaje recibido desde el servidor
// //         notifyListeners();
// //       });

// //       return socket;
// //     } catch (e) {
// //       print('Error al conectar: $e');
// //       throw e;
// //     }
// //   }

// //   void disconnectSocket() {
// //     if (_socket != null) {
// //       _socket.disconnect();
// //       _socket = _initializeSocket();
// //       notifyListeners();
// //     }
// //   }

// //   void emitMessage(String event, dynamic data) {
// //     if (_socket != null && _socket.connected) {
// //       _socket.emit(event, data);
// //     } else {
// //       print('Socket no inicializado o no conectado.');
// //     }
// //   }
// // }



// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';


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
//     _socket = IO.io(
//         // 'http://192.168.1.4:3000',
//         // 'https://contabackend.neitor.com',
//         // 'https://sigeop.neitor.com',
//         'sitio.com',
//         <String, dynamic>{
//           'transports': ['websocket'],
//           'autoConnect': true,
//            'query': {'token': usuario, 'ruc': cedula},
//           'forceNew': true,
//           'reconnectAttempts': 5,
//         },);


 

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

//     //======================================== FUNCION PARA RESPONDER AL SOCKET==============================================//

//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/service/provider_socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService with ChangeNotifier {
//    late AuthProvider _authProvider;
//   late IO.Socket socket;

//   set authProvider(AuthProvider value) {
//     _authProvider = value;
//     // Realiza cualquier acción necesaria cuando se establece el authProvider,
//     // como actualizar encabezados o reconectar al socket.
//     connectToSocket();
//   }

//   AuthProvider get authProvider => _authProvider;

//   SocketService() {
//     // No llames a connectToSocket aquí, ya que authProvider aún no se ha establecido.
//   }

//   void connectToSocket() {
//     if (_authProvider == null) {
//       throw Exception('AuthProvider no se ha establecido antes de conectar al socket');
//     }

//     socket = IO.io('https://testconta.neitor.com', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//       'query': {
//         'rucempresa': authProvider.rucempresa,
//         'x-auth-token': authProvider.token,
//       },
//     });

//     socket.onConnect((_) {
//       print('Conectado al servidor de sockets');
//     });

//     socket.onDisconnect((_) {
//       print('Desconectado del servidor de sockets');
//     });

//     socket.on('server:lista-usuarios', (data) async {
//       print('server:lista-usuarios: $data');
//     });
//   }

//   void disconnectServer() {
//     socket.disconnect();
//     print('Desconectado del servidor de sockets');
//   }

//   void sendMessage(String message, Map<String, dynamic> data) {
//     socket.emit(message, data);
//   }
// }

// class SocketProvider with ChangeNotifier {
//   late IO.Socket _socket;
//   bool _isConnected = false;

//   IO.Socket get socket {
//     if (_socket == null || !_isConnected) {
//       // Si el socket aún no se ha creado o no está conectado, crea una nueva instancia
//       _createSocket();
//     }
//     return _socket;
//   }

//   void createSocket() {
//     AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

//     _socket = IO.io('https://sitio', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//       'query': {
//         'rucempresa': authProvider.rucempresa,
//         'x-auth-token': authProvider.token,
//       },
//     });

//     // Agrega más lógica de manejo de eventos y conexiones según tus necesidades

//     _isConnected = true;
//   }

//   // Opcionalmente, puedes agregar un método para desconectar el socket cuando sea necesario
//   void disconnectSocket() {
//     if (_socket != null && _isConnected) {
//       _socket.disconnect();
//       _isConnected = false;
//     }
//   }
// }



// class SocketProvider with ChangeNotifier {
//   IO.Socket? _socket;

//   IO.Socket get socket => _socket!;

//   void initializeSocket(BuildContext context) {
//     if (_socket == null) {
//       var authProvider = Provider.of<AuthProvider>(context, listen: false);

//       _socket = IO.io('https://testconta.neitor.com', <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': true,
//         'query': {
//           'rucempresa': authProvider.rucempresa,
//           'x-auth-token': authProvider.token,
//         },
//       });

//       _socket!.onConnect((_) => print('Conectadooooooo------>'));

//  socket.on('server:lista-usuarios', (data) async {
//       // print('server:lista-usuarios dsdsd : $data')
//       print('server:lista-chats-grupos dsdsd : $data');
//     });


//       notifyListeners();
//     }
//   }
//   void disconnectSocket() {
//     if (_socket != null) {
//       _socket!.disconnect();
//       _socket = null;
//       notifyListeners();
//     }
//   }






//  void emitEvent(String eventName, dynamic data) {
//     if (_socket != null && _socket!.connected) {
//       _socket!.emit(eventName, data);
//     }
//   }

// }


// class SocketProvider with ChangeNotifier {
  
//   IO.Socket? _socket;

//   IO.Socket get socket => _socket!;

//   void initializeSocket() {
//     if (_socket == null) {
//       _socket = IO.io('https://testconta.neitorsss.com', <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': true,
//       });

//       _socket!.onConnect((_) => print('Conectado OK ...........'));
//       _socket!.onDisconnect((_) => print('DESCONECTADO DEL SERVIDOR'));

//     //    _socket!.emit('client:lista-usuarios', {
//     //    "chat_id" : 4
//     // });
//      _socket!.on('server:lista-usuarios', (data) async {
//       // print('server:lista-usuarios dsdsd : $data')
//       print('server:LISTA USUARIOS dsdsd : $data');
//     });
//      _socket!.on('server:lista-chats-grupos', (data) async {
//       // print('server:lista-usuarios dsdsd : $data')
//       print('server:LISTA CHAT GRUPOS dsdsd : $data');
//     });


//       notifyListeners();
//     }
//   }

//   void disconnectSocket() {
//     if (_socket != null) {
//       _socket!.disconnect();
//       _socket = null;
//       notifyListeners();
//     }
//   }

// void updateCredentials(String token, String rucempresa) {
//   if (_socket != null) {
//     // Actualiza las credenciales y reconecta el socket si está conectado
//     _socket!.disconnect();

//     // Concatena las credenciales en una cadena
//     String queryString = 'rucempresa=$rucempresa&x-auth-token=$token';
    
//     // Asigna la cadena de consulta al socket
//     _socket!.query = queryString;

//     _socket!.connect();
//   }
// }

//   void emitEvent(String eventName, dynamic data) {
//     if (_socket != null && _socket!.connected) {
//         // print('El socket está ${_socket!.query} ');
//         // print('El socket está ${_socket!.active} ');
//         // print('El socket está ${_socket!.subs} ');
//       _socket!.emit(eventName, data);
//     }
//   }

// void verificarConexion() {
//     if (_socket != null) {
//       bool estaConectado = _socket!.connected;
//       print('El socket está ' + (estaConectado ? 'conectado siiiiiii' : 'desconectado nooo'));
//     }
//   }

// }



class SocketModel with ChangeNotifier {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

 final ChatController _crtlChat = ChatController();


 List _listaGruposChat = [];
 List get getListaGruposChat => _listaGruposChat;

 Map<String,dynamic> _mensajeChat = {};
 Map<String,dynamic> get getMensajeChat => _mensajeChat;



  // Método para conectar Socket.io
  void connectToSocket(String token, String ruc) {
    _socket = IO.io('https://testconta.neitor.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'query': {
        'rucempresa': ruc,
        'x-auth-token': token,
      },
    });

    // Manejar eventos Socket.io según tus necesidades
    _socket.on('connect', (_) {
      print('Conectado al servidor');
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      print('Desconectado del servidor');
      notifyListeners();
    });

    // Ejemplo de cómo manejar un evento personalizado
    _socket.on('server:lista-chats-grupos', (data) {
      // print('Los grupos del servidor  -------#####   : $data');

   _listaGruposChat = [];
      _listaGruposChat = data;

 notifyListeners();

    });


 // Ejemplo de cómo manejar un evento personalizado
    _socket.on('server:lista-usuarios', (data) {
      // print('Mensaje desde el servidor: $data');
       
     _listaUsuariosChat = [];

   _listaUsuariosChat= data;
   notifyListeners();
    });

        //ESCUCHA LOS MENSAJES CHAT
_socket.on('server:send-mensaje', (data) {
  // print('MENSAJE CHAT: $data');
  _mensajeChat= {};
      _mensajeChat = data;
      // _crtlChat.setInfoBusquedaTodoLosChatPaginacion([{data}]);
    notifyListeners();
  // setMensajeDesdeServidor(data); // Actualizar el mensaje en el modelo
});
        //ESCUCHA LOS MENSAJES CHAT
        // ESCUCHAS EXTERNOS
  // List<VoidCallback> _listeners = [];

  // // Método para agregar oyentes externos
  // void addListener(VoidCallback listener) {
  //   _listeners.add(listener);
  // }




  }

  // Método para desconectar Socket.io
  void disconnectSocket() {
    _socket.disconnect();
    notifyListeners();
  }
   // Método para emitir eventos al servidor
  void emitEvent(String eventName, dynamic data) {
    _socket.emit(eventName, data);
  }


  // Método para establecer la información recibida
 List _mensajeDesdeServidor = [];
 List get mensajeDesdeServidor => _mensajeDesdeServidor;



 List _listaUsuariosChat = [];
 List get getListaUsuariosChat => _listaUsuariosChat;


  void setMensajeDesdeServidor(List _data) {
    if(_data.contains('chat_type')){
      _listaGruposChat = [];
      _listaGruposChat = _data;
    notifyListeners();

    }else{
      
   _listaUsuariosChat = [];

   _listaUsuariosChat= _data;
       notifyListeners();

    }

  }



  void reset() {
   _mensajeDesdeServidor=[];
    notifyListeners();
  }



}

