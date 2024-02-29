import 'package:flutter/material.dart';


import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
// class SocketService with ChangeNotifier {
//   late IO.Socket _socket;

//   IO.Socket get socket => _socket;

// //*********************//

//  final ChatController _crtlChat = ChatController();
//   final HomeController _crtlHome = HomeController();

//   List _listaGruposChat = [];
//   List get getListaGruposChat => _listaGruposChat;

//   void setGruposChat(List _groups) {
//     _listaGruposChat = [];
//     _listaGruposChat = _groups;
//     notifyListeners();
//   }

//   Map<String, dynamic> _listaNotificaciones = {};
//   Map<String, dynamic> get getListaNotificaciones => _listaNotificaciones;
//   List<Map<String, dynamic>> _listaDeMensajeChat = [];
//   List<Map<String, dynamic>> get getListaDeMensajeChat => _listaDeMensajeChat;

//   void resetInfoSocket() {
//     _user = {};
//     _isEnChat = false;
// // _listaGruposChat = [];
//     _listaNotificaciones = {};
//     _listaDeMensajeChat = [];
//     _msgNoLeidos = 0;
//     _listaUsuariosChat = [];
//     _mensajeChat = {};

//     notifyListeners();
//   }

//   Map<String, dynamic>? _user = {};
//   Map<String, dynamic>? get getUser => _user;
//   void setUserApp(Map<String, dynamic>? _data) {
//     _user = {};
//     _user = _data;
//     print('EL USER SOCKET ------------- >>>   $_user');
//     notifyListeners();
//   }

//   bool _isEnChat = false;
//   bool get getIsEnChat => _isEnChat;
//   void setIsEnChat(bool _data) {
//     _isEnChat = false;
//     _isEnChat = _data;

//     print('ESTA EN EL CHAT ------------- >>>   $_isEnChat');
//     notifyListeners();
//   }

//   //**********  AGREGA LOS MENSAJES AL CHAT **********//
//   void setListaDeMensajesChat(Map<String, dynamic> _msg) {
//     _listaDeMensajeChat.insert(0, _msg);
//    _listaDeMensajeChat
//         .sort((a, b) => b["message_id"].compareTo(a["message_id"]));
// // print('Los MENSAJES DEL SERVIDOR   ------->>>>   : $_listaDeMensajeChat');
//     notifyListeners();
//   }

//   // MUESTRA LOS GRUPOS  CHAT
//   int _msgNoLeidos = 0;
//   int get getMsgNoLeidos => _msgNoLeidos;
//   void setMsgNoLeidos(int _msgs) {
//     _msgNoLeidos = 0;
//     _msgNoLeidos = _msgs;
//     print(' *******************_msgNoLeidos : $_msgNoLeidos');
//     notifyListeners();
//   }

//   Map<String, dynamic> _mensajeChat = {};
//   Map<String, dynamic> get getMensajeChat => _mensajeChat;



//     List _listaUsuariosChat = [];
//   List get getListaUsuariosChat => _listaUsuariosChat;


// //*******************************************************//





//   // Singleton instance
//   static final SocketService _instance = SocketService._internal();

//   factory SocketService() {
//     return _instance;
//   }

//   SocketService._internal();


//    void connectToSocket(String token, String ruc) {
//     _socket = IO.io('https://testconta.neitor.com', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//       'forceNew':true,
//       'query': {
//         'rucempresa': ruc,
//         'x-auth-token': token,
//       },
//       'reconnect': false, // disable reconnection
//     });

// _socket.on('connect_error', (error) {
//   print('Error de conexión: $error');
//   // Manejar el error según sea necesario
// });
    
//      print('HASTA AQUI LLEGA ${_socket.query}');
//  // Manejar eventos Socket.io según tus necesidades
// socket.on('connect', (_) {
//   print('Conectado al servidor');
//   notifyListeners();
// });

// socket.on('disconnect', (_) {
//   print('Desconectado del servidor');
//     // reconnectSocket();
//   notifyListeners();
// });





//   }

// void emitEvent(String eventName, dynamic data) {
//   if (_socket != null && _socket.connected) {
//     _socket.emit(eventName, data);
//     print('SE EMITE ESTO AL SERVIDOR : $data');
//   } else {
//     print('El socket no está conectado');
//     // Si lo deseas, puedes intentar reconectar aquí
//     // reconnectSocket();
//   }
// }

