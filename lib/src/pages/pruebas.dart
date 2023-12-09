import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/service/socket_service.dart';

class MensajeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(onTap: () {
            final serviceSocket = context.read<SocketModel>();
            
            
              //                                                 serviceSocket.setTokenAndCedula('${session!['token']}','${session['rucempresa']}');
            
                                                  serviceSocket.emitEvent( 'client:lista-usuarios', {"chat_id": 4} );
        },child: Text('Mensaje desde el Servidor')),
      ),
      body: Center(
        child: Consumer<SocketModel>(
          builder: (context, socketModel, child) {
            return Text(
              socketModel.mensajeDesdeServidor.toString(),
              style: TextStyle(fontSize: 18),
            );
          },
        ),
      ),
    );
  }
}