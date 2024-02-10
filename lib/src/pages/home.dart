// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ultrared/src/api/authentication_client.dart';
// import 'package:ultrared/src/controllers/chat_controller.dart';
// import 'package:ultrared/src/controllers/home_controller.dart';
// import 'package:ultrared/src/service/notification_push.dart';
// import 'package:ultrared/src/service/notifications_service.dart';
// import 'package:ultrared/src/service/socket.dart';
// import 'package:ultrared/src/service/socket_service.dart';
// import 'package:ultrared/src/utils/dialogs.dart';
// import 'package:ultrared/src/utils/responsive.dart';


// class Home extends StatefulWidget {
//    final Map<String, dynamic>? user;
//   const Home({Key? key, this.user}) : super(key: key);


//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//      final Responsive size = Responsive.of(context);
//     var socketProvider = context.read<SocketService>();
//     final _ctrl = context.read<HomeController>();
//     return Scaffold(
//       body: Container(
//         width: size.wScreen(100),
//         height: size.hScreen(100),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Text('Hola Mundo'),
//      ),
//       TextButton(onPressed: () async{


                 
//                     // var ctrlChat = context.read<ChatController>();  

//                ProgressDialog.show(context);
//               final response = await _ctrl.cierreSesionUsuario(context);
//               ProgressDialog.dissmiss(context);
          
//           if (response != null ) {
               
//             //----------------------------------------------------//
//             //  final _tokenFCM = await Auth.instance.getTokenFireBase();
//             //  ctrlHome.setTokennotificacion(_tokenFCM, 'eliminar');
//             //  await FirebaseService.deleteFirebaseInstance();
//             //  await Auth.instance.deleteTokenFireBase();
//             //  await Auth.instance.deleteCache(context);
//             //  ctrlSocket.disconnectSocket();
             
//             // // ctrlSocket.resetInfoSocket();
//             // // ctrlChat.resetInfoChat();
//             // // ctrlHome.resetInfoHome();
//             //  Navigator.pop(context);
//             //  context.read<HomeController>().cierreSesionUsuario(context);
//               socketProvider.closeSocket();
//              await Auth.instance.deleteSesion(context);
           
               
//                 //----------------------------------------------------//
          
          
          
//               }else  {
          
//                  NotificatiosnService.showSnackBarDanger( response.toString());
                
//               } 
              
//                    //----------------------------------------------------//



//           }, child: Text('Salir'),),



//           TextButton(onPressed: (){

//   //  var ctrlSocket = context.read<SocketService>();  
                 
//                  SocketService().emitEvent( 'client:lista-chats-grupos',{});
           



//           }, child: Text('Conetcar'),)





//           ],
//         ),
//       ),
//    );
//   }
// }