


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/service/provider_socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;




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

