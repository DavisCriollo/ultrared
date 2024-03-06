// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:ultrared/src/controllers/home_controller.dart';
// import 'package:ultrared/src/controllers/login_controller.dart';
// import 'package:ultrared/src/controllers/init_provider.dart';
// import 'package:ultrared/src/pages/acceso_gps_page.dart';
// import 'package:ultrared/src/pages/home.dart';

// import 'package:ultrared/src/pages/home_page.dart';
// import 'package:ultrared/src/pages/login_page.dart';
// import 'package:ultrared/src/pages/ser_cliente_page.dart';
// // import 'package:ultrared/src/service/provider_socket.dart';
// import 'package:ultrared/src/service/socket_service.dart';
// import 'package:ultrared/src/utils/responsive.dart';

// import '../api/authentication_client.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   _SplashPageState createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   final controllerLogin = LoginController();
//   final controllerHome = HomeController();
//   // final _checker = AppVersionChecker();

//   @override
//   void initState() {
//     super.initState();
// // VERIFICO SI EL CONTEXTO  ESTA INICIALIZADO//
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       //  checkVersion();
//       _chechLogin();
//     });
//   }
//     @override
//   void dispose() {


    
//     // WidgetsBinding.instance!.removeObserver(this);
// //  Provider.of<SocketModel>(context, listen: false).disconnectSocket();
//     // if (mounted) {
//       // Asegúrate de limpiar la suscripción cuando el widget es desmontado
//       // FirebaseMessaging.onMessage.drain();
//       // FirebaseMessaging.onMessageOpenedApp.drain();
//     // }
   
//     super.dispose();
//   }
// // ======================= CHECAMOS LA VERSION DE LA APP  ==========================//
// //  void checkVersion() async {
// //     _checker.checkUpdate().then((value)  async{
// //       // print('  necesita actualizacion: ${value.canUpdate}'); //return true if update is available
// //       // print(value.currentVersion); //return current app version
// //       print('version actual  :${value.newVersion}'); //return the new app version
// //       // print(value.appURL); //return the app url
// //       // print(value.errorMessage); //return error message if found else it will return null
// // if (value.canUpdate==true) {

// // Navigator.of(context).pushAndRemoveUntil(
// //           // MaterialPageRoute(builder: (context) =>  UpdateApp(info: value,)),
// //           MaterialPageRoute(builder: (context) =>  UpdateApp(info: value,)),
// //           (Route<dynamic> route) => false);

// // }else{
// //  _chechLogin();

// // }
// //     });

// //   }

// //   _chechLogin() async {
// //     final controllerHome = Provider.of<HomeController>(context, listen: false);
// //     final Session? session = await Auth.instance.getSession();
// //     // controllerHome.setSesionUser(session);
// //     final String? validaTurno = await Auth.instance.getTurnoSession();
// //     final String? tokenFCM = await Auth.instance.getTokenFireBase();

// //     if (session != null) {

// //       controllerHome.setValidaBtnTurno((validaTurno != null) ? true : false);
// //       final status = await Permission.location.request();
// //       if (status == PermissionStatus.granted) {
// //       //   // print('============== SI TIENE PERMISOS');
// //         await controllerHome.getValidaTurnoServer();
// //         await controllerHome.getCurrentPosition();
// //         if (controllerHome.getCoords != '') {
// //           if (controllerHome.getBotonTurno) {
// //             controllerHome.setBotonTurno(true); //P OR DEFAUL ES TRUE
// //           } else {
// //             controllerHome.setBotonTurno(false);
// //           }

// // print('SI TENEMOS EL TOKEN FCM : $tokenFCM');
// //           Navigator.of(context).pushAndRemoveUntil(
// //               MaterialPageRoute(
// //                   builder: (context) => HomeMenu(
// //                       validaTurno: validaTurno,
// //                       tipo: session.rol,
// //                       user: session,
// //                       ubicacionGPS: controllerHome.getCoords)),
// //               (Route<dynamic> route) => false);
// //           ModalRoute.withName('/');
// //         }
// //       }
// //        else {
// //         Navigator.pushNamed(context, 'gps');
// //       }

