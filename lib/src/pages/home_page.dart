import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/controllers/init_provider.dart';
import 'package:ultrared/src/pages/acceso_gps_page.dart';
import 'package:ultrared/src/pages/auxilio_page.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/pages/image_noticias.dart';
import 'package:ultrared/src/pages/lista_estado_cuenta.dart';
import 'package:ultrared/src/pages/lista_grupos_chat.dart';
import 'package:ultrared/src/pages/lista_notificaciones.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';
import 'package:ultrared/src/pages/splash_screen.dart';
import 'package:ultrared/src/pages/vista_imagen.dart';
import 'package:ultrared/src/service/local_notifications.dart';
import 'package:ultrared/src/service/notification_push.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/drawer_menu.dart';

import 'package:ultrared/src/widgets/elementoSOS.dart';
import 'package:ultrared/src/widgets/elementosHome.dart';
import 'package:ultrared/src/widgets/modal_permisos.dart';
import 'package:ultrared/src/widgets/no_data.dart';
// import 'socket_provider.dart'; // Asegúrate de importar tu SocketProvider

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? user;
  const HomePage({Key? key, this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  // Map<String, dynamic>? user = {};

  final ctrlHome = HomeController();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //  setUpNotificationPlugins();
      // initializeNotifications();

      initData();
    });
    super.initState();
    FirebaseService.getFirebaseToken().then((token) {
      // final ctrlHome =context.read <HomeController>();
      ctrlHome.setTokennotificacion(token, 'guardar');

      // print("Firebase Token: $token");
    });

    // FirebaseService.configureFirebaseMessaging();
  }

//  void initializeNotifications() {
//     AwesomeNotifications().initialize(
//       'resource://drawable/app_icon',
//       [
//         NotificationChannel(
//           channelKey: 'basic_channel',
//           channelName: 'Basic notifications',
//           channelDescription: 'Notification channel for basic notifications',
//           defaultColor: Colors.teal,
//           ledColor: Colors.teal,
//         ),
//       ],
//     );
//   }

//   void showLocalNotification() {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 0,
//         channelKey: 'basic_channel',
//         title: 'Notificación local',
//         body: '¡Esta es una notificación local!',
//       ),
//     );
//   }

// ======================= OBSERVABLE  ==========================//

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // await ctrlHome.validaInicioDeSesion();
      // print('EL ESTADO ES ------: $state');
      // ctrlHome.getLocation();
      //  final Map<String, dynamic>? session = await Auth.instance.getSession();
      //      var _ctrlSocket = context.read<SocketModel>();
      //             _ctrlSocket.connectToSocket("${session!['token']}", "${session['rucempresa']}");

      // if (mounted) {
        print('EL ESTADO ES ------: $state');
      //   // Realiza operaciones con el contexto solo si el widget está montado
      //   // ...

        
      //   // if (ctrlHome.getIsCamara==false) {
      //   //   Navigator.pushNamed(context, 'splash');
      //   // } 

       
     _chechLogin();




      // }

      //VERIFICA  //

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute<void>(
      //         builder: (BuildContext context) => const SplashPage()));

//  final _isTurned=
// homeController.buscaNotificacionesPush('');
//       homeController.buscaNotificacionesPush2('');
      // homeController.setGetTestTurno(null);
      // homeController.getValidaTurnoServer();

    }
    if (state == AppLifecycleState.inactive) {
      print('EL ESTADO ES: $state');
      //  Provider.of<SocketModel>(context, listen: false).disconnectSocket();
    }
    if (state == AppLifecycleState.paused) {
      print('EL ESTADO ES: $state');
      //  Provider.of<SocketModel>(context, listen: false).disconnectSocket();
    }
  }
 _chechLogin() async {

    final controllerHome = context.read<HomeController>();
    final Map<String, dynamic>? session = await Auth.instance.getSession();
   
    if (session != null) {

controllerHome.setUserApp(session);

  // var _ctrlSocket = Provider.of<SocketModel>(context, listen: false);
  // _ctrlSocket.connectToSocket("${session['token']}", "${session['rucempresa']}");
     await controllerHome.validaInicioDeSesion();
   
    if (controllerHome.getValidaSession==true) {
      controllerHome.buscarNoticias(context);
      controllerHome.buscarNotificaciones(context);
   

          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //         builder: (context) => HomePage(
                     
          //               user: session,
                       
          //             )),
          //     (Route<dynamic> route) => false);
         
        }
         else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => SerClientePage(
                      
                      )),
              (Route<dynamic> route) => false);
        
        }
      // final status = await Permission.location.request();
      // if (status == PermissionStatus.granted) {
      //     print('============== SI TIENE PERMISOS');
      //      await controllerHome.validaInicioDeSesion();
      //   //  controllerHome.checkGPSStatus();
        
      //     // print('============== gps activado.  ${controllerHome.getGPSState()}');
      //   // await controllerHome.getLocation();
      //   // if (controllerHome.getGPSPositione) {
      //   //   // Navigator.of(context).pushAndRemoveUntil(
      //   //   //     MaterialPageRoute(
      //   //   //         builder: (context) => HomePage(
      //   //   //               // validaTurno: validaTurno,
      //   //   //               // tipo: session.rol,
      //   //   //               user: session,
      //   //   //               // ubicacionGPS: controllerHome.getCoords,
      //   //   //             )),
      //   //   //     (Route<dynamic> route) => false);
      //   //   // ModalRoute.withName('/');
      //   // }

      //   if (controllerHome.getValidaSession==true) {

      //     Navigator.of(context).pushAndRemoveUntil(
      //         MaterialPageRoute(
      //             builder: (context) => HomePage(
      //                   // validaTurno: validaTurno,
      //                   // tipo: session.rol,
      //                   user: session,
      //                   // ubicacionGPS: controllerHome.getCoords,
      //                 )),
      //         (Route<dynamic> route) => false);
      //     ModalRoute.withName('/');
      //   }
      //   else {
      //     Navigator.of(context).pushAndRemoveUntil(
      //         MaterialPageRoute(
      //             builder: (context) => SerClientePage(
      //                   // validaTurno: validaTurno,
      //                   // tipo: session.rol,
      //                   // user: session,
      //                   // ubicacionGPS: controllerHome.getCoords,
      //                 )),
      //         (Route<dynamic> route) => false);
      //     ModalRoute.withName('/');
      //   }
      // } 
      // else {
      //   // Navigator.pushNamed(context, 'gps');
      //   Navigator.of(context).pushAndRemoveUntil(
      //         MaterialPageRoute(
      //             builder: (context) => AccesoGPSPage(
      //                   // validaTurno: validaTurno,
      //                   // tipo: session.rol,
      //                   // user: session,
      //                   // ubicacionGPS: controllerHome.getCoords,
      //                 )),
      //         (Route<dynamic> route) => false);
      //     ModalRoute.withName('/');
      // }

  // final infoUser  = await Auth.instance.getSession();
              
  //               _ctrlInitProvider.login("${session['token']}", "${session['rucempresa']}");
  //             SocketService(_ctrlInitProvider);
               
  //    final _ctrlSocket =context.read<SocketService>();
  //                 _ctrlSocket.sendMessage('client:lista-usuarios', {
  //      "chat_id" : 4
  //   });



