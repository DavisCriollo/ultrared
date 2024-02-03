import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketModel with ChangeNotifier {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  final ChatController _crtlChat = ChatController();
  final HomeController _crtlHome = HomeController();

  List _listaGruposChat = [];
  List get getListaGruposChat => _listaGruposChat;
   Map<String,dynamic>  _listaNotificaciones = {};
    Map<String,dynamic>  get getListaNotificaciones => _listaNotificaciones;
  List<Map<String,dynamic>> _listaDeMensajeChat = [];
    List<Map<String,dynamic>>  get getListaDeMensajeChat => _listaDeMensajeChat;
 void setListaDeMensajesChat ( Map<String,dynamic> _msg){
//  _listaDeMensajeChat.reversed;
_listaDeMensajeChat.insert(0,_msg);
// _listaDeMensajeChat.addAll({_msg});
// _listaDeMensajeChat.reversed;

// print('Los MENSAJES DEL SERVIDOR   ------->>>>   : $_listaDeMensajeChat');
// for (var item in _listaDeMensajeChat) {
//   print('Los MENSAJES DEL SERVIDOR   ------->>>>   : ${item['message_id']}');
// }
 _listaDeMensajeChat.sort((a, b) => b["message_id"].compareTo(a["message_id"]));
print('Los MENSAJES DEL SERVIDOR   ------->>>>   : $_listaDeMensajeChat');


notifyListeners();
 }


    // MUESTRA LOS GRUPOS  CHAT 
int _msgNoLeidos =0;
int get getMsgNoLeidos => _msgNoLeidos;
void setMsgNoLeidos(int _msgs){
  _msgNoLeidos =0;
  _msgNoLeidos=_msgs;
   print(' *******************_msgNoLeidos : $_msgNoLeidos');
  notifyListeners();
}

  Map<String, dynamic> _mensajeChat = {};
  Map<String, dynamic> get getMensajeChat => _mensajeChat;

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

    // MUESTRA LOS GRUPOL CHAT
    _socket.on('server:lista-chats-grupos', (data) {
      print('Los grupos del servidor  -------#####   : $data');

      _listaGruposChat = [];
      _listaGruposChat = data;

int totalUnreadMessages = 0;
 totalUnreadMessages = _listaGruposChat.fold(0, (sum, chat) => sum + (chat["unread_messages"] as int));
    setMsgNoLeidos(totalUnreadMessages);

  print("La cantidad total de unread_messages es: $totalUnreadMessages");



      notifyListeners();
    });
    _socket.on('server:nuevanotificacion', (data) {
      // print('las NOTIFICACIONES  ------->   : $data');
      

      _listaNotificaciones = {};
      _listaNotificaciones = data;
      _crtlHome.setListaTodasLasNotificaciones([data]);

      notifyListeners();
    }); 
    // Ejemplo de cómo manejar un evento personalizado
    _socket.on('server:lista-usuarios', (data) {
      // print('LISTA DE LOS USUARIOS DEL GRUPO   ------->> : $data');

      _listaUsuariosChat = [];

      _listaUsuariosChat = data;
      notifyListeners();
    });

    //ESCUCHA LOS MENSAJES CHAT
    _socket.on('server:send-mensaje', (data) {
      print('MENSAJE CHAT: $data');
      // _mensajeChat = {};
      setListaDeMensajesChat(data);




      // _mensajeChat = data;
      // _crtlChat.setChatSocket(data);
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
      print('SE EMITE ESTO AL SERVIDOR : $data');
  }

  // Método para establecer la información recibida
  List _mensajeDesdeServidor = [];
  List get mensajeDesdeServidor => _mensajeDesdeServidor;

  List _listaUsuariosChat = [];
  List get getListaUsuariosChat => _listaUsuariosChat;

  // void setMensajeDesdeSerUvidor(List _data) {
  //   if (_data.contains('chat_type')) {
  //     _listaGruposChat = [];
  //     _listaGruposChat = _data;
  //     notifyListeners();
  //   } else {
  //     _listaUsuariosChat = [];

  //     _listaUsuariosChat = _data;
  //     notifyListeners();
  //   }
  // }

  void deleteListChatSocket(){
 _listaDeMensajeChat.clear();
 notifyListeners();
  print('ELIMINADO Chat####################>:${deleteListChatSocket}');

  }

  void reset() {
    _mensajeDesdeServidor = [];
    notifyListeners();
  }
}