// //     } else {
// //       Navigator.of(context).pushAndRemoveUntil(
// //           MaterialPageRoute(builder: (context) => const LoginPage()),
// //           (Route<dynamic> route) => false);
// //     }
// //   }
//   _chechLogin() async {

//     final controllerHome = context.read<HomeController>();
//     final Map<String, dynamic>? session = await Auth.instance.getSession();
   
//     if (session != null) {

// controllerHome.setUserApp(session);

//   var _ctrlSocket = Provider.of<SocketModel>(context, listen: false);
//   _ctrlSocket.connectToSocket("${session['token']}", "${session['rucempresa']}");
//      await controllerHome.validaInicioDeSesion();
   
//     if (controllerHome.getValidaSession==true) {
//       controllerHome.buscarNoticias(context);
//       controllerHome.buscarNotificaciones(context);
   

//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                   builder: (context) => Home(
                     
//                         user: session,
                       
//                       )),
//               (Route<dynamic> route) => false);
         
//         }
//          else {
//           // await Auth.instance.deleteSesion(context);
//           // Navigator.of(context).pushAndRemoveUntil(
//           //     MaterialPageRoute(
//           //         builder: (context) => SerClientePage(
                      
//           //             )),
//           //     (Route<dynamic> route) => false);
        
//         }
//       // final status = await Permission.location.request();
//       // if (status == PermissionStatus.granted) {
//       //     print('============== SI TIENE PERMISOS');
//       //      await controllerHome.validaInicioDeSesion();
//       //   //  controllerHome.checkGPSStatus();
        
//       //     // print('============== gps activado.  ${controllerHome.getGPSState()}');
//       //   // await controllerHome.getLocation();
//       //   // if (controllerHome.getGPSPositione) {
//       //   //   // Navigator.of(context).pushAndRemoveUntil(
//       //   //   //     MaterialPageRoute(
//       //   //   //         builder: (context) => HomePage(
//       //   //   //               // validaTurno: validaTurno,
//       //   //   //               // tipo: session.rol,
//       //   //   //               user: session,
//       //   //   //               // ubicacionGPS: controllerHome.getCoords,
//       //   //   //             )),
//       //   //   //     (Route<dynamic> route) => false);
//       //   //   // ModalRoute.withName('/');
//       //   // }

//       //   if (controllerHome.getValidaSession==true) {

//       //     Navigator.of(context).pushAndRemoveUntil(
//       //         MaterialPageRoute(
//       //             builder: (context) => HomePage(
//       //                   // validaTurno: validaTurno,
//       //                   // tipo: session.rol,
//       //                   user: session,
//       //                   // ubicacionGPS: controllerHome.getCoords,
//       //                 )),
//       //         (Route<dynamic> route) => false);
//       //     ModalRoute.withName('/');
//       //   }
//       //   else {
//       //     Navigator.of(context).pushAndRemoveUntil(
//       //         MaterialPageRoute(
//       //             builder: (context) => SerClientePage(
//       //                   // validaTurno: validaTurno,
//       //                   // tipo: session.rol,
//       //                   // user: session,
//       //                   // ubicacionGPS: controllerHome.getCoords,
//       //                 )),
//       //         (Route<dynamic> route) => false);
//       //     ModalRoute.withName('/');
//       //   }
//       // } 
//       // else {
//       //   // Navigator.pushNamed(context, 'gps');
//       //   Navigator.of(context).pushAndRemoveUntil(
//       //         MaterialPageRoute(
//       //             builder: (context) => AccesoGPSPage(
//       //                   // validaTurno: validaTurno,
//       //                   // tipo: session.rol,
//       //                   // user: session,
//       //                   // ubicacionGPS: controllerHome.getCoords,
//       //                 )),
//       //         (Route<dynamic> route) => false);
//       //     ModalRoute.withName('/');
//       // }

//   // final infoUser  = await Auth.instance.getSession();
              
//   //               _ctrlInitProvider.login("${session['token']}", "${session['rucempresa']}");
//   //             SocketService(_ctrlInitProvider);
               
//   //    final _ctrlSocket =context.read<SocketService>();
//   //                 _ctrlSocket.sendMessage('client:lista-usuarios', {
//   //      "chat_id" : 4
//   //   });



// //final status = await Permission .location.request(); if (status == PermissionStatus .granted) {