//final status = await Permission .location.request(); if (status == PermissionStatus .granted) {


                                                   //   }
                                                      
 //Geolocator.openAppSettings();
//*****************************************/
    //      var _ctrlSocket = Provider.of<SocketModel>(context, listen: false);
    //       _ctrlSocket.connectToSocket("${session['token']}", "${session['rucempresa']}");
    // context.read<HomeController>().buscarNoticias(context);
    // context.read<HomeController>().buscarNotificaciones(context);
    //    Navigator.of(context).pushAndRemoveUntil(
    //           MaterialPageRoute(
    //               builder: (context) => HomePage(
    //                     // validaTurno: validaTurno,
    //                     // tipo: session.rol,
    //                     user: session,
    //                     // ubicacionGPS: controllerHome.getCoords,
    //                   )),
    //           (Route<dynamic> route) => false);
    //       ModalRoute.withName('/');
     //*****************************************//
    } 
    else {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const SplashPage()),
      //     (Route<dynamic> route) => false);


//  Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const SplashPage()),
//           (Route<dynamic> route) => false);

    }
    
  }
  initData() async {
    WidgetsBinding.instance!.addObserver(this);
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);

    var ctrlHome = context.read<HomeController>();

    // Obtén el token de registro de Firebase
    String? firebaseToken = await FirebaseMessaging.instance.getToken();
    // print("Firebase ok Token: $firebaseToken");

    await Auth.internal().saveTokenFireBase(firebaseToken.toString());
    ctrlHome.setTokennotificacion(firebaseToken, 'guardar');

    //------------------------------------//

    @override
    void dispose() {
      WidgetsBinding.instance!.removeObserver(this);
//  Provider.of<SocketModel>(context, listen: false).disconnectSocket();
      // if (mounted) {
      // Asegúrate de limpiar la suscripción cuando el widget es desmontado
      // FirebaseMessaging.onMessage.drain();
      // FirebaseMessaging.onMessageOpenedApp.drain();
      // }

      super.dispose();
    }

    // Manejar la notificación cuando la aplicación está en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "Notificación recibida primer plano ************* >: ${message.data}");
      //------------------------------------//

//  final _data= {
//   "tabla": "notificacion-leido", // default
//   "rucempresa": "ULTRA2022", // login
//   "notId":message.data['notId'],
//   "notTipo":message.data['notTipo'],
//   "notIdPersona":message.data['notIdPersona'],
//   "notVisto":message.data['notVisto'],
//   "notTitulo":message.data['notTitulo'],
//   "notContenido":message.data['notContenido'],
//   "notUser":message.data['notUser'],
//   "notEmpresa":message.data['notEmpresa'],
//   "id_registro":message.data['id_registro'],
//   "url_web":message.data['url_web'],
//   "notFecReg": message.data['notFecReg'],
//   "notFecUpd": message.data['notFecUpd'],
//   "perDocNumero":message.data['perDocNumero'],
//   "perNombre":message.data['perNombre'],
//   "perFoto": message.data['perFoto'],
//   "perPerfil":message.data['perPerfil'],
//   "notInformacionAdicional": {
//     "idPer":message.data['notIdPersona'],
//     "perNombre":message.data['perNombre'],
//     "perDocNumero":message.data['perDocNumero'],
//     "perFoto": message.data['perFoto'],
//     "perFotoCasa":message.data['perFotoCasa'],
//     "perFotoVehiculo": message.data['perFotoVehiculo'],
//     "tipoServicio":message.data ['notInformacionAdicional'] ['tipoServicio'],
//     "coordenadas":message.data['notInformacionAdicional']['coordenadas'],
//   }
// };

//                       final ctrlSocket =context.read<SocketModel>();

