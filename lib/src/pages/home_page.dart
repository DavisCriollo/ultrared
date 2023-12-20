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
import 'package:ultrared/src/pages/auxilio_page.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/pages/lista_grupos_chat.dart';
import 'package:ultrared/src/pages/lista_notificaciones.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/pages/splash_screen.dart';
import 'package:ultrared/src/service/local_notifications.dart';
import 'package:ultrared/src/service/notification_push.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/drawer_menu.dart';

import 'package:ultrared/src/widgets/elementoSOS.dart';
import 'package:ultrared/src/widgets/elementosHome.dart';
import 'package:ultrared/src/widgets/no_data.dart';
// import 'socket_provider.dart'; // Asegúrate de importar tu SocketProvider

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  Map<String, dynamic>? user = {};

        final ctrlHome =HomeController();
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

    FirebaseService.configureFirebaseMessaging();
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
      await ctrlHome.validaInicioDeSesion(context);
      print('EL ESTADO ES ------: $state');
      ctrlHome.getLocation();
  //  final Map<String, dynamic>? session = await Auth.instance.getSession();
  //      var _ctrlSocket = context.read<SocketModel>();
  //             _ctrlSocket.connectToSocket("${session!['token']}", "${session['rucempresa']}");
  // Navigator.pushNamed(context, 'splash');

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
 Provider.of<SocketModel>(context, listen: false).disconnectSocket();
    // if (mounted) {
      // Asegúrate de limpiar la suscripción cuando el widget es desmontado
      // FirebaseMessaging.onMessage.drain();
      // FirebaseMessaging.onMessageOpenedApp.drain();
    // }
   
    super.dispose();
  }



    //------------------------------------//

     // Manejar la notificación cuando la aplicación está en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notificación recibida primer plano ************* >: $message");

      // Aquí puedes dirigir al usuario a la pantalla deseada






      final _infoNotificacion={
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
			"perFoto": "https://documentos.neitor.com/contable/fotoperfil/ULTRA2022/96eee234-93e9-4a4c-9fb7-7d12ba3b3c5a.png",
			"perFotoCasa": "https://documentos.neitor.com/contable/fotocasa/ULTRA2022/b2ed4c5b-e7db-4e34-8ba3-c32a9480f6c0.png",
			"perFotoVehiculo": "",
			"perPerfil": [
				"CLIENTE"
			],
			"notInformacionAdicional": {
				"tipoServicio": "HOGAR",
				"coordenadas": {
					"latitud": -0.239079,
					"longitud": -79.171853
				}
			}
		};  ctrlHome.setInfoNotificacion(_infoNotificacion);

     Navigator.of(context).pushNamed('auxilo');
     
        //  Navigator.of(context).push(MaterialPageRoute(
        //                                             builder: (context) =>
        //                                                 const AuxilioPage()));




    });

    // Manejar la notificación cuando la aplicación se abre desde la barra de notificaciones
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notificación abierta desde la aplicación se abre desde la barra de notificaciones ********* >: $message");
      // Aquí puedes dirigir al usuario a la pantalla deseada


            final _infoNotificacion={
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
			"perFoto": "https://documentos.neitor.com/contable/fotoperfil/ULTRA2022/96eee234-93e9-4a4c-9fb7-7d12ba3b3c5a.png",
			"perFotoCasa": "https://documentos.neitor.com/contable/fotocasa/ULTRA2022/b2ed4c5b-e7db-4e34-8ba3-c32a9480f6c0.png",
			"perFotoVehiculo": "",
			"perPerfil": [
				"CLIENTE"
			],
			"notInformacionAdicional": {
				"tipoServicio": "HOGAR",
				"coordenadas": {
					"latitud": -0.239079,
					"longitud": -79.171853
				}
			}
		}; 
     ctrlHome.setInfoNotificacion(_infoNotificacion);


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

    user = await Auth.internal().getSession();
    ctrlHome.setUserApp(user);
    // print('${user!['nombre']}');

    // final  socketManager = context.read<SocketService>();
    // if (socketManager.status == SocketStatus.desconectado) {
    //   socketManager.conectar();
    // }
  }





  @override
  Widget build(BuildContext context) {
  
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
        return SafeArea(
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
                    ? 
                    Consumer<HomeController>(builder: (_, value, __) {  
                      return
                    Badge(
                        position: const BadgePosition(top: 10.0, start: 25.0),
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

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ListaNotificaciones()));
                              },
                              icon: Icon(
                                Icons.notifications,
                                size: size.iScreen(3.5),
                                color: Colors.black,
                              )),
                        ),
                      );},)
                    
                    : Container()
              ],
            ),
            drawer: values.connectionStatus != ConnectionStatus.none
                ? 
                DrawerMenu(user: user)
                : null,
            body: Container(
              height: size.hScreen(90),
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

                        Expanded(
                          child: Container(
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
                                      alignment : WrapAlignment.center,
                                      crossAxisAlignment : WrapCrossAlignment.center,
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceAround,
                                      children: [
                                       _ctrl.getUser!['isClient']=='SI'
                                        ?ElementosHome(
                                            enabled: true,
                                            size: size,
                                            image: 'assets/imgs/document.png',
                                            title: 'Estado de Cuenta',
                                            label:
                                                'Verifica tu estado de cuenta',
                                            onTap: () {

                                          NotificationHelper().showNotification(
              title: 'Título de la notificación',
              body: 'Cuerpo de la notificación',
            );

                                            }
                                            // () => Navigator.pushNamed(
                                            //     context, 'SubmenuMascotas'),
                                            // onTap: () {
                                            //   Navigator.of(context).push(MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           const SubmenuMascotas()));
                                            // },
                                            ): Container(),
                                        ElementosSOS(
                                            enabled: true,
                                            size: size,
                                            image: 'assets/imgs/document.png',
                                            title: 'Botón de Ayuda',
                                            label: 'Presiona por 3 segundos',
                                            onTap: ()  async{
                                              // final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                                              final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                                               final status = await Permission .location.request();
                                                    if (status == PermissionStatus .granted) {
                                                      //   // print('============== SI TIENE PERMISOS');
                                                      await _ctrl
                                                          .getLocation();
                                                      if (_ctrl.getLocationGPS.isNotEmpty) {
                                                       
                                                  final _dataPanico = {
                                                "coordenadas": {
                                                  "latitud":_ctrl.getLocationGPS['latitud'],
                                                  "longitud":_ctrl.getLocationGPS['longitud']
                                                },
                                                "rucempresa": "ULTRA2022",
                                                "perId": _ctrl.getUser!['id']
                                              };


                                              _ctrl.activateAlarm();

                                              print('esta la info para el bon de panico ------> $_dataPanico');
                                              _ctrlSocket.emitEvent('client:boton-panico', _dataPanico);


                                                       
                                                      }
                                                    } else {
                                                      Navigator.pushNamed(
                                                          context, 'gps');
                                                    }


                                           



                                         

//  showNotification();
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
                                  _ctrl.getUser!['isClient']=='SI'
                                        ?
                                Container(
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
                                                BorderRadius.circular(8.0)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.iScreen(1.0),
                                            vertical: size.iScreen(1.0)),
                                        width: size.wScreen(100.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              //  color: Colors.blue,
                                              width: size.wScreen(70.0),
                                              child: Text(
                                                'Interactua con tus vecinos e informa a tu comunidad temas relevantes.',
                                                // textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: size.iScreen(1.7),
                                                  fontWeight: FontWeight.w700,
                                                  color: octinaryColor,
                                                  letterSpacing: -0.28,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                final serviceSocket = context
                                                    .read<SocketModel>();
                                                final _ctrlChat = context
                                                    .read< ChatController>();

                                                // serviceSocket.emitEvent( 'client:lista-usuarios', {"chat_id": 4} );
                                                serviceSocket.emitEvent( 'client:lista-chats-grupos', {} );

                                                // _chatCtrl.buscaGruposChat(context);
                                                //      final infoUser  = await Auth.instance.getSession();
                                                _ctrlChat.buscaGruposChat(context);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            ListaGruposChat())));
                                              },
                                              child: Container(
                                                // color: Colors.yellow,
                                                width: size.wScreen(20.0),
                                                child: Image.asset(
                                                  'assets/imgs/chat-bubble.png',
                                                  // scale: 1.5,
                                                  // fit: BoxFit.,
                                                  // width: size.1Screen(5.0), // URL de la imagen
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ) : Container(),
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
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.iScreen(1.0),
                                              vertical: size.iScreen(1.0)),
                                          width: size.wScreen(100.0),
                                          child: Container(
                                            // color: Colors.yellow,
                                            width: size.wScreen(95.0),
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
                                                                    ? Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: size.iScreen(1.0),
                                                                            vertical: size.iScreen(1.0)),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          color:
                                                                              Colors.yellow.shade100,
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Text(
                                                                              '${info['noti_titulo']}',
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: size.iScreen(2.0),
                                                                                fontWeight: FontWeight.w700,
                                                                                color: octinaryColor,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '${info['noti_descripcion']}',
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: size.iScreen(1.7),
                                                                                fontWeight: FontWeight.normal,
                                                                                color: octinaryColor,
                                                                              ),
                                                                            ),
                                                                          ],
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : NoData(label: 'No tiene conexión...'),
            ),
          ),
        );
      },
    );
  }

 














}
