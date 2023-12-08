// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ultrared/src/service/socket.dart';



// class ListaUsuariosScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final socketProvider = Provider.of<SocketProvider>(context);

//     // Escuchar el evento 'server:lista-chats-grupos'
//     socketProvider.socket?.on('server:lista-chats-grupos', (data) {
//       // Aquí puedes procesar la información recibida y mostrarla en la pantalla
//       // Por ahora, simplemente imprimimos los datos en la consola
//       print('Lista de usuarios recibida: $data');
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lista de Usuarios Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Emitir el evento 'client:lista-usuarios' al presionar el botón
//             socketProvider.socket!.emit('client:lista-usuarios', {"chat_id": 4 });
//           },
//           child: Text('Obtener Lista de Usuarios'),
//         ),
//       ),
//     );
//   }
// }