// // print('LA DATA PARA SOCKET : $_data');

//                 ctrlSocket.emitEvent('client:actualizarData', _data);

//                       final ctrlHome =context.read<HomeController>();

//                                    ctrlHome .buscarNotificaciones(context);

      //------------------------------------//

      // Aquí puedes dirigir al usuario a la pantalla deseada

      //   final _infoNotificacion={
      // 	"notId": 5,
      // 	"notTipo": "ALERTA AYUDA",
      // 	"notIdPersona": 14049,
      // 	"notIdPerPertenece": 2,
      // 	"notVisto": "NO",
      // 	"notTitulo": "Alerta Ayuda",
      // 	"notContenido": "Solicitó Ayuda",
      // 	"notUser": "2122232425",
      // 	"notEmpresa": "ULTRA2022",
      // 	"id_registro": 0,
      // 	"url_web": "",
      // 	"notFecReg": "2023-12-11T15:16:09.000Z",
      // 	"notFecUpd": "2023-12-11T15:16:16.000Z",
      // 	"perDocNumero": "0102030405",
      // 	"perNombre": "Gomez Pedro",
      // 	"perFoto": "https://documentos.neitor.com/contable/fotoperfil/ULTRA2022/96eee234-93e9-4a4c-9fb7-7d12ba3b3c5a.png",
      // 	"perFotoCasa": "https://documentos.neitor.com/contable/fotocasa/ULTRA2022/b2ed4c5b-e7db-4e34-8ba3-c32a9480f6c0.png",
      // 	"perFotoVehiculo": "",
      // 	"perPerfil": [
      // 		"CLIENTE"
      // 	],
      // 	"notInformacionAdicional": {
      // 		"tipoServicio": "HOGAR",
      // 		"coordenadas": {
      // 			"latitud": -0.239079,
      // 			"longitud": -79.171853
      // 		}
      // 	}
      // };
      final _infoNotificacion = {
        "notId": 5,
        "notTipo": "ALERTA AYUDA",
        "notIdPersona": 14049,
        "notIdPerPertenece": 2,
        "notVisto": "NO",
        "notTitulo": "Alerta Ayuda",
        "notContenido": "Solicitó Ayuda",
        "notUser": "2122232425",
        "notEmpresa": "ULTRA2022",
        "id_registro": 0,
        "url_web": "",
        "notFecReg": "2023-12-11T15:16:09.000Z",
        "notFecUpd": "2023-12-11T15:16:16.000Z",
        "perDocNumero": "0102030405",
        "perNombre": "Gomez Pedro",
        "perFoto":
            "https://documentos.neitor.com/contable/fotoperfil/ULTRA2022/96eee234-93e9-4a4c-9fb7-7d12ba3b3c5a.png",
        "perFotoCasa":
            "https://documentos.neitor.com/contable/fotocasa/ULTRA2022/b2ed4c5b-e7db-4e34-8ba3-c32a9480f6c0.png",
        "perFotoVehiculo": "",
        "perPerfil": ["CLIENTE"],
        "notInformacionAdicional": {
          "tipoServicio": "HOGAR",
          "coordenadas": {"latitud": -0.239079, "longitud": -79.171853}
        }
      };

      ctrlHome.buscaNotificacionPorId(context, message.data['notId']);
      //  ctrlHome.setInfoNotificacion(_infoNotificacion);

      Navigator.of(context).pushNamed('auxilo');

      //  Navigator.of(context).push(MaterialPageRoute(
      //                                             builder: (context) =>
      //                                                 const AuxilioPage()));

      //  final ctrlHome =context.read<HomeController>();

      ctrlHome.buscarNotificaciones(context);
    });

    // Manejar la notificación cuando la aplicación se abre desde la barra de notificaciones
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "Notificación abierta desde la aplicación se abre desde la barra de notificaciones ********* >: ${message.data}");
      // Aquí puedes dirigir al usuario a la pantalla deseada

      //         final _infoNotificacion={
      // 	"notId": 5,
      // 	"notTipo": "ALERTA AYUDA",
      // 	"notIdPersona": 14049,
      // 	"notIdPerPertenece": 2,
      // 	"notVisto": "NO",
      // 	"notTitulo": "Alerta Ayuda",
      // 	"notContenido": "Solicitó Ayuda",
      // 	"notUser": "2122232425",
      // 	"notEmpresa": "ULTRA2022",
      // 	"id_registro": 0,
      // 	"url_web": "",
      // 	"notFecReg": "2023-12-11T15:16:09.000Z",
      // 	"notFecUpd": "2023-12-11T15:16:16.000Z",
      // 	"perDocNumero": "0102030405",
      // 	"perNombre": "Gomez Pedro",
      // 	"perFoto": "https://documentos.neitor.com/contable/fotoperfil/ULTRA2022/96eee234-93e9-4a4c-9fb7-7d12ba3b3c5a.png",
      // 	"perFotoCasa": "https://documentos.neitor.com/contable/fotocasa/ULTRA2022/b2ed4c5b-e7db-4e34-8ba3-c32a9480f6c0.png",
      // 	"perFotoVehiculo": "",
      // 	"perPerfil": [
      // 		"CLIENTE"
      // 	],
      // 	"notInformacionAdicional": {
      // 		"tipoServicio": "HOGAR",
      // 		"coordenadas": {
      // 			"latitud": -0.239079,
      // 			"longitud": -79.171853
      // 		}
      // 	}
      // };
      ctrlHome.buscaNotificacionPorId(context, message.data['notId']);

      Navigator.of(context).pushNamed('notificaciones');

      // Navigator.of(context).push(MaterialPageRoute(
      //                                               builder: (context) =>
      //                                                   const ListaNotificaciones()));
    });

    //------------------------------------//

    // FirebaseService.getFirebaseToken().then((token) async {
    //   // final ctrlHome =context.read <HomeController>();
    //   await Auth.internal().saveTokenFireBase(token.toString());
    //   ctrlHome.setTokennotificacion(token, 'guardar');

    //   print("Firebase Token: $token");
    // });

    // FirebaseService.configureFirebaseMessaging();

    // widget.user = await Auth.internal().getSession();
    ctrlHome.setUserApp(widget.user);
    // print('${user!['nombre']}');

    // final  socketManager = context.read<SocketService>();
    // if (socketManager.status == SocketStatus.desconectado) {
    //   socketManager.conectar();
    // }
  }

  @override
  Widget build(BuildContext context) {
    //  print('***hhhhh hhhhh hhhh hhhh hhh h***> ${widget.user}');
    @override
    final Responsive size = Responsive.of(context);
    // var socketProvider = context.read<SocketService>();
    final _ctrl = context.read<HomeController>();
    // final _chatCtrl = context.read<ChatController>();
    _ctrl.checkConnectivity();
    // var socketProvider =Provider.of<SocketProvider>(context,listen:  true);
    //  _ctrl.getconectionInternet== false?
    return Consumer<HomeController>(
      builder: (_, values, __) {
        return    

            // values.getValidaSession == true ?

            SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade200, // appBar: AppBar(
            //   title: Text('Estado del Socket'),
            // ),
            appBar: AppBar(
              toolbarHeight: size.hScreen(10.0),
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0.0,
              backgroundColor: cuaternaryColor, //
              title: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.iScreen(1.0), vertical: size.iScreen(0.5)),
                alignment: Alignment.centerLeft,
                // color:Colors.blue,
                width: size.wScreen(80.0),
                height: size.wScreen(17.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/imgs/letras_UR.png',
                      scale: 1.0,
                      // fit: BoxFit.,
                      // width: size.1Screen(5.0), // URL de la imagen
                    ),
                    Text(
                      ' Seguridad Móvil',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: size.iScreen(2.2),
                          fontWeight: FontWeight.w500,
                          color: secondaryColor),
                    ),
                  ],
                ),
              ),
              actions: [
                values.connectionStatus != ConnectionStatus.none
                    ? Consumer<HomeController>(
                        builder: (_, value, __) {
                          return Badge(
                            position:
                                const BadgePosition(top: 10.0, start: 25.0),
                            badgeContent: Text(
                              //  value.getListaNotificaciones.isNotEmpty?  '${value.getListaNotificaciones.length}':'',
                              '${value.getListaTodasLasNotificaciones.length}',
                              style: GoogleFonts.poppins(
                                fontSize: size.iScreen(1.4),
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            badgeColor: tercearyColor,
                            child: Container(
                              margin: EdgeInsets.only(right: size.iScreen(2.0)),
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<HomeController>()
                                        .buscarNotificaciones(context);

//

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ListaNotificaciones()));
                                  },
                                  icon: Icon(
                                    Icons.notifications,
                                    size: size.iScreen(3.5),
                                    color: Colors.black,
                                  )),
                            ),
                          );
                        },
                      )
                    : Container()
              ],
            ),
            drawer: values.connectionStatus != ConnectionStatus.none
                ?
                // DrawerMenu(user: user)
                DrawerMenu()
                : null,
            body: Container(
              // height: size.hScreen(100),
              width: size.wScreen(100),
              // color:Colors.green,
              child: values.connectionStatus != ConnectionStatus.none
                  ? Column(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: size.iScreen(1.0), vertical: size.iScreen(1.0)),
                        //   // color:  Colors.red,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       GestureDetector(
                        //         onTap: () {
                            
                        //         }
                        //         ,
                            
                        //         child: Container(
                        //           // color:Colors.green,
                        //           width: size.wScreen(10.0),
                        //           height: size.wScreen(10.0),
                        //           child: Icon(
                        //             Icons.menu,
                        //             color: Colors.black,
                        //             size: size.wScreen(7.0),
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         alignment: Alignment.centerLeft,
                        //         // color:Colors.blue,
                        //         width: size.wScreen(80.0),
                        //         height: size.wScreen(15.0),
                        //         child: Image.asset(
                        //           'assets/imgs/LetrasNegro.png',
                        //           scale: 1.3,
                        //           // fit: BoxFit.,
                        //           // width: size.1Screen(5.0), // URL de la imagen
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                            
                        Expanded(child: Consumer<HomeController>(
                          builder: (_, valueHome, __) {
                            return Container(
                              // height: size.hScreen(80.0),
                              // color: Colors.blue,
                              child: Column(
                                children: [
                                  Container(
                                    width: size.wScreen(100.0),
                                    height: size.wScreen(60.0),
                            
                                    // color: Colors.red,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceAround,
                                        children: [
                                          widget.user!['isClient'] == 'SI'
                                              ? ElementosHome(
                                                  enabled: true,
                                                  size: size,
                                                  image:
                                                      'assets/imgs/document.png',
                                                  title: 'Estado de Cuenta',
                                                  label:
                                                      'Verifica tu estado de cuenta',
                                                  onTap: () {
                                                    //                               NotificationHelper().showNotification(
                                                    //   title: 'Título de la notificación',
                                                    //   body: 'Cuerpo de la notificación',
                                                    // );
                            
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                DataTableEstadoCuenta())));
                                                  }
                                                  // () => Navigator.pushNamed(
                                                  //     context, 'SubmenuMascotas'),
                                                  // onTap: () {
                                                  //   Navigator.of(context).push(MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           const SubmenuMascotas()));
                                                  // },
                                                  )
                                              : Container(),
                                          ElementosSOS(
                                              enabled: true,
                                              size: size,
                                              image: 'assets/imgs/document.png',
                                              title: 'Botón de Ayuda',
                                              label: 'Presiona por 3 segundos',
                                              onTap: () async {
                                                //**************//
                            //  HomeController permissionProvider = Provider.of<HomeController>(context, listen: false);
                            //             await permissionProvider.checkAndRequestLocationPermission();
                            //             print(permissionProvider.hasLocationPermission);
                            
                            //             await permissionProvider.checkAndRequestLocationPermission();
                            //             print('**** Permiso ****>  ${permissionProvider.hasLocationPermission}');
                            //   permissionProvider.checkGpsStatus();
                            //                    if (permissionProvider.hasLocationPermission==true) {
                            //                       // permissionProvider.checkGpsStatus();
                            
                            //                                               if (permissionProvider.gpsStatus==true ) {
                            //                                                  NotificatiosnService.showSnackBarSuccsses('El  GPS esta activado');
                            
                            //                    } else {
                            //                      NotificatiosnService.showSnackBarDanger('Por favor active su GPS');
                            //                    }
                            //                    }
                            //                    else{
                            //                      Navigator.of(context).pushAndRemoveUntil(
                            //               MaterialPageRoute(
                            //                   builder: (context) => AccesoGPSPage(
                            //                         // validaTurno: validaTurno,
                            //                         // tipo: session.rol,
                            //                         // user: session,
                            //                         // ubicacionGPS: controllerHome.getCoords,
                            //                       )),
                            //               (Route<dynamic> route) => false);
                            
                                                final _ctrlSocket =
                                                    Provider.of<SocketModel>(
                                                        context,
                                                        listen: false);
                                                // final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                                                HomeController
                                                    permissionProvider =
                                                    Provider.of<HomeController>(
                                                        context,
                                                        listen: false);
                                                await permissionProvider
                                                    .checkAndRequestPermissions();
                                                bool isGpsEnabled =
                                                    await permissionProvider
                                                        .checkGpsStatus();
                                                // print('LA INFO ES  ${permissionProvider.hasLocationPermission} ${isGpsEnabled}');
                            
                                                if (permissionProvider
                                                    .hasLocationPermission) {
                                                  // NotificatiosnService.showSnackBarSuccsses('SIII TIENE PERMISO');
                                                  if (isGpsEnabled) {
                                                    //  NotificatiosnService.showSnackBarDanger(' GPS ACTIVADO ');
                            
                                                    await valueHome
                                                        .getLocation();
                                                    if (valueHome.getLocationGPS
                                                        .isNotEmpty) {
                                                      final _dataPanico = {
                                                        "coordenadas": {
                                                          "latitud": valueHome
                                                                  .getLocationGPS[
                                                              'latitud'],
                                                          "longitud": valueHome
                                                                  .getLocationGPS[
                                                              'longitud']
                                                        },
                                                        "rucempresa":
                                                            "ULTRA2022",
                                                        "perId": valueHome
                                                            .getUser!['id']
                                                      };
                            
                                                      valueHome.activateAlarm();
                            
                                                      print(
                                                          'esta la info para el bon de panico ------> $_dataPanico');
                                                      _ctrlSocket.emitEvent(
                                                          'client:boton-panico',
                                                          _dataPanico);
                                                    }
                                                  } else {
                                                    NotificatiosnService
                                                        .showSnackBarDanger(
                                                            ' Por favor active el GPS');
                                                  }
                                                } else {
                                                  //  NotificatiosnService.showSnackBarDanger('NOOOOO TIENE PERMISO');
                            
                                                  //        Navigator.of(context).pushAndRemoveUntil(
                                                  // MaterialPageRoute(
                                                  //     builder: (context) => const AccesoGPSPage()),
                                                  // (Route<dynamic> route) => false);
                            
                                                  showPermissionModal(
                                                      context,
                                                      size,
                                                      'Para usar el botón de pánico en nuestra aplicación, es esencial conceder permisos de ubicación.');
                                                }
                                                //**************/
                            
                                                // // final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                                                // final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                                                //  final status = await Permission .location.request();
                                                //       if (status == PermissionStatus .granted) {
                                                //         //   // print('============== SI TIENE PERMISOS');
                                                //         await valueHome
                                                //             .getLocation();
                                                //         if (valueHome.getLocationGPS.isNotEmpty) {
                            
                                                //     final _dataPanico = {
                                                //   "coordenadas": {
                                                //     "latitud":valueHome.getLocationGPS['latitud'],
                                                //     "longitud":valueHome.getLocationGPS['longitud']
                                                //   },
                                                //   "rucempresa": "ULTRA2022",
                                                //   "perId": valueHome.getUser!['id']
                                                // };
                            
                                                // valueHome.activateAlarm();
                            
                                                // print('esta la info para el bon de panico ------> $_dataPanico');
                                                // _ctrlSocket.emitEvent('client:boton-panico', _dataPanico);
                            
                                                //         }
                                                //       } else {
                                                //         Navigator.pushNamed(
                                                //             context, 'gps');
                                                //       }
                            
                                                //*******************//
                                                //   valueHome.checkGpsStatus();
                            
                                                //   if (valueHome.gpsStatus==true ) {
                                                //   //   final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                                                //   //            await valueHome
                                                //   //             .getLocation();
                                                //   //         if (valueHome.getLocationGPS.isNotEmpty) {
                            
                                                //   //     final _dataPanico = {
                                                //   //   "coordenadas": {
                                                //   //     "latitud":valueHome.getLocationGPS['latitud'],
                                                //   //     "longitud":valueHome.getLocationGPS['longitud']
                                                //   //   },
                                                //   //   "rucempresa": "ULTRA2022",
                                                //   //   "perId": valueHome.getUser!['id']
                                                //   // };
                            
                                                //   // valueHome.activateAlarm();
                            
                                                //   // print('esta la info para el bon de panico ------> ${valueHome.gpsStatus}');
                                                //   // _ctrlSocket.emitEvent('client:boton-panico', _dataPanico);
                            
                                                //   //         }
                            
                                                //  valueHome.getCurrentLocation() ;
                                                //        if (valueHome.getLocationGPS.isNotEmpty) {
                                                //          final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                            
                                                //       final _dataPanico = {
                                                //     "coordenadas": {
                                                //       "latitud":valueHome.getLocationGPS['latitud'],
                                                //       "longitud":valueHome.getLocationGPS['longitud']
                                                //     },
                                                //     "rucempresa": "ULTRA2022",
                                                //     "perId": valueHome.getUser!['id']
                                                //   };
                            
                                                //   valueHome.activateAlarm();
                            
                                                //   print('esta la info para el bon de panico ------> ${valueHome.gpsStatus}');
                                                //   _ctrlSocket.emitEvent('client:boton-panico', _dataPanico);
                            
                                                //           }
                            
                                                //   } else {
                                                //       NotificatiosnService.showSnackBarDanger('Por favor active su GPS');
                            
                                                //   }
                            
                                                //*******************/
                                              }
                                              // () => Navigator.pushNamed(
                                              //     context, 'SubmenuMascotas'),
                                              // onTap: () {
                                              //   Navigator.of(context).push(MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           const SubmenuMascotas()));
                                              // },
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  widget.user!['isClient'] == 'SI'
                                      ? Container(
                                          width: size.wScreen(100.0),
                                          height: size.wScreen(40.0),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.iScreen(1.0)),
                            
                                          // color: Colors.red,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: size.wScreen(100.0),
                                                child: Text(
                                                  'Chat Comunitario',
                                                  // textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: size.iScreen(2.2),
                                                    fontWeight: FontWeight.w700,
                                                    color: octinaryColor,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.iScreen(1.0),
                                                    vertical:
                                                        size.iScreen(1.0)),
                                                width: size.wScreen(100.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    
                                                   Container(
                                                        //  color: Colors.blue,
                                                        width: size.wScreen(70.0),
                                                        child: Text(
                                                          'Interactúa con tus vecinos e informa a tu comunidad temas relevantes.',
                                                          // textAlign: TextAlign.center,
                                                          style:
                                                              GoogleFonts.poppins(
                                                            fontSize:
                                                                size.iScreen(1.7),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: octinaryColor,
                                                            letterSpacing: -0.28,
                                                          ),
                                                        ),
                                                      ),
                                                    
                                                   
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final serviceSocket =
                                                            context.read<
                                                                SocketModel>();
                                                        final _ctrlChat =
                                                            context.read<
                                                                ChatController>();
                            
                                                        // serviceSocket.emitEvent( 'client:lista-usuarios', {"chat_id": 4} );
                                                        serviceSocket.emitEvent(
                                                            'client:lista-chats-grupos',
                                                            {});
                            
                                                        // _chatCtrl.buscaGruposChat(context);
                                                        //      final infoUser  = await Auth.instance.getSession();
                                                        _ctrlChat
                                                            .buscaGruposChat(
                                                                context);
                            
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    ((context) =>
                                                                        ListaGruposChat())));
                                                            //             .then((value) {
                                                            //               serviceSocket.emitEvent(
                                                            // 'client:lista-chats-grupos',
                                                            // {}
                                                            
                                                            // );
                                                            //             });
                                                      },
                                                      child: 
                                                      
                                                      
                                                      
                                                      // Container(
                                                      //   // color: Colors.yellow,
                                                      //   width:
                                                      //       size.wScreen(20.0),
                                                      //   child: Image.asset(
                                                      //     'assets/imgs/chat-bubble.png',
                                                      //     // scale: 1.5,
                                                      //     // fit: BoxFit.,
                                                      //     // width: size.1Screen(5.0), // URL de la imagen
                                                      //   ),
                                                      // ),
                                                       Consumer<SocketModel>(builder: (_, valueMsgNoRead, __) { 
                                                               return  valueMsgNoRead.getMsgNoLeidos>0? Badge(
                                                       position:
                                const BadgePosition(top: -3.0, start: 45.0),
                         
                            badgeContent: Text(
                              '${valueMsgNoRead.getMsgNoLeidos}',
                                style: GoogleFonts.poppins(
                                fontSize: size.iScreen(1.4),
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            badgeColor: tercearyColor,
                                                      child:Container(
                                                        // color: Colors.yellow,
                                                        width:
                                                            size.wScreen(20.0),
                                                        child: Image.asset(
                                                          'assets/imgs/chat-bubble.png',
                                                          // scale: 1.5,
                                                          // fit: BoxFit.,
                                                          // width: size.1Screen(5.0), // URL de la imagen
                                                        ),
                                                      ),
                                                    ):SizedBox(
              width: size.wScreen(20.0),
              child: Image.asset(
                'assets/imgs/chat-bubble.png',
              ),
            );
                                                     },),

                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  Expanded(
                                    child: Container(
                                      width: size.wScreen(100.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.iScreen(1.0)),
                            
                                      // height: size.wScreen(40.0),
                            
                                      // color: Colors.red,
                                      // color: Colors.red,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                                                // Center(
                                                                //         child: Consumer<HomeController>(
                                                                //           builder: (context, permissionsProvider, child) {
                                                                //             return Column(
                                                                //               mainAxisAlignment: MainAxisAlignment.center,
                                                                //               children: <Widget>[
                                                                //                 Text('Estado del permiso de ubicación:'),
                                                                //                 // _buildPermissionStatus(permissionsProvider.locationPermissionStatus.),
                                                                //                 ElevatedButton(
                                                                //                   onPressed: () async {
                                                                //                     await permissionsProvider.checkLocationPermission();
                                                                //                   },
                                                                //                   child: Text('Verificar Permiso'),
                                                                //                 ),
                                                                //                 ElevatedButton(
                                                                //                   onPressed: () async {
                                                                //                     await permissionsProvider.requestLocationPermission();
                                                                //                   },
                                                                //                   child: Text('Solicitar Permiso'),
                                                                //                 ),
                                                                //               ],
                                                                //             );
                                                                //           },
                                                                //         ),
                                                                //       ),
                                                                
                                          Container(
                                            width: size.wScreen(100.0),
                                            child: Text(
                                              'Noticias para ti',
                                              // textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                fontSize: size.iScreen(2.2),
                                                fontWeight: FontWeight.w700,
                                                color: octinaryColor,
                                              ),
                                            ),
                                          ),
                                        
                                          //***********************************************/
                                                                
                                          SizedBox(
                                            height: size.iScreen(1.5),
                                          ),
                                          //*****************************************/
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8.0)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.iScreen(1.0),
                                                  vertical: size.iScreen(1.0)),
                                                  margin: EdgeInsets.only(
                                                  bottom: size.iScreen(1.0),
                                                 ),
                                              width: size.wScreen(100.0),
                                              child: Container(
                                                // color: Colors.red,
                                                // width: size.wScreen(95.0),
                                                // height: size.iScreen(2),
                                                child: Consumer<HomeController>(
                                                  builder:
                                                      (_, valueNoticias, __) {
                                                    return valueNoticias
                                                            .getListaTodasLasNoticias
                                                            .isNotEmpty
                                                        ? CarouselSlider(
                                                            options:
                                                                CarouselOptions(
                                                              // height: 200.0,
                                                              autoPlay: true,
                                                              aspectRatio: 16 / 9,
                                                              enlargeCenterPage:
                                                                  true,
                                                            ),
                                                            items: valueNoticias
                                                                .getListaTodasLasNoticias
                                                                .map((info) {
                                                              return Builder(builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Container(
                                                                    width: size
                                                                        .wScreen(
                                                                            100),
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                            horizontal:
                                                                                1.0),
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            size.iScreen(
                                                                                0.0)),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            // color: Colors.yellow.shade50,
                                                                            ),
                                                                    child: info['noti_tipo_servicio'] ==
                                                                            'HOGAR'
                                                                        ? 
                                                                        Container(
                                                                            padding: EdgeInsets.symmetric(
                                                                                horizontal: size.iScreen(0.0),
                                                                                vertical: size.iScreen(0.0)),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(8.0),
                                                                              color:
                                                                                  Colors.grey.shade100,
                                                                            ),
                                                                            child:
                                                                            //     Column(
                                                                            //   children: [
                                                                            //     // Text(
                                                                            //     //   '${info['noti_titulo']}',
                                                                            //     //   style: GoogleFonts.poppins(
                                                                            //     //     fontSize: size.iScreen(2.0),
                                                                            //     //     fontWeight: FontWeight.w700,
                                                                            //     //     color: octinaryColor,
                                                                            //     //   ),
                                                                            //     // ),
                                                                  
                                                                            //     Container(
                                                                            //       width: size.iScreen(100),
                                                                            //       height: size.hScreen(22),
                                                                            //       child: CachedNetworkImage(
                                                                            //         imageUrl: info['noti_foto'],
                                                                            //         fit: BoxFit.fill,
                                                                            //         placeholder: (context, url) => const CupertinoActivityIndicator(),
                                                                            //         // Image.asset(
                                                                            //         //     'assets/imgs/loader.gif'),
                                                                  
                                                                            //         errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                            //       ),
                                                                            //     ),
                                                                            //     //  Text(
                                                                            //     //   '${info['noti_descripcion']}',
                                                                            //     //   textAlign: TextAlign.center,
                                                                            //     //   style: GoogleFonts.poppins(
                                                                            //     //     fontSize: size.iScreen(1.7),
                                                                            //     //     fontWeight: FontWeight.normal,
                                                                            //     //     color: octinaryColor,
                                                                            //     //   ),
                                                                            //     // ),
                                                                            //   ],
                                                                            // ),
                                                                             InkWell(
                                                                              onTap: (){
                                                                                 Navigator.push(context,
                                                          MaterialPageRoute(builder: ((context) =>  InfoPublicidad(infoPublicidad:info))));
                                                                              },
                                                                               child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                 child: Container(
                                                                                      width: size.iScreen(100),
                                                                                      height: size.hScreen(22),
                                                                                      child: CachedNetworkImage(
                                                                                        imageUrl: info['noti_foto'],
                                                                                        fit: BoxFit.fill,
                                                                                        placeholder: (context, url) => const CupertinoActivityIndicator(),
                                                                                        // Image.asset(
                                                                                        //     'assets/imgs/loader.gif'),
                                                                                                                                                            
                                                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                                      ),
                                                                                    ),
                                                                               ),
                                                                             ),
                                                                          )
                                                                        : CachedNetworkImage(
                                                                            imageUrl:
                                                                                info['url'],
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            placeholder: (context, url) =>
                                                                                const CupertinoActivityIndicator(),
                                                                            // Image.asset(
                                                                            //     'assets/imgs/loader.gif'),
                                                                  
                                                                            errorWidget: (context, url, error) =>
                                                                                const Icon(Icons.error),
                                                                          ));
                                                              });
                                                            }).toList(),
                                                          )
                                                        : NoData(
                                                            label:
                                                                'No hay noticias nuevas');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                      ],
                    )
                  : const NoData(label: 'No tiene conexión...'),
            ),
          ),
        );
        // :Scaffold(body: Container(

        //   height: size.hScreen(100),
        //   width: size.wScreen(100),
        //   child: NoSession(label: 'Su sessión ha expirado ')),);
      },
    );
  }