//   // Función para escuchar eventos del socket
//   void listenToEvent(String eventName, void Function(dynamic) callback) {
//     _socket.on(eventName, (data) {
//       callback(data);
//     });
//   }


//   void deleteListChatSocket() {
//     _listaDeMensajeChat.clear();
//     notifyListeners();
//     // print('ELIMINADO Chat####################>:${deleteListChatSocket}');
//   }
//   // Función para reconectar el socket si está desconectado
//   // Función para reconectar el socket
// void reconnectSocket() async {
//     final session = await Auth.instance.getSession();
//     if (_socket == null || !_socket.connected) {
//       print('Intentando reconectar...');
//       connectToSocket(session['token'], session['rucempresa']);
//     }
//   }

//    // Función para cerrar la conexión del socket
//  void closeSocket() {
 
//     _socket.disconnected;
//     print('Socket cerrado');
//   } 


// }

enum  ServerStatus  {

  OnLine,Offline,Connecting,Error
}

class SocketService with ChangeNotifier {


ServerStatus  _socketStatus =ServerStatus.Connecting;
IO.Socket? _socket;

ServerStatus get serverStatus =>this._socketStatus;
IO.Socket get socket =>_socket!;

Function get emit =>this._socket!.emit;



// //*********************//

 final ChatController _crtlChat = ChatController();
  final HomeController _crtlHome = HomeController();

  List _listaGruposChat = [];
  List get getListaGruposChat => _listaGruposChat;

  void setGruposChat(List _groups) {
    _listaGruposChat = [];
    _listaGruposChat = _groups;
    notifyListeners();
  }

  Map<String, dynamic> _listaNotificaciones = {};
  Map<String, dynamic> get getListaNotificaciones => _listaNotificaciones;
  List<Map<String, dynamic>> _listaDeMensajeChat = [];
  List<Map<String, dynamic>> get getListaDeMensajeChat => _listaDeMensajeChat;

  void resetInfoSocket() {
    _user = {};
    _isEnChat = false;
// _listaGruposChat = [];
    _listaNotificaciones = {};
    _listaDeMensajeChat = [];
    _msgNoLeidos = 0;
    _listaUsuariosChat = [];
    _mensajeChat = {};

    notifyListeners();
  }

  Map<String, dynamic>? _user = {};
  Map<String, dynamic>? get getUser => _user;
  void setUserApp(Map<String, dynamic>? _data) {
    _user = {};
    _user = _data;
    print('EL USER SOCKET ------------- >>>   $_user');
    notifyListeners();
  }

  bool _isEnChat = false;
  bool get getIsEnChat => _isEnChat;
  void setIsEnChat(bool _data) {
    _isEnChat = false;
    _isEnChat = _data;

    print('ESTA EN EL CHAT ------------- >>>   $_isEnChat');
    notifyListeners();
  }

  //**********  AGREGA LOS MENSAJES AL CHAT **********//
  void setListaDeMensajesChat(Map<String, dynamic> _msg) {
    _listaDeMensajeChat.insert(0, _msg);
   _listaDeMensajeChat
        .sort((a, b) => b["message_id"].compareTo(a["message_id"]));
// print('Los MENSAJES DEL SERVIDOR   ------->>>>   : $_listaDeMensajeChat');
    notifyListeners();
  }

  // MUESTRA LOS GRUPOS  CHAT
  int _msgNoLeidos = 0;
  int get getMsgNoLeidos => _msgNoLeidos;
  void setMsgNoLeidos(int _msgs) {
    _msgNoLeidos = 0;
    _msgNoLeidos = _msgs;
    print(' *******************_msgNoLeidos : $_msgNoLeidos');
    notifyListeners();
  }

  Map<String, dynamic> _mensajeChat = {};
  Map<String, dynamic> get getMensajeChat => _mensajeChat;



    List _listaUsuariosChat = [];
  List get getListaUsuariosChat => _listaUsuariosChat;


// //**********  MUESTRA ALERTA DE ERROR *********************************************//

   String _msgErrorServer='';

   String get getMsgError=>_msgErrorServer;

   void setMsgErrorServer ( String _valor){
    _msgErrorServer=_valor;
    print('ESTADO DEL MSG ALERT : $_valor');
    notifyListeners();
   }

