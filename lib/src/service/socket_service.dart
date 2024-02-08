import 'dart:ffi';

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

void setGruposChat( List _groups){
  _listaGruposChat = [];
   _listaGruposChat = _groups;
  notifyListeners();
}


   Map<String,dynamic>  _listaNotificaciones = {};
    Map<String,dynamic>  get getListaNotificaciones => _listaNotificaciones;
  List<Map<String,dynamic>> _listaDeMensajeChat = [];
    List<Map<String,dynamic>>  get getListaDeMensajeChat => _listaDeMensajeChat;

void resetInfoSocket(){
_user = {};
 _isEnChat=false;
// _listaGruposChat = [];
_listaNotificaciones = {};
_listaDeMensajeChat = [];
_msgNoLeidos =0;
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

bool _isEnChat=false;
bool get getIsEnChat => _isEnChat;
 void setIsEnChat(bool _data) {
  _isEnChat=false;
  _isEnChat=_data;
    
     print('ESTA EN EL CHAT ------------- >>>   $_isEnChat');
    notifyListeners();
  }

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
// print('Los MENSAJES DEL SERVIDOR   ------->>>>   : $_listaDeMensajeChat');


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



// Crear el mapa del query
// Map<String, dynamic> queryParameters = {
//   'rucempresa': ruc,
//   'x-auth-token': token,
// };


  // Método para conectar Socket.io
  void connectToSocket(String token, String ruc) {
    _socket = IO.io('https://contabackend.neitor.com', <String, dynamic>{
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

// int totalUnreadMessages = 0;
//  totalUnreadMessages = _listaGruposChat.fold(0, (sum, chat) => sum + (chat["unread_messages"] as int));
//     setMsgNoLeidos(totalUnreadMessages);

  // print("La cantidad total de unread_messages es: $totalUnreadMessages");



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
      
      print('MENSAJE CHAT DDDD: $data');


//********VALIDAR ***********/
if ( _isEnChat==true) {
  _socket.emit('client:read-mensaje',
                                  {
                                                                  
                                      "rucempresa": "ULTRA2022", // login
                                      "rol": getUser!['rol'], // login
                                      "chat_id":data['chat_id'], // propiedad chat_id del mensaje
                                      "person_id": getUser!['id'], // login
                                      "last_read_message_id":data['message_id']  // propiedad message_id del mensaje

                                  });
}

// si estoy dentro del chat ejecutar 

  // _crtlSocket.emitEvent('client:read-mensaje',
  //                                 {
                                                                  
  //                                     "rucempresa": "ULTRA2022", // login
  //                                     "rol": _ctrlHome.getUser!['rol'], // login
  //                                     "chat_id":  // propiedad chat_id del mensaje
  //                                     "person_id": _ctrlHome.getUser!['id'], // login
  //                                     "last_read_message_id":  // propiedad message_id del mensaje

  //                                 });





      // _mensajeChat = {};
    // print('MENSAJE CHAT crtlHome.getUser: ${_crtlHome.getUser}');
  // print('el usuario qdel dispositivo ------------------> : ${getUserApp['id']}');
  
 Map<dynamic, dynamic> _info ={};
 print('ESTOO ES ESTA : $_info');

     _info ={
"rucempresa": "ULTRA2022", // login
   "id_user":getUser!['id'],
      };
print('ESTOO ES : $_info');

 _socket.emit('client:totales-actualizados',_info);


      setListaDeMensajesChat(data);




      // _mensajeChat = data;
      // _crtlChat.setChatSocket(data);
      notifyListeners();
      // setMensajeDesdeServidor(data); // Actualizar el mensaje en el modelo
    } 
    );


_socket.on('server:totales-actualizados', (data) {
     
                print('el usuario del MOVIL ------------------> : ${data}');
      //      print('el usuario del MOVIL ------------------> : ${getUserApp['id']}');
      // print('SE escucha este mens =========> : ${data['refresh_groups']}');
//  _listaGruposChat = [];
  // _listaGruposChat = data['refresh_groups'];
  setGruposChat(data['refresh_groups']);
 setMsgNoLeidos(data['unread_messages']);


      notifyListeners();
    });

   
  














   
  }

  // Método para desconectar Socket.io
  void disconnectSocket() {
//     _socket.emit('client:totales-actualizados',_info);
// _socket.on('server:totales-actualizados',

// _socket.on('server:send-mensaje',
//   _socket.on('server:nuevanotificacion', (data) {

//     _socket.off('mensaje', escuchaDeMensajes);
// _socket.on('server:lista-chats-grupos', (data) {
//  _socket.clearListeners();
    _socket.close();
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

 

  void deleteListChatSocket(){
 _listaDeMensajeChat.clear();
 notifyListeners();
  // print('ELIMINADO Chat####################>:${deleteListChatSocket}');

  }

  void reset() {
    _mensajeDesdeServidor = [];
    notifyListeners();
  }
}