// bool _buildPermissionStatus(PermissionStatus? status) {
//     if (status == null) {
//       return false;
//     } else if (status == PermissionStatus.granted) {
//       return true;
//     } else if (status == PermissionStatus.denied) {
//       return false;
//     } else {
//       return false;
//     }
//   }

// Future<bool> _checkIfHasPermission(PermissionStatus? status) async {
//     if (status == PermissionStatus.granted) {
//       return true;
//     } else if (status == PermissionStatus.denied) {
//       return false;
//     } else {
//       // En este caso, podrías considerar manejar el estado desconocido de alguna manera específica.
//       return false;
//     }
//   }

// void _showPermissionModal(BuildContext context, Responsive size,String _title) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           color: Color.fromARGB(117, 0, 0, 0), // Color oscuro de fondo
//           child: CupertinoAlertDialog(
//             // title: Text('Permisos Necesarios', style: GoogleFonts.poppins(
//             //             fontSize: size.iScreen(2.0),
//             //             color: Colors.black,
//             //             fontWeight: FontWeight.w600)),
//             content: Column(
//               children: [

//                 SizedBox(height: size.iScreen(1.0)),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // CupertinoButton(
//                     //   child: Text('Permitir GPS'),
//                     //   onPressed: () async {
//                     //     Navigator.pop(context); // Cierra el modal
//                     //     // await _requestPermission(Permission.location);
//                     //   },
//                     // ),
//                     // SizedBox(width: 20),
//                     // CupertinoButton(
//                     //   child: Text('Permitir Cámara'),
//                     //   onPressed: () async {
//                     //     Navigator.pop(context); // Cierra el modal
//                     //     // await _requestPermission(Permission.camera);
//                     //   },
//                     // ),
//                     Icon(Icons.info_outline,size: size.iScreen(5.0),color: Colors.green,),
//               SizedBox(height: size.iScreen(1.0),),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)),
//                 child: Text(_title,
//                     style: GoogleFonts.poppins(
//                         fontSize: size.iScreen(2.0),
//                         color: Colors.black,
//                         fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
//               ),
//                       SizedBox(height: size.iScreen(3.0),),
//                   ],
//                 ),
//               ],
//             ),
//             actions: [
//               CupertinoDialogAction(
//                 child: Text('Cancelar', style: GoogleFonts.poppins(
//                         fontSize: size.iScreen(1.7),
//                         color: Colors.red,
//                         fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
//                 onPressed: () {
//                   Navigator.pop(context); // Cierra el modal
//                 },
//               ),
//                CupertinoDialogAction(
//                child: Text('Aceptar',style: GoogleFonts.poppins(
//                         fontSize: size.iScreen(1.7),
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
//                 onPressed: () {
//                   openAppSettings();
//                   Navigator.pop(context);
//                   // Cierra el modal
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

}

class NoSession extends StatelessWidget {
  final String label;

  const NoSession({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Container(
      padding: EdgeInsets.all(size.iScreen(5.0)),
      // color: Colors.red,
      width: size.iScreen(100.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                textAlign: TextAlign.center,
                style: GoogleFonts.lexendDeca(
                    fontSize: size.iScreen(2.0),
                    color: Colors.black54,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: size.iScreen(2.0),
            ),
            MaterialButton(
              color: tercearyColor,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              child: Text(
                'Ok',
                style: GoogleFonts.poppins(
                    fontSize: size.iScreen(1.7),
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () async {
                var ctrlHome = context.read<HomeController>();
                // var ctrlSocket = context.read<SocketModel>();

                ProgressDialog.show(context);
                final response = await ctrlHome.cierreSesionUsuario(context);
                ProgressDialog.dissmiss(context);

                if (response != null) {
                  //----------------------------------------------------//

                  Navigator.pop(context);
                  await Auth.instance.deleteSesion(context);

                  //----------------------------------------------------//

                } else {
                  NotificatiosnService.showSnackBarDanger(response.toString());
                }

                //----------------------------------------------------//
              },
            ),
          ],
        ),
      ),
    );
  }
}
