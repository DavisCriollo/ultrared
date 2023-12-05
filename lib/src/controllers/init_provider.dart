import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// // enum SocketStatus { conectado, desconectado, conectando }

// // class SocketService extends ChangeNotifier {
// //   late io.Socket _socket;
// //   SocketStatus _status = SocketStatus.desconectado;

// //   SocketService() {
// //     _socket = io.io('tu_socket_url', <String, dynamic>{
// //       'transports': ['websocket'],
// //       'autoConnect': false,
// //     });

// //     _socket.onConnect((_) {
// //       _setStatus(SocketStatus.conectado);
// //     });

// //     _socket.onDisconnect((_) {
// //       _setStatus(SocketStatus.desconectado);
// //     });

// //     _socket.connect();
// //   }

// //   SocketStatus get status => _status;

// //   void _setStatus(SocketStatus nuevoEstado) {
// //     _status = nuevoEstado;
// //     notifyListeners();
// //   }

// //   void conectar() {
// //     if (_status == SocketStatus.desconectado) {
// //       _setStatus(SocketStatus.conectando);
// //       _socket.connect();
// //     }
// //   }

// //   void desconectar() {
// //     if (_status == SocketStatus.conectado) {
// //       _socket.disconnect();
// //     }
// //   }

// //   void enviarMensaje(String mensaje) {
// //     if (_status == SocketStatus.conectado) {
// //       _socket.emit('enviarMensaje', mensaje);
// //     }
// //   }
// // }






// // import 'package:flutter/material.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as io;

// // enum SocketStatus { conectado, desconectado, conectando }

// // class SocketService extends ChangeNotifier {
// //  late io.Socket _socket;
// //   SocketStatus _status = SocketStatus.desconectado;

// //   SocketService() {
// //     _socket = io.io('https://backsigeop.neitor.com', <String, dynamic>{
// //       'transports': ['websocket'],
// //       'autoConnect': false,
// //     });

// //     _socket.onConnect((_) {
// //       _setStatus(SocketStatus.conectado);
// //     });

// //     _socket.onDisconnect((_) {
// //       _setStatus(SocketStatus.desconectado);
// //     });

// //     _socket.connect();
// //   }

// //   SocketStatus get status => _status;

// //   void _setStatus(SocketStatus nuevoEstado) {
// //     _status = nuevoEstado;
// //     notifyListeners();
// //   }

// //   void conectar() {
// //     if (_status == SocketStatus.desconectado) {
// //       _setStatus(SocketStatus.conectando);
// //       _socket.connect();
// //     }
// //   }

// //   void desconectar() {
// //     if (_status == SocketStatus.conectado) {
// //       _socket.disconnect();
// //     }
// //   }

 
// //   void escucharDesdeServidor(String evento, Function(dynamic) callback) {
// //     _socket.on(evento, (data) {
// //       callback(data);
// //       notifyListeners();
// //     });
// //   }
// // //-------------------  ENVIA Y RECIBE MENSAJJE------------------------//


// //   void enviarMensaje(Map<String,dynamic>_data) {
// //     if (_status == SocketStatus.conectado) {
// //       _socket.emit('client:guardarData', _data);
// //     }
// //   }
 






// // }






// import 'package:flutter/foundation.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// enum SocketStatus { conectado, desconectado, conectando }

// class SocketService extends ChangeNotifier {
//   late io.Socket _socket;
//   SocketStatus _status = SocketStatus.desconectado;

//   SocketService() {
//     _socket = io.io('https://backsigeop.neitor.com', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     _socket.onConnect((_) {
//       _setStatus(SocketStatus.conectado);
//     });

//     _socket.onDisconnect((_) {
//       _setStatus(SocketStatus.desconectado);
//     });

//     _socket.connect();
//   }

//   SocketStatus get status => _status;

//   void _setStatus(SocketStatus nuevoEstado) {
//     _status = nuevoEstado;
//     notifyListeners();
//   }

//   void conectar() {
//     if (_status == SocketStatus.desconectado) {
//       _setStatus(SocketStatus.conectando);
//       _socket.connect();
//     }
//   }

//   void desconectar() {
//     if (_status == SocketStatus.conectado) {
//       _socket.disconnect();
//     }
//   }

//   void escucharDesdeServidor(String evento, Function(dynamic) callback) {
//     _socket.on(evento, (data) {
//       callback(data);
//       notifyListeners();
//     });
//   }

//   // Nueva función para enviar token y cédula
//   void enviarTokenYCedula(String token, String cedula) {
//     if (_status == SocketStatus.conectado) {
//       Map<String, dynamic> data = {
//         'token': token,
//         'cedula': cedula,
//       };
//       _socket.emit('client:enviarTokenYCedula', data);
//     }
//   }

