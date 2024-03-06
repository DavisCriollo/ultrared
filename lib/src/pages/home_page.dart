import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
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
import 'package:ultrared/src/service/socket.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/drawer_menu.dart';

import 'package:ultrared/src/widgets/elementoSOS.dart';
import 'package:ultrared/src/widgets/elementosHome.dart';


import 'package:ultrared/src/widgets/modal_permisos.dart';
import 'package:ultrared/src/widgets/no_data.dart';
import 'package:upgrader/upgrader.dart';
// import 'socket_provider.dart'; // Asegúrate de importar tu SocketProvider

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? user;
  const HomePage({Key? key, this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Map<String, dynamic>? user = {};

  final ctrlHome = HomeController();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
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

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

// ======================= OBSERVABLE  ==========================//

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await ctrlHome.validaInicioDeSesion(context);
      // Navigator.pushNamed(context, 'splash');
    }
    if (state == AppLifecycleState.inactive) {
      print('EL ESTADO ES: $state');
    }
    if (state == AppLifecycleState.paused) {
      print('EL ESTADO ES: $state');
    }
  }

  initData() async {
    WidgetsBinding.instance!.addObserver(this);

    var ctrlHome = context.read<HomeController>();

    // Obtén el token de registro de Firebase
    String? firebaseToken = await FirebaseMessaging.instance.getToken();
    // print("Firebase ok Token: $firebaseToken");

    await Auth.internal().saveTokenFireBase(firebaseToken.toString());
    ctrlHome.setTokennotificacion(firebaseToken, 'guardar');




    
    //------------------------------------//

    // Manejar la notificación cuando la aplicación está en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "Notificación recibida primer plano ************* >: ${message.data}");
      //------------------------------------//

      // ctrlHome.buscaNotificacionPorId(context, message.data['notId']);
      //  ctrlHome.setInfoNotificacion(_infoNotificacion);

      // Navigator.of(context).pushNamed('auxilo');
       Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>  AuxilioPage(idNotificacion: message.data['notId']))));

      ctrlHome.buscarNotificaciones(context);
    });

    // Manejar la notificación cuando la aplicación se abre desde la barra de notificaciones
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "Notificación abierta desde la aplicación se abre desde la barra de notificaciones ********* >: ${message.data}");
      // Aquí puedes dirigir al usuario a la pantalla deseada
//*****************//
      // ctrlHome.buscaNotificacionPorId(context, message.data['notId']);

      // Navigator.of(context).pushNamed('notificaciones');