 //*******************************************************//




void connectSocket(String token, String ruc){

 _socket = IO.io('https://contabackend.neitor.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew':true,
      'query': {
        'rucempresa': ruc,
        'x-auth-token': token,
      },
      // 'reconnect': false, // disable reconnection
    });


_socket!.on('connect_error', (error) {
 _socketStatus=ServerStatus.Error;
  print('Error de conexión: $error');
 notifyListeners();
});
    
   _socket!.on('server:error', (error) {
// _msgErrorServer='';
setMsgErrorServer(error['msg']);

  print('Error del Socket : $error');
 notifyListeners();
});




 // Manejar eventos Socket.io según tus necesidades
_socket!.on('connect', (_) {
  _socketStatus=ServerStatus.OnLine;
  print('Conectado al servidor');
  notifyListeners();
});

_socket!.on('disconnect', (_) {
  _socketStatus=ServerStatus.Offline;
  print('Desconectado del servidor');
    // reconnectSocket();
  notifyListeners();
});



    // MUESTRA LOS GRUPOL CHAT
    _socket!.on('server:lista-chats-grupos', (data) {
      print('Los grupos del servidor  -------#####   : $data');

      _listaGruposChat = [];
      _listaGruposChat = data;



      notifyListeners();
    });
    _socket!.on('server:nuevanotificacion', (data) {
      // print('las NOTIFICACIONES  ------->   : $data');

      _listaNotificaciones = {};
      _listaNotificaciones = data;
      _crtlHome.setListaTodasLasNotificaciones([data]);

      notifyListeners();
    });
    // Ejemplo de cómo manejar un evento personalizado
    _socket!.on('server:lista-usuarios', (data) {
      // print('LISTA DE LOS USUARIOS DEL GRUPO   ------->> : $data');

      _listaUsuariosChat = [];

      _listaUsuariosChat = data;
      notifyListeners();
    });

    //ESCUCHA LOS MENSAJES CHAT
    _socket!.on('server:send-mensaje', (data) {
      print('MENSAJE CHAT DDDD: $data');

//********VALIDAR ***********/
      if (_isEnChat == true) {
        _socket!.emit('client:read-mensaje', {
          "rucempresa": "ULTRA2022", // login
          "rol": getUser!['rol'], // login
          "chat_id": data['chat_id'], // propiedad chat_id del mensaje
          "person_id": getUser!['id'], // login
          "last_read_message_id":
              data['message_id'] // propiedad message_id del mensaje
        });
      }

      Map<dynamic, dynamic> _info = {};
      print('ESTOO ES ESTA : $_info');

      _info = {
        "rucempresa": "ULTRA2022", // login
        "id_user": getUser!['id'],
      };
      print('ESTOO ES : $_info');

      _socket!.emit('client:totales-actualizados', _info);

      setListaDeMensajesChat(data);

      notifyListeners();
      // setMensajeDesdeServidor(data); // Actualizar el mensaje en el modelo
    });

    _socket!.on('server:totales-actualizados', (data) {
      print('el usuario del MOVIL ------------------> : ${data}');

      // setGruposChat();

       _listaGruposChat = [];
    _listaGruposChat =data['refresh_groups'];



       _msgNoLeidos = 0;
    _msgNoLeidos = data['unread_messages'];
    

      notifyListeners();
    });




















}


//    // Función para cerrar la conexión del socket
 void closeSocket() {
   _socket!.disconnect();
    print('Socket cerrado');
  } 

void emitEvent(String eventName, dynamic data) {
  if (_socket != null && _socket!.connected) {
    _socket!.emit(eventName, data);
    print('SE EMITE ESTO AL SERVIDOR : $data');
  } else {
    print('El socket no está conectado');
    // Si lo deseas, puedes intentar reconectar aquí
    // reconnectSocket();
  }
}




  void deleteListChatSocket() {
    _listaDeMensajeChat.clear();
    notifyListeners();
    // print('ELIMINADO Chat####################>:${deleteListChatSocket}');
  }
//   // Función para reconectar el socket si está desconectado
//   // Función para reconectar el socket
// void reconnectSocket() async {
//     final session = await Auth.instance.getSession();
//     if (_socket == null || !_socket.connected) {
//       print('Intentando reconectar...');
//       connectToSocket(session['token'], session['rucempresa']);
//     }
//   }

//    // Función para cerrar la conexión del socket
//  void closeSocket() {
 
//     _socket.disconnected;
//     print('Socket cerrado');
//   } 



}