//                                                    //   }
                                                      
//  //Geolocator.openAppSettings();
// //*****************************************/
//     //      var _ctrlSocket = Provider.of<SocketModel>(context, listen: false);
//     //       _ctrlSocket.connectToSocket("${session['token']}", "${session['rucempresa']}");
//     // context.read<HomeController>().buscarNoticias(context);
//     // context.read<HomeController>().buscarNotificaciones(context);
//     //    Navigator.of(context).pushAndRemoveUntil(
//     //           MaterialPageRoute(
//     //               builder: (context) => HomePage(
//     //                     // validaTurno: validaTurno,
//     //                     // tipo: session.rol,
//     //                     user: session,
//     //                     // ubicacionGPS: controllerHome.getCoords,
//     //                   )),
//     //           (Route<dynamic> route) => false);
//     //       ModalRoute.withName('/');
//      //*****************************************//
//     } 
//     else {     // Navigator.of(context).pushAndRemoveUntil(
//       //     MaterialPageRoute(builder: (context) => const SplashPage()),
//       //     (Route<dynamic> route) => false);

//  await Auth.instance.deleteSesion(context);

// //  Navigator.of(context).pushAndRemoveUntil(
// //           MaterialPageRoute(builder: (context) => const SerClientePage()),
// //           (Route<dynamic> route) => false);

//     }
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     return Scaffold(
//       body: SizedBox(
//         width: size.wScreen(100.0),
//         height: size.hScreen(100.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const CircularProgressIndicator(),
//               SizedBox(
//                 height: size.iScreen(2.0),
//               ),
//               const Text('Procesando.... '),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/api/api_provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/controllers/login_controller.dart';

import 'package:ultrared/src/pages/home_page.dart';
import 'package:ultrared/src/pages/inicial.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';
import 'package:ultrared/src/service/socket.dart';
import 'package:ultrared/src/utils/responsive.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controllerLogin = LoginController();
  final controllerHome = HomeController();

 

    final _api = ApiProvider();
   

  @override
  void initState() {
    super.initState();
// VERIFICO SI EL CONTEXTO  ESTA INICIALIZADO//
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _chechLogin();
      
    });
  }

  _chechLogin() async {
    Map<String,dynamic>? session = await Auth.instance.getSession();
 
    if (session != null  ) {
  
    final   response = await _api.validaTokenUsuarios(token:session['token']);
      // print('revisa token============> :$response');
       
     if(response!=null) {
        controllerHome.buscarNotificaciones(context);
          final _ctrlSocket= context.read<SocketService>();
    
          _ctrlSocket.connectSocket(context,"${response['token']}", "${response['rucempresa']}");
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage(user: session)),
          (Route<dynamic> route) => false);
       }else{
         Navigator.of(context).pushAndRemoveUntil(
          // MaterialPageRoute(builder: (context) => const SerClientePage()),
          MaterialPageRoute(builder: (context) =>  const Inicial()),
          (Route<dynamic> route) => false);
       }
      
    } else {
    
      Navigator.of(context).pushAndRemoveUntil(
        // MaterialPageRoute(builder: (context) => const SerClientePage()),
          MaterialPageRoute(builder: (context) =>  const Inicial()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
  //  Provider.of<AppTheme>(context,listen: false).setResponsive(size);


// Future.delayed(Duration(seconds: 1),(){
//   // final BuildContext _size;
//      int? _primColor=int.parse(session!.colorPrimario!.replaceAll("#",'0xff'));
//   int? _secColor=int.parse(session!.colorSecundario!.replaceAll("#",'0xff'));
// Color? _colorPrimario=Color(_primColor);
// Color? _colorSecundario=Color(_secColor);
// // final _size=Responsive.of(context);
// Provider.of<AppTheme>(context,listen: false).setAppTheme(true,'',_colorPrimario,Colors.white,size,_colorSecundario);
// print('veces q repite:');
//   });









    
    
    return Scaffold(
      body: SizedBox(
        width: size.wScreen(100.0),
        height: size.hScreen(100.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                height: size.iScreen(2.0),
              ),
              const Text('Preparando Contenido.... '),
            ],
          ),
        ),
      ),
    );
  }
}