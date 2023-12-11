
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/controllers/init_provider.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/pages/lista_grupos_chat.dart';
import 'package:ultrared/src/pages/lista_notificaciones.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/pages/splash_screen.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //  setUpNotificationPlugins();

      initData();
    });
    super.initState();
  }

// ======================= OBSERVABLE  ==========================//

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final homeController = context.read<HomeController>();

    if (state == AppLifecycleState.resumed) {
      // await homeController.validaInicioDeSesion(context);
      print('EL ESTADO ES ------: $state');
      homeController.getLocation();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const SplashPage()));

//  final _isTurned=
// homeController.buscaNotificacionesPush('');
//       homeController.buscaNotificacionesPush2('');
      // homeController.setGetTestTurno(null);
      // homeController.getValidaTurnoServer();

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
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);

    var ctrlHome = context.read<HomeController>();

    user = await Auth.internal().getSession();
      ctrlHome.setUserApp(user);
    // print('${user!['nombre']}');

    // final  socketManager = context.read<SocketService>();
    // if (socketManager.status == SocketStatus.desconectado) {
    //   socketManager.conectar();
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {





    // final List<String> imageUrls = [
    //   'https://www.recetasnestle.com.mx/sites/default/files/inline-images/comidas-fritas-plato-apanado-ensalada.jpg',

    //   // Agrega más URLs según sea necesario
    // ];

    // final List<Map<String, dynamic>> _listaInfoPublicidad = [
    //   {
    //     "tipo": 'promociones',
    //     "url":
    //         'https://www.recetasnestle.com.mx/sites/default/files/inline-images/comidas-fritas-plato-apanado-ensalada.jpg',
    //     "titulo": 'Promocioes',
    //     "descripcion": 'El tituloLa Descripcion',
    //   },

    //   {
    //     "tipo": 'comunicado',
    //     "url": '',
    //     "titulo": 'Reunión de la Comunidad',
    //     "descripcion":
    //         'Se realizara en la casa comunal a las 17:hoo para tratar temas relacionados con la vialidad',
    //   },
    //   {
    //     "tipo": 'publicidad',
    //     "url":
    //         'https://www.recetasnestle.com.mx/sites/default/files/inline-images/comidas-fritas-plato-apanado-ensalada.jpg',
    //     "titulo": 'Publicidad',
    //     "descripcion": 'La Descripcion de la publicidad',
    //   },

    //   // Agrega más URLs según sea necesario
    // ];

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
                child: Image.asset(
                  'assets/imgs/LetrasNegro.png',
                  scale: 1.0,
                  // fit: BoxFit.,
                  // width: size.1Screen(5.0), // URL de la imagen
                ),
              ),  
              actions: [
                values.connectionStatus != ConnectionStatus.none
                    ? Badge(
                        position: const BadgePosition(top: 10.0, start: 25.0),
                        badgeContent: Text(
                          '9+',
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

context.read<HomeController>().buscarNotificaciones(context);

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
                      )
                    : Container()
              ],
            ),
            drawer: values.connectionStatus != ConnectionStatus.none
                ? DrawerMenu(user: user)
                : null,
            body: SingleChildScrollView(
              child: Container(
                height: size.hScreen(100),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElementosHome(
                                              enabled: true,
                                              size: size,
                                              image: 'assets/imgs/document.png',
                                              title: 'Estado de Cuenta',
                                              label:
                                                  'Verifica tu estado de cuenta',
                                              onTap: () {}
                                              // () => Navigator.pushNamed(
                                              //     context, 'SubmenuMascotas'),
                                              // onTap: () {
                                              //   Navigator.of(context).push(MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           const SubmenuMascotas()));
                                              // },
                                              ),
                                          ElementosSOS(
                                              enabled: true,
                                              size: size,
                                              image: 'assets/imgs/document.png',
                                              title: 'Botón de Ayuda',
                                              label: 'Presiona por 3 segundos',
                                              onTap: () {}
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
                                  Container(
                                    width: size.wScreen(100.0),
                                    height: size.wScreen(40.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.iScreen(1.0)),
            
                                    // color: Colors.red,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                                onTap: ()  async{
            
            
            
         
                                                  final serviceSocket = context.read<SocketModel>();
            
            
            
            
                                                  // serviceSocket.emitEvent( 'client:lista-usuarios', {"chat_id": 4} );
                                                  // // serviceSocket.emitEvent( 'client:lista-chats-grupos', {} );
             
            
                                                
                                                  // _chatCtrl.buscaGruposChat(context);
                                                  //      final infoUser  = await Auth.instance.getSession();
             
            
            
            
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
                                  ),
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
                                            child: 
                                            
                                            Container(
                                              // color: Colors.yellow,
                                              width: size.wScreen(95.0),
                                              child:
            

                                                    Consumer <HomeController> (builder: ( _, valueNoticias,__) { 
return 


valueNoticias.getListaTodasLasNoticias.isNotEmpty?


CarouselSlider(
                                                options: CarouselOptions(
                                                  // height: 200.0,
                                                  autoPlay: true,
                                                  aspectRatio: 16 / 9,
                                                  enlargeCenterPage: true,
                                                ),
                                                items: valueNoticias.getListaTodasLasNoticias
                                                    .map((info) {
                                                  return Builder(builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                        width: size.wScreen(100),
                                                        margin:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 1.0),
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal:
                                                                    size.iScreen(
                                                                        0.0)),
                                                        decoration: BoxDecoration(
                                                            // color: Colors.yellow.shade50,
                                                            ),
                                                        child: info['noti_tipo_servicio'] ==
                                                                'HOGAR'
                                                            ? Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: size
                                                                        .iScreen(
                                                                            1.0),
                                                                    vertical: size
                                                                        .iScreen(
                                                                            1.0)),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  color: Colors
                                                                      .yellow
                                                                      .shade100,
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      '${info['noti_titulo']}',
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            size.iScreen(
                                                                                2.0),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color:
                                                                            octinaryColor,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${info['noti_descripcion']}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            size.iScreen(
                                                                                1.7),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        color:
                                                                            octinaryColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : CachedNetworkImage(
                                                                imageUrl:
                                                                    info['url'],
                                                                fit: BoxFit.cover,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const CupertinoActivityIndicator(),
                                                                // Image.asset(
                                                                //     'assets/imgs/loader.gif'),
            
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                              ));
                                                  });
                                                }).toList(),
                                              ):NoData(label: 'No hay noticias nuevas');
                                           

                                                     },),
                                                  
                                           
                                           
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
          ),
        );
      },
    );
  }
}