//   // Función existente para enviar mensajes
//   void enviarMensaje(Map<String, dynamic> _data) {
//     if (_status == SocketStatus.conectado) {
//       _socket.emit('client:guardarData', _data);
//     }
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
//-----------------------//

// enum SocketStatus { conectado, desconectado, conectando }

// class SocketService extends ChangeNotifier {
//   late io.Socket _socket;
//   SocketStatus _status = SocketStatus.desconectado;
//   String? _token;
//   String? _cedula;

//   SocketService() {
//     _socket = io.io('https://backsigeop.neitor.com', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//        'query': {'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoyLCJydWNlbXByZXNhIjoiVUxUUkEyMDIyIiwidXN1YXJpbyI6ImFkbWluIiwicm9sIjpbIlNVUEVSQURNSU4iXSwiaWF0IjoxNzAxNjMyODYzLCJleHAiOjE3MDE2NzYwNjN9.LTZbsZy_HMxcaThcJLv6gd9jNQ0PyYSpDIT9DYBwCKI', 'cedula': 'ULTRA2022'},
     
     
//     });

//     _socket.onConnect((_) {
//       _setStatus(SocketStatus.conectado);
//        print(' EL SOCKET  ESTA CONECTADO.....');
//     });

//     _socket.onDisconnect((_) {
//       _setStatus(SocketStatus.desconectado);
//     });
// _socket.emit( 'client:lista-usuarios', {"chat_id": 4} );

//        _socket.on('server:lista-usuarios', (data) {

//         print('LA DATA DESDE EL SOCKET : $data');
     
//       notifyListeners();
//     });







//     // No conectarse automáticamente al inicio
//   }

//   SocketStatus get status => _status;

//   void _setStatus(SocketStatus nuevoEstado) {
//     _status = nuevoEstado;
//     notifyListeners();
//   }

//   void setTokenAndCedula(String token, String cedula) {
//     _token = token;
//     _cedula = cedula;

//     if (_status == SocketStatus.desconectado) {
//       _setStatus(SocketStatus.conectando);
//       _socket.io.options!['query'] = {'token': _token, 'cedula': _cedula};
//       _socket.connect();
//     } else {
//       // Si el socket ya está conectado, actualizar los parámetros de la conexión
//       _socket.io.options!['query'] = {'token': _token, 'cedula': _cedula};
//     }
//   }

//   void conectar() {
//     if (_status == SocketStatus.desconectado) {
//       _setStatus(SocketStatus.conectando);
//       _socket.connect();
//     }
//   }

//   void desconectar() {
//     if (_status == SocketStatus.conectado) {
//       _socket.disconnect();
//     }
//   }

//   // void escucharDesdeServidor(String evento, Function(dynamic) callback) {
//   //   _socket.on(evento, (data) {
//   //     callback(data);
//   //     notifyListeners();
//   //   });
//   // }
//   void escucharDesdeServidor(String evento, Function(Map<String,dynamic>) callback) {
//     _socket.on(evento, (data) {
//       callback(data);
//          print('LA DATA DESDE EL servidot : $data');
//       notifyListeners();
//     });
//   }

//   void enviarMensaje( String _title, Map<String, dynamic> _data) {
//     if (_status == SocketStatus.conectado) {
//       _socket.emit(_title, _data);
//          print('LA DATA del cliente: $_title -  $_data');
//     }
//   }



// class ChatProvider with ChangeNotifier {
//   final AuthProvider authProvider;
//   late io.Socket socket;

//   ChatProvider(this.authProvider) {
//     connectToSocket();
//   }

//   void connectToSocket() {
//     socket = io.io('your_socket_server_url', <String, dynamic>{
//       'transports': ['websocket'],
//       'extraHeaders': {'token': authProvider.token, 'cedula': authProvider.cedula},
//     });

//     socket.onConnect((_) {
//       print('Conectado al servidor de sockets');
//     });

//     socket.onDisconnect((_) {
//       print('Desconectado del servidor de sockets');
//     });

//     socket.on('mensaje', (data) {
//       print('Mensaje recibido: $data');
//       // Puedes manejar el mensaje según tus necesidades
//     });
//   }

//   void sendMessage(String message) {
//     socket.emit('enviar_mensaje', {'mensaje': message});
//   }
// }







// }




// import 'package:flutter/material.dart';

// class InitProvider with ChangeNotifier {
//    String _token = "";
//    String _rucempresa = "";

//   String get token => _token;
//   String get rucempresa => _rucempresa;

//   void conficProvider(String _token, String _ruc) {
//     _token = _token;
//     _rucempresa = _ruc;
//     notifyListeners();
//   }
// }
