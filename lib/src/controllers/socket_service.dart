import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum SocketStatus { conectado, desconectado, conectando }

class SocketService extends ChangeNotifier {
  late io.Socket _socket;
  SocketStatus _status = SocketStatus.desconectado;

  SocketService() {
    _socket = io.io('tu_socket_url', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.onConnect((_) {
      _setStatus(SocketStatus.conectado);
    });

    _socket.onDisconnect((_) {
      _setStatus(SocketStatus.desconectado);
    });

    _socket.connect();
  }

  SocketStatus get status => _status;

  void _setStatus(SocketStatus nuevoEstado) {
    _status = nuevoEstado;
    notifyListeners();
  }

  void conectar() {
    if (_status == SocketStatus.desconectado) {
      _setStatus(SocketStatus.conectando);
      _socket.connect();
    }
  }

  void desconectar() {
    if (_status == SocketStatus.conectado) {
      _socket.disconnect();
    }
  }

  void enviarMensaje(String mensaje) {
    if (_status == SocketStatus.conectado) {
      _socket.emit('enviarMensaje', mensaje);
    }
  }
}