//  ctrlHome.buscaNotificacionPorId(context, message.data['notId']);
      //  ctrlHome.setInfoNotificacion(_infoNotificacion);
      
     
Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>  AuxilioPage(idNotificacion: message.data['notId']))));
      
       ctrlHome.buscarNotificaciones(context);
      // Navigator.of(context).pushNamed('auxilo');

      // ctrlHome.buscarNotificaciones(context);


    });

 FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      // Manejar la notificación cuando la aplicación está cerrada y se abre desde la notificación
      if (message != null) {
        Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>  AuxilioPage(idNotificacion: message.data['notId']))));
                    //     .then((value) =>  Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //     builder: ((context) =>  const SplashPage()))) );
      }



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

    // if (socketManager.status == SocketStatus.desconectado) {
    //   socketManager.conectar();
    // }
  }

  void isUpdate() async {
    await Auth.instance.deleteCache(context);
  }

  @override
  Widget build(BuildContext context) {
    //  print('****************> REDIBUJA');
    @override
    final Responsive size = Responsive.of(context);
    // var socketProvider = context.read<SocketService>();
    final _ctrl = context.read<HomeController>();
    // _ctrl.buscarNoticias(context);
    // _ctrl.buscarNotificaciones(context);

    // final _chatCtrl = context.read<ChatController>();
    _ctrl.checkConnectivity();
    // var socketProvider =Provider.of<SocketProvider>(context,listen:  true);
    //  _ctrl.getconectionInternet== false?
    return Consumer<HomeController>(
      builder: (_, values, __) {
        return

            // values.getValidaSession == true ?

            SafeArea(
          child: UpgradeAlert(
            upgrader: Upgrader(
              onUpdate: () {
                // print('SE REALIZA LA ACCION DE ACTUALIZAR');
                isUpdate();
                return true;
              },
              canDismissDialog: false,
              durationUntilAlertAgain: Duration(minutes: 1),
              showIgnore: false,
              showLater: false,
              languageCode: 'es',
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
            ),
            child: Scaffold(
              key: _scaffoldKey,
              // backgroundColor: Colors.grey.shade200, // appBar: AppBar(
              //   title: Text('Estado del Socket'),
              // ),
              // appBar:

              // AppBar(
              //   toolbarHeight: size.hScreen(10.0),
              //   iconTheme: const IconThemeData(color: Colors.black),
              //   elevation: 0.0,
              //   backgroundColor: cuaternaryColor, //
              //   title: Container(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: size.iScreen(1.0),
              //         vertical: size.iScreen(0.5)),
              //     alignment: Alignment.centerLeft,
              //     // color:Colors.blue,
              //     width: size.wScreen(80.0),
              //     height: size.wScreen(17.0),
              //     child: Row(
              //       children: [
              //         Image.asset(
              //           'assets/imgs/letras_UR.png',
              //           scale: 1.0,
              //           // fit: BoxFit.,
              //           // width: size.1Screen(5.0), // URL de la imagen
              //         ),
              //         Text(
              //           ' Seguridad Móvil',
              //           textAlign: TextAlign.center,
              //           style: GoogleFonts.poppins(
              //               fontSize: size.iScreen(2.2),
              //               fontWeight: FontWeight.w500,
              //               color: secondaryColor),
              //         ),
              //       ],
              //     ),
              //   ),
              //   actions: [
              //     values.connectionStatus != ConnectionStatus.none
              //         ? Consumer<HomeController>(
              //             builder: (_, value, __) {
              //               return value.getListaTodasLasNotificaciones.length >
              //                       1
              //                   ? Badge(
              //                       position: const BadgePosition(
              //                           top: 10.0, start: 25.0),
              //                       badgeContent: Text(
              //                         //  value.getListaNotificaciones.isNotEmpty?  '${value.getListaNotificaciones.length}':'',
              //                         '${value.getListaTodasLasNotificaciones.length}',
              //                         style: GoogleFonts.poppins(
              //                           fontSize: size.iScreen(1.4),
              //                           fontWeight: FontWeight.normal,
              //                           color: Colors.white,
              //                         ),
              //                       ),
              //                       badgeColor: tercearyColor,
              //                       child: Container(
              //                         margin: EdgeInsets.only(
              //                             right: size.iScreen(2.0)),
              //                         child: IconButton(
              //                             onPressed: () {
              //                               context
              //                                   .read<HomeController>()
              //                                   .buscarNotificaciones(context);

              //                               //

              //                               Navigator.of(context).push(
              //                                   MaterialPageRoute(
              //                                       builder: (context) =>
              //                                           const ListaNotificaciones()));
              //                             },
              //                             icon: Icon(
              //                               Icons.notifications,
              //                               size: size.iScreen(3.5),
              //                               color: Colors.black,
              //                             )),
              //                       ),
              //                     )
              //                   : Container(
              //                       margin: EdgeInsets.only(
              //                           right: size.iScreen(2.0)),
              //                       child: IconButton(
              //                           onPressed: () {
              //                             context
              //                                 .read<HomeController>()
              //                                 .buscarNotificaciones(context);

              //                             //

              //                             Navigator.of(context).push(
              //                                 MaterialPageRoute(
              //                                     builder: (context) =>
              //                                         const ListaNotificaciones()));
              //                           },
              //                           icon: Icon(
              //                             Icons.notifications,
              //                             size: size.iScreen(3.5),
              //                             color: Colors.black,
              //                           )),
              //                     );
              //             },
              //           )
              //         : Container()
              //   ],
              // ),
              drawer: values.connectionStatus != ConnectionStatus.none
                  ?
                  // DrawerMenu(user: user)
                  DrawerMenu()
                  : null,

              body: Container(
                // height: size.hScreen(100),
                width: size.wScreen(100),
                color: Colors.white,
                child: values.connectionStatus != ConnectionStatus.none
                    ? Column(
                        children: [
                          CabeceraHomeApp(
                              size: size,
                              colorBase: Colors.white,
                              title: 'NOTIFICACIONES',
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              }),
                          Expanded(child: Consumer<HomeController>(
                            builder: (_, valueHome, __) {
                              return Container(
                                child: Column(
                                  children: [
                                    Text('Botón de ayuda',
                                        style: GoogleFonts.poppins(
                                          fontSize: size.iScreen(2.0),
                                          fontWeight: FontWeight.w500,
                                          color: sextinaryColor,
                                          letterSpacing: -0.20,
                                        )),

                                      Consumer<SocketService>(builder: (_, _ctrlSocket, __) {  

                                        return  ElementoSOS(
                                        enabled: true,
                                        size: size,
                                        image: 'assets/imgs/document.png',
                                        title: 'Botón de Ayuda',
                                        label: 'Presiona por 3 segundos',
                                        onTap: () async {
                                         

                                          // final _ctrlSocket =
                                          //     Provider.of<SocketService>(
                                          //         context,
                                          //         listen: false);
    //                                       // final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
    // HomeController permissionProvider =  Provider.of<HomeController>(
    //                                               context,
    //                                               listen: false);
                                          await valueHome
                                              .checkAndRequestPermissions();
                                          bool isGpsEnabled =
                                              await valueHome
                                                  .checkGpsStatus();
                                          // print('LA INFO ES  ${valueHome.hasLocationPermission} ${isGpsEnabled}');

                                          if (valueHome
                                              .hasLocationPermission) {
                                            // NotificatiosnService.showSnackBarSuccsses('SIII TIENE PERMISO');
                                            if (isGpsEnabled) {
                                              //  NotificatiosnService.showSnackBarDanger(' GPS ACTIVADO ');

                                              await valueHome.getLocation();
                                              if (valueHome
                                                  .getLocationGPS.isNotEmpty) {
                                                final _dataPanico = {
                                                  "coordenadas": {
                                                    "latitud": valueHome
                                                            .getLocationGPS[
                                                        'latitud'],
                                                    "longitud": valueHome
                                                            .getLocationGPS[
                                                        'longitud']
                                                  },
                                                  "rucempresa": "ULTRA2022",
                                                  "perId":
                                                      valueHome.getUser!['id']
                                                };

                                                valueHome.activateAlarm(true);

                                                // print(
                                                //     'esta la info para el bon de panico ------> $_dataPanico');

                                                _ctrlSocket.emitEvent(
                                                    'client:boton-panico',
                                                    _dataPanico);

                                                    // _ctrlSocket
                                                    //   .setMsgErrorServer('');
                                                  // _ctrl.desActivateAlarm();

                                                // if (_ctrlSocket.getMsgError !=
                                                //     '') {
                                                      
                                                //   // NotificatiosnService
                                                //   //     .showSnackBarDanger(
                                                //   //         _ctrlSocket
                                                //   //             .getMsgError);
                                                // //    showSOSModal(context, size,_ctrlSocket
                                                // //  .getMsgError);

                                                //  await _showSuccessDialog(context, _ctrlSocket
                                                //  .getMsgError);

                                                  
                                                  
                                                // }
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

                                            showPermissionModal(context, size,
                                                'Para usar el botón de pánico en nuestra aplicación, es esencial conceder permisos de ubicación.');
                                          }
                                          //**************/

                                          //*******************/
                                        }
                                        // () => Navigator.pushNamed(
                                        //     context, 'SubmenuMascotas'),
                                        // onTap: () {
                                        //   Navigator.of(context).push(MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           const SubmenuMascotas()));
                                        // },
                                        );

                                      },),

                                   
                                   widget.user!['isClient'] == 'SI'
                                        ?   BannerChat(size: size, widget: widget):Container(),
                                    SizedBox(
                                      height: size.iScreen(0.5),
                                    ),
                                    widget.user!['isClient'] == 'SI'
                                        ? BannerEstadoDeCuenta(
                                            size: size, widget: widget)
                                        : Container(),
                                    Container(
                                       margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.0),vertical: size.iScreen(0.5)),
                                      padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0),vertical: size.iScreen(0.2)),
                                      width: size.wScreen(100.0),
                                      color: colorSecundario,
                                      child: Text('Noticias pata tí',
                                          style: GoogleFonts.poppins(
                                            fontSize: size.iScreen(1.9),
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            letterSpacing: 0.48,
                                            
                                          ),textAlign: TextAlign.center,),
                                    ),
                                          
                                            //***********************************************/

                                            SizedBox(
                                              height: size.iScreen(1.5),
                                            ),
                                            //*****************************************/
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.iScreen(1.0),
                                                    vertical:
                                                        size.iScreen(1.0)),
                                                margin: EdgeInsets.only(
                                                  bottom: size.iScreen(1.0),
                                                ),
                                                width: size.wScreen(100.0),
                                                child: Container(
                                                  // color: Colors.red,
                                                  // width: size.wScreen(95.0),
                                                  // height: size.iScreen(2),
                                                  child:
                                                      Consumer<HomeController>(
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
                                                                aspectRatio:
                                                                    16 / 9,
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
                                                                      width: size.wScreen(
                                                                          100),
                                                                      margin: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              1.0),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: size.iScreen(
                                                                              0.0)),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              // color: Colors.yellow.shade50,
                                                                              ),
                                                                      child: info['noti_tipo_servicio'] ==
                                                                              'HOGAR'
                                                                          ? Container(
                                                                              padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.0), vertical: size.iScreen(0.0)),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                color: Colors.grey.shade100,
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
                                                                                onTap: () {
                                                                                  Navigator.push(context, MaterialPageRoute(builder: ((context) => InfoPublicidad(infoPublicidad: info))));
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
                                                                              imageUrl: info['url'],
                                                                              fit: BoxFit.cover,
                                                                              placeholder: (context, url) => const CupertinoActivityIndicator(),
                                                                              // Image.asset(
                                                                              //     'assets/imgs/loader.gif'),

                                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                              );





                              // Container(
                              //   // height: size.hScreen(80.0),
                              //   // color: Colors.blue,
                              //   child: Column(
                              //     children: [
                              //       Container(
                              //         width: size.wScreen(100.0),
                              //         height: size.wScreen(60.0),

                              //         // color: Colors.red,
                              //         child: Container(
                              //           alignment: Alignment.center,
                              //           child: Wrap(
                              //             alignment: WrapAlignment.center,
                              //             crossAxisAlignment:
                              //                 WrapCrossAlignment.center,
                              //             // mainAxisAlignment:
                              //             //     MainAxisAlignment.spaceAround,
                              //             children: [
                              //               widget.user!['isClient'] == 'SI'
                              //                   ? ElementosHome(
                              //                       enabled: true,
                              //                       size: size,
                              //                       image:
                              //                           'assets/imgs/document.png',
                              //                       title: 'Estado de Cuenta',
                              //                       label:
                              //                           'Verifica tu estado de cuenta',
                              //                       onTap: () {
                              //                         //                               NotificationHelper().showNotification(
                              //                         //   title: 'Título de la notificación',
                              //                         //   body: 'Cuerpo de la notificación',
                              //                         // );
                              //                         valueHome.buscaEstadoDeCuenta(context);
                              //                         Navigator.push(
                              //                             context,
                              //                             MaterialPageRoute(
                              //                                 builder: ((context) =>
                              //                                     const DataTableEstadoCuenta())));
                              //                       }
                              //                       // () => Navigator.pushNamed(
                              //                       //     context, 'SubmenuMascotas'),
                              //                       // onTap: () {
                              //                       //   Navigator.of(context).push(MaterialPageRoute(
                              //                       //       builder: (context) =>
                              //                       //           const SubmenuMascotas()));
                              //                       // },
                              //                       )
                              //                   : Container(),
                              //               ElementosSOS(
                              //                   enabled: true,
                              //                   size: size,
                              //                   image:
                              //                       'assets/imgs/document.png',
                              //                   title: 'Botón de Ayuda',
                              //                   label:
                              //                       'Presiona por 3 segundos',
                              //                   onTap: () async {
                              //                     //**************//
                              //                     //  HomeController permissionProvider = Provider.of<HomeController>(context, listen: false);
                              //                     //             await permissionProvider.checkAndRequestLocationPermission();
                              //                     //             print(permissionProvider.hasLocationPermission);

                              //                     //             await permissionProvider.checkAndRequestLocationPermission();
                              //                     //             print('**** Permiso ****>  ${permissionProvider.hasLocationPermission}');
                              //                     //   permissionProvider.checkGpsStatus();
                              //                     //                    if (permissionProvider.hasLocationPermission==true) {
                              //                     //                       // permissionProvider.checkGpsStatus();

                              //                     //                                               if (permissionProvider.gpsStatus==true ) {
                              //                     //                                                  NotificatiosnService.showSnackBarSuccsses('El  GPS esta activado');

                              //                     //                    } else {
                              //                     //                      NotificatiosnService.showSnackBarDanger('Por favor active su GPS');
                              //                     //                    }
                              //                     //                    }
                              //                     //                    else{
                              //                     //                      Navigator.of(context).pushAndRemoveUntil(
                              //                     //               MaterialPageRoute(
                              //                     //                   builder: (context) => AccesoGPSPage(
                              //                     //                         // validaTurno: validaTurno,
                              //                     //                         // tipo: session.rol,
                              //                     //                         // user: session,
                              //                     //                         // ubicacionGPS: controllerHome.getCoords,
                              //                     //                       )),
                              //                     //               (Route<dynamic> route) => false);

                              //                     final _ctrlSocket = Provider
                              //                         .of<SocketService>(
                              //                             context,
                              //                             listen: false);
                              //                     // final _ctrlSocket = Provider.of<SocketModel>( context,listen: false);
                              //                     HomeController
                              //                         permissionProvider =
                              //                         Provider.of<
                              //                                 HomeController>(
                              //                             context,
                              //                             listen: false);
                              //                     await permissionProvider
                              //                         .checkAndRequestPermissions();
                              //                     bool isGpsEnabled =
                              //                         await permissionProvider
                              //                             .checkGpsStatus();
                              //                     // print('LA INFO ES  ${permissionProvider.hasLocationPermission} ${isGpsEnabled}');

                              //                     if (permissionProvider
                              //                         .hasLocationPermission) {
                              //                       // NotificatiosnService.showSnackBarSuccsses('SIII TIENE PERMISO');
                              //                       if (isGpsEnabled) {
                              //                         //  NotificatiosnService.showSnackBarDanger(' GPS ACTIVADO ');

                              //                         await valueHome
                              //                             .getLocation();
                              //                         if (valueHome
                              //                             .getLocationGPS
                              //                             .isNotEmpty) {
                              //                           final _dataPanico = {
                              //                             "coordenadas": {
                              //                               "latitud": valueHome
                              //                                       .getLocationGPS[
                              //                                   'latitud'],
                              //                               "longitud": valueHome
                              //                                       .getLocationGPS[
                              //                                   'longitud']
                              //                             },
                              //                             "rucempresa":
                              //                                 "ULTRA2022",
                              //                             "perId": valueHome
                              //                                 .getUser!['id']
                              //                           };

                              //                           valueHome
                              //                               .activateAlarm();

                              //                           // print(
                              //                           //     'esta la info para el bon de panico ------> $_dataPanico');

                              //                           _ctrlSocket.emitEvent(
                              //                               'client:boton-panico',
                              //                               _dataPanico);

                              //                         if ( _ctrlSocket.getMsgError!='') {
                              //                           NotificatiosnService.showSnackBarErrorAlerta(_ctrlSocket.getMsgError);
                              //                           _ctrlSocket.setMsgErrorServer('');
                              //                           _ctrl.desActivateAlarm();
                              //                           // showErroAlerta(context, size, '${_ctrlSocket.getMsgError}');
                              //                         }

                              //                         }
                              //                       } else {
                              //                         NotificatiosnService
                              //                             .showSnackBarDanger(
                              //                                 ' Por favor active el GPS');
                              //                       }
                              //                     } else {
                              //                       //  NotificatiosnService.showSnackBarDanger('NOOOOO TIENE PERMISO');

                              //                       //        Navigator.of(context).pushAndRemoveUntil(
                              //                       // MaterialPageRoute(
                              //                       //     builder: (context) => const AccesoGPSPage()),
                              //                       // (Route<dynamic> route) => false);

                              //                       showPermissionModal(
                              //                           context,
                              //                           size,
                              //                           'Para usar el botón de pánico en nuestra aplicación, es esencial conceder permisos de ubicación.');
                              //                     }
                              //                     //**************/

                              //                     //*******************/
                              //                   }
                              //                   // () => Navigator.pushNamed(
                              //                   //     context, 'SubmenuMascotas'),
                              //                   // onTap: () {
                              //                   //   Navigator.of(context).push(MaterialPageRoute(
                              //                   //       builder: (context) =>
                              //                   //           const SubmenuMascotas()));
                              //                   // },
                              //                   ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       widget.user!['isClient'] == 'SI'
                              //           ? Container(
                              //               width: size.wScreen(100.0),
                              //               height: size.wScreen(40.0),
                              //               padding: EdgeInsets.symmetric(
                              //                   horizontal: size.iScreen(1.0)),

                              //               // color: Colors.red,
                              //               child: Column(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.start,
                              //                 children: [
                              //                   Container(
                              //                     width: size.wScreen(100.0),
                              //                     child: Text(
                              //                       'Chat Comunitario',
                              //                       // textAlign: TextAlign.center,
                              //                       style: GoogleFonts.poppins(
                              //                         fontSize:
                              //                             size.iScreen(2.2),
                              //                         fontWeight:
                              //                             FontWeight.w700,
                              //                         color: octinaryColor,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   Container(
                              //                     decoration: BoxDecoration(
                              //                         color: Colors.white,
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 8.0)),
                              //                     padding: EdgeInsets.symmetric(
                              //                         horizontal:
                              //                             size.iScreen(1.0),
                              //                         vertical:
                              //                             size.iScreen(1.0)),
                              //                     width: size.wScreen(100.0),
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceAround,
                              //                       children: [
                              //                         Container(
                              //                           //  color: Colors.blue,
                              //                           width:
                              //                               size.wScreen(70.0),
                              //                           child: Text(
                              //                             'Interactúa con tus vecinos e informa a tu comunidad temas relevantes.',
                              //                             // textAlign: TextAlign.center,
                              //                             style: GoogleFonts
                              //                                 .poppins(
                              //                               fontSize: size
                              //                                   .iScreen(1.7),
                              //                               fontWeight:
                              //                                   FontWeight.w700,
                              //                               color:
                              //                                   octinaryColor,
                              //                               letterSpacing:
                              //                                   -0.28,
                              //                             ),
                              //                           ),
                              //                         ),
                              //                         GestureDetector(
                              //                           onTap: () async {
                              //                             final serviceSocket =
                              //                                 context.read<
                              //                                     SocketService>();
                              //                             // final _ctrlChat =
                              //                             //     context.read<
                              //                             //         ChatController>();

                              //                             // serviceSocket.emitEvent( 'client:lista-usuarios', {"chat_id": 4} );
                              //                             serviceSocket.emitEvent(
                              //                                 'client:lista-chats-grupos',
                              //                                 {});

                              //                             // _chatCtrl.buscaGruposChat(context);
                              //                             //      final infoUser  = await Auth.instance.getSession();
                              //                             // _ctrlChat
                              //                             //     .buscaGruposChat(
                              //                             //         context);

                              //                             Navigator.push(
                              //                                 context,
                              //                                 MaterialPageRoute(
                              //                                     builder:
                              //                                         ((context) =>
                              //                                             ListaGruposChat(
                              //                                               users:
                              //                                                   widget.user!,
                              //                                             ))));
                              //                             //             .then((value) {
                              //                             //               serviceSocket.emitEvent(
                              //                             // 'client:lista-chats-grupos',
                              //                             // {}

                              //                             // );
                              //                             //             });
                              //                           },
                              //                           child:

                              //                               // Container(
                              //                               //   // color: Colors.yellow,
                              //                               //   width:
                              //                               //       size.wScreen(20.0),
                              //                               //   child: Image.asset(
                              //                               //     'assets/imgs/chat-bubble.png',
                              //                               //     // scale: 1.5,
                              //                               //     // fit: BoxFit.,
                              //                               //     // width: size.1Screen(5.0), // URL de la imagen
                              //                               //   ),
                              //                               // ),
                              //                               Consumer<
                              //                                   SocketService>(
                              //                             builder: (_,
                              //                                 valueMsgNoRead,
                              //                                 __) {
                              //                               return valueMsgNoRead
                              //                                           .getMsgNoLeidos >
                              //                                       0
                              //                                   ? Badge(
                              //                                       position: const BadgePosition(
                              //                                           top:
                              //                                               -3.0,
                              //                                           start:
                              //                                               45.0),
                              //                                       badgeContent:
                              //                                           Text(
                              //                                         '${valueMsgNoRead.getMsgNoLeidos}',
                              //                                         style: GoogleFonts
                              //                                             .poppins(
                              //                                           fontSize:
                              //                                               size.iScreen(1.4),
                              //                                           fontWeight:
                              //                                               FontWeight.normal,
                              //                                           color: Colors
                              //                                               .white,
                              //                                         ),
                              //                                       ),
                              //                                       badgeColor:
                              //                                           tercearyColor,
                              //                                       child:
                              //                                           Container(
                              //                                         // color: Colors.yellow,
                              //                                         width: size
                              //                                             .wScreen(
                              //                                                 20.0),
                              //                                         child: Image
                              //                                             .asset(
                              //                                           'assets/imgs/chat-bubble.png',
                              //                                           // scale: 1.5,
                              //                                           // fit: BoxFit.,
                              //                                           // width: size.1Screen(5.0), // URL de la imagen
                              //                                         ),
                              //                                       ),
                              //                                     )
                              //                                   : SizedBox(
                              //                                       width: size
                              //                                           .wScreen(
                              //                                               20.0),
                              //                                       child: Image
                              //                                           .asset(
                              //                                         'assets/imgs/chat-bubble.png',
                              //                                       ),
                              //                                     );
                              //                             },
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             )
                              //           : Container(),
                              //       Expanded(
                              //         child: Container(
                              //           width: size.wScreen(100.0),
                              //           padding: EdgeInsets.symmetric(
                              //               horizontal: size.iScreen(1.0)),

                              //           // height: size.wScreen(40.0),

                              //           // color: Colors.red,
                              //           // color: Colors.red,
                              //           child: Column(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //             children: [
                              //               // Center(
                              //               //         child: Consumer<HomeController>(
                              //               //           builder: (context, permissionsProvider, child) {
                              //               //             return Column(
                              //               //               mainAxisAlignment: MainAxisAlignment.center,
                              //               //               children: <Widget>[
                              //               //                 Text('Estado del permiso de ubicación:'),
                              //               //                 // _buildPermissionStatus(permissionsProvider.locationPermissionStatus.),
                              //               //                 ElevatedButton(
                              //               //                   onPressed: () async {
                              //               //                     await permissionsProvider.checkLocationPermission();
                              //               //                   },
                              //               //                   child: Text('Verificar Permiso'),
                              //               //                 ),
                              //               //                 ElevatedButton(
                              //               //                   onPressed: () async {
                              //               //                     await permissionsProvider.requestLocationPermission();
                              //               //                   },
                              //               //                   child: Text('Solicitar Permiso'),
                              //               //                 ),
                              //               //               ],
                              //               //             );
                              //               //           },
                              //               //         ),
                              //               //       ),

                              //               Container(
                              //                 width: size.wScreen(100.0),
                              //                 child: Text(
                              //                   'Noticias para ti',
                              //                   // textAlign: TextAlign.center,
                              //                   style: GoogleFonts.poppins(
                              //                     fontSize: size.iScreen(2.2),
                              //                     fontWeight: FontWeight.w700,
                              //                     color: octinaryColor,
                              //                   ),
                              //                 ),
                              //               ),

                              //               //***********************************************/

                              //               SizedBox(
                              //                 height: size.iScreen(1.5),
                              //               ),
                              //               //*****************************************/
                              //               Expanded(
                              //                 child: Container(
                              //                   decoration: BoxDecoration(
                              //                       color: Colors.white,
                              //                       borderRadius:
                              //                           BorderRadius.circular(
                              //                               8.0)),
                              //                   padding: EdgeInsets.symmetric(
                              //                       horizontal:
                              //                           size.iScreen(1.0),
                              //                       vertical:
                              //                           size.iScreen(1.0)),
                              //                   margin: EdgeInsets.only(
                              //                     bottom: size.iScreen(1.0),
                              //                   ),
                              //                   width: size.wScreen(100.0),
                              //                   child: Container(
                              //                     // color: Colors.red,
                              //                     // width: size.wScreen(95.0),
                              //                     // height: size.iScreen(2),
                              //                     child:
                              //                         Consumer<HomeController>(
                              //                       builder:
                              //                           (_, valueNoticias, __) {
                              //                         return valueNoticias
                              //                                 .getListaTodasLasNoticias
                              //                                 .isNotEmpty
                              //                             ? CarouselSlider(
                              //                                 options:
                              //                                     CarouselOptions(
                              //                                   // height: 200.0,
                              //                                   autoPlay: true,
                              //                                   aspectRatio:
                              //                                       16 / 9,
                              //                                   enlargeCenterPage:
                              //                                       true,
                              //                                 ),
                              //                                 items: valueNoticias
                              //                                     .getListaTodasLasNoticias
                              //                                     .map((info) {
                              //                                   return Builder(builder:
                              //                                       (BuildContext
                              //                                           context) {
                              //                                     return Container(
                              //                                         width: size.wScreen(
                              //                                             100),
                              //                                         margin: EdgeInsets.symmetric(
                              //                                             horizontal:
                              //                                                 1.0),
                              //                                         padding: EdgeInsets.symmetric(
                              //                                             horizontal: size.iScreen(
                              //                                                 0.0)),
                              //                                         decoration:
                              //                                             BoxDecoration(
                              //                                                 // color: Colors.yellow.shade50,
                              //                                                 ),
                              //                                         child: info['noti_tipo_servicio'] ==
                              //                                                 'HOGAR'
                              //                                             ? Container(
                              //                                                 padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.0), vertical: size.iScreen(0.0)),
                              //                                                 decoration: BoxDecoration(
                              //                                                   borderRadius: BorderRadius.circular(8.0),
                              //                                                   color: Colors.grey.shade100,
                              //                                                 ),
                              //                                                 child:
                              //                                                     //     Column(
                              //                                                     //   children: [
                              //                                                     //     // Text(
                              //                                                     //     //   '${info['noti_titulo']}',
                              //                                                     //     //   style: GoogleFonts.poppins(
                              //                                                     //     //     fontSize: size.iScreen(2.0),
                              //                                                     //     //     fontWeight: FontWeight.w700,
                              //                                                     //     //     color: octinaryColor,
                              //                                                     //     //   ),
                              //                                                     //     // ),

                              //                                                     //     Container(
                              //                                                     //       width: size.iScreen(100),
                              //                                                     //       height: size.hScreen(22),
                              //                                                     //       child: CachedNetworkImage(
                              //                                                     //         imageUrl: info['noti_foto'],
                              //                                                     //         fit: BoxFit.fill,
                              //                                                     //         placeholder: (context, url) => const CupertinoActivityIndicator(),
                              //                                                     //         // Image.asset(
                              //                                                     //         //     'assets/imgs/loader.gif'),

                              //                                                     //         errorWidget: (context, url, error) => const Icon(Icons.error),
                              //                                                     //       ),
                              //                                                     //     ),
                              //                                                     //     //  Text(
                              //                                                     //     //   '${info['noti_descripcion']}',
                              //                                                     //     //   textAlign: TextAlign.center,
                              //                                                     //     //   style: GoogleFonts.poppins(
                              //                                                     //     //     fontSize: size.iScreen(1.7),
                              //                                                     //     //     fontWeight: FontWeight.normal,
                              //                                                     //     //     color: octinaryColor,
                              //                                                     //     //   ),
                              //                                                     //     // ),
                              //                                                     //   ],
                              //                                                     // ),
                              //                                                     InkWell(
                              //                                                   onTap: () {
                              //                                                     Navigator.push(context, MaterialPageRoute(builder: ((context) => InfoPublicidad(infoPublicidad: info))));
                              //                                                   },
                              //                                                   child: ClipRRect(
                              //                                                     borderRadius: BorderRadius.circular(8.0),
                              //                                                     child: Container(
                              //                                                       width: size.iScreen(100),
                              //                                                       height: size.hScreen(22),
                              //                                                       child: CachedNetworkImage(
                              //                                                         imageUrl: info['noti_foto'],
                              //                                                         fit: BoxFit.fill,
                              //                                                         placeholder: (context, url) => const CupertinoActivityIndicator(),
                              //                                                         // Image.asset(
                              //                                                         //     'assets/imgs/loader.gif'),

                              //                                                         errorWidget: (context, url, error) => const Icon(Icons.error),
                              //                                                       ),
                              //                                                     ),
                              //                                                   ),
                              //                                                 ),
                              //                                               )
                              //                                             : CachedNetworkImage(
                              //                                                 imageUrl: info['url'],
                              //                                                 fit: BoxFit.cover,
                              //                                                 placeholder: (context, url) => const CupertinoActivityIndicator(),
                              //                                                 // Image.asset(
                              //                                                 //     'assets/imgs/loader.gif'),

                              //                                                 errorWidget: (context, url, error) => const Icon(Icons.error),
                              //                                               ));
                              //                                   });
                              //                                 }).toList(),
                              //                               )
                              //                             : NoData(
                              //                                 label:
                              //                                     'No hay noticias nuevas');
                              //                       },
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
                          )),
                        ],
                      )
                    : const NoData(label: 'No tiene conexión...'),
              ),
              //           floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     // Muestra el Drawer al presionar el botón
              //     _scaffoldKey.currentState?.openDrawer();
              //   },
              //   child: Icon(Icons.menu),
              // ),
            ),
          ),
        );
        // :Scaffold(body: Container(

        //   height: size.hScreen(100),
        //   width: size.wScreen(100),
        //   child: NoSession(label: 'Su sessión ha expirado ')),);

//*******  ERROR DEL SOCKET ALERT  ************//
      },
    );
  }
 


                                               


Future<void> _showSuccessDialog(BuildContext context, String info) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
          content: Text('$info'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
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

class BannerChat extends StatelessWidget {
  const BannerChat({
    Key? key,
    required this.size,
    required this.widget,
  }) : super(key: key);

  final Responsive size;
  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        // borderRadius:
        //     BorderRadius.circular(
        //         8.0)
      ),
      padding: EdgeInsets.symmetric(
          horizontal: size.iScreen(0.5), vertical: size.iScreen(0.5)),
      width: size.wScreen(100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              final serviceSocket = context.read<SocketService>();
              // final _ctrlChat =
              //     context.read<
              //         ChatController>();

              // serviceSocket.emitEvent( 'client:lista-usuarios', {"chat_id": 4} );
              serviceSocket.emitEvent('client:lista-chats-grupos', {});

              // _chatCtrl.buscaGruposChat(context);
              //      final infoUser  = await Auth.instance.getSession();
              // _ctrlChat
              //     .buscaGruposChat(
              //         context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ListaGruposChat(
                            users: widget.user!,
                          ))));
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
                Consumer<SocketService>(
              builder: (_, valueMsgNoRead, __) {
                return valueMsgNoRead.getMsgNoLeidos > 0
                    ? Badge(
                        position: const BadgePosition(top: -3.0, start: 45.0),
                        badgeContent: Text(
                          '${valueMsgNoRead.getMsgNoLeidos}',
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.4),
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        badgeColor: tercearyColor,
                        child: Container(
                            // color: Colors.yellow,
                            width: size.wScreen(12.0),
                            child: Icon(
                              FontAwesomeIcons.comments,
                              color: Colors.green,
                              size: size.iScreen(4.0),
                            )
                            //  Image
                            //     .asset(
                            //   'assets/imgs/chat-bubble.png',
                            //   // scale: 1.5,
                            //   // fit: BoxFit.,
                            //   // width: size.1Screen(5.0), // URL de la imagen
                            // ),
                            ),
                      )
                    : Container(
                        // color: Colors.yellow,
                        width: size.wScreen(12.0),
                        child: Icon(
                          FontAwesomeIcons.comments,
                          color: Colors.green,
                          size: size.iScreen(5.0),
                        )
                        // Image
                        //     .asset(
                        //   'assets/imgs/chat-bubble.png',
                        // ),
                        );
              },
            ),
          ),
          Container(
            color: Colors.grey,
            height: size.iScreen(7.0),
            width: size.iScreen(0.3),
          ),
          Container(
            //  color: Colors.blue,
            width: size.wScreen(70.0),
            child: Column(
              children: [
                Container(
                  width: size.wScreen(100.0),
                  child: Text(
                    'Chat comunitario',
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.iScreen(2.2),
                      fontWeight: FontWeight.normal,
                      // color:
                      //     Color,
                      letterSpacing: -0.28,
                    ),
                  ),
                ),
                Text(
                  'Interactúa con tus vecinos e informa a tu comunidad temas relevantes.',
                  // textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: size.iScreen(1.6),
                    fontWeight: FontWeight.normal,
                    // color:
                    //     octinaryColor,
                    // letterSpacing:
                    //     -0.28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BannerEstadoDeCuenta extends StatelessWidget {
  const BannerEstadoDeCuenta({
    Key? key,
    required this.size,
    required this.widget,
  }) : super(key: key);

  final Responsive size;
  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        // borderRadius:
        //     BorderRadius.circular(
        //         8.0)
      ),
      padding: EdgeInsets.symmetric(
          horizontal: size.iScreen(0.5), vertical: size.iScreen(0.5)),
      width: size.wScreen(100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                final valueHome = context.read<HomeController>();

                valueHome.buscaEstadoDeCuenta(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const DataTableEstadoCuenta())));
              },
              child: Container(
                  // color: Colors.yellow,
                  width: size.wScreen(12.0),
                  child: Icon(
                    Icons.description_outlined,
                    color: Colors.orange,
                    size: size.iScreen(5.0),
                  ))),
          Container(
            color: Colors.grey,
            height: size.iScreen(7.0),
            width: size.iScreen(0.3),
          ),
          Container(
            //  color: Colors.blue,
            width: size.wScreen(70.0),
            child: Column(
              children: [
                Container(
                  width: size.wScreen(100.0),
                  child: Text(
                    'Estado de cuenta',
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.iScreen(2.2),
                      fontWeight: FontWeight.normal,
                      // color:
                      //     Color,
                      letterSpacing: -0.28,
                    ),
                  ),
                ),
                Container(
                  width: size.wScreen(100.0),
                  child: Text(
                    'Verifica tu estado de cuenta.',
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.iScreen(1.6),
                      fontWeight: FontWeight.normal,
                      // color:
                      //     octinaryColor,
                      // letterSpacing:
                      //     -0.28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
