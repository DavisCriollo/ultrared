import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/no_data.dart';
import 'package:latlong2/latlong.dart' as latlng; // Nota: latlong2 es la versión más reciente del paquete

class AuxilioPage extends StatefulWidget {
  const AuxilioPage({Key? key}) : super(key: key);

  @override
  State<AuxilioPage> createState() => _AuxilioPageState();
}

class _AuxilioPageState extends State<AuxilioPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final loadInfo = context.read<ChatController>();

    // final serviceSocket = context.read<SocketService>();
    // loadInfo.buscaGestionDocumental('', 'ENVIADO');

    // serviceSocket.socket!.on('server:lista-chats-grupos', (data) async {
    //   print('LA TABLA GESTION  EXITO >>>>>>>> ${data}');

    //   // if (data['tabla'] == 'acta_entrega_recepcion') {
    //   //   // loadInfo.buscaGestionDocumental('', 'ENVIADO');
    //   //   // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   // }
    // });
    // serviceSocket.socket!.on('server:actualizadoExitoso', (data) async {
    //   // print('LA TABLA GESTION  ACTUALIZA >>>>>>>> ${data}');
    //   // if (data['tabla'] == 'acta_entrega_recepcion') {
    //   //   // loadInfo.buscaGestionDocumental('', 'ENVIADO');
    //   //   // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   // }
    // });
    // serviceSocket.socket!.on('server:eliminadoExitoso', (data) async {
    //   // print('LA TABLA GESTION  ELIMINA >>>>>>>> ${data}');
    // if (data['tabla'] == 'acta_entrega_recepcion') {
    //   // loadInfo.buscaGestionDocumental('', 'ENVIADO');
    //   // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrhome = context.read<HomeController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text('AUXILIO',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
        ),
        body: Container(
            // alignment: Alignment.center,
            // color: Colors.red,

            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            child: Consumer<SocketModel>(
              builder: (_, valueChat, __) {
                return Column(
                  children: [
                        Container(
                   
                      padding: EdgeInsets.symmetric(
                          horizontal: size.iScreen(1.0),
                          vertical: size.iScreen(1.0)),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      )),
                      // color:Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: size.iScreen(9.0),
                              height: size.iScreen(9.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.grey, width: 2.0),
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${ctrhome.getUser!['foto']}', // Reemplaza con la URL de tu imagen
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Container(
                            // color: Colors.green,
                            width: size.wScreen(60.0),
                            child: Column(
                              // mainAxisAlignment:MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Juan Perez   ',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(2.2),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      letterSpacing: -0.20,
                                      
                                    )),
                                Text('0987654321',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      letterSpacing: -0.20,
                                    )),
                                Text('Se encuentra en peligro',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.8),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                      letterSpacing: -0.40,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width:  size.wScreen(100),
                        child: FlutterMap(
                          options: MapOptions(
                            center: latlng.LatLng(-0.27105192324533584, -79.14019002882391), // Coordenadas de San Francisco
                            zoom: 12.0,
                          ),
                          layers: [
                            TileLayerOptions(
                              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayerOptions(
                              markers: [
                                Marker(
                                  width: 40.0,
                                  height: 40.0,
                                  point: latlng.LatLng(-0.27105192324533584, -79.14019002882391),
                                  builder: (ctx) => Container(
                        child: Icon(Icons.location_on,color:  tercearyColor,size:  size.iScreen(4.0),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
                
    //             Column(
    //               children: [
    //                 Container(
                   
    //                   padding: EdgeInsets.symmetric(
    //                       horizontal: size.iScreen(1.0),
    //                       vertical: size.iScreen(1.0)),
    //                   decoration: const BoxDecoration(
    //                       border: Border(
    //                     bottom: BorderSide(
    //                       color: Colors.grey,
    //                       width: 1.0,
    //                     ),
    //                   )),
    //                   // color:Colors.red,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Container(
    //                           width: size.iScreen(9.0),
    //                           height: size.iScreen(9.0),
    //                           decoration: BoxDecoration(
    //                             shape: BoxShape.circle,
    //                             border: Border.all(
    //                                 color: Colors.grey, width: 2.0),
    //                           ),
    //                           child: ClipOval(
    //                             child: CachedNetworkImage(
    //                               imageUrl:
    //                                   '${ctrhome.getUser!['foto']}', // Reemplaza con la URL de tu imagen
    //                               placeholder: (context, url) =>
    //                                   const CircularProgressIndicator(),
    //                               errorWidget: (context, url, error) =>
    //                                   Icon(Icons.error),
    //                               fit: BoxFit.cover,
    //                             ),
    //                           )),
    //                       Container(
    //                         // color: Colors.green,
    //                         width: size.wScreen(60.0),
    //                         child: Column(
    //                           // mainAxisAlignment:MainAxisAlignment.start,
    //                           // crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text('Juan Perez   ',
    //                                 style: GoogleFonts.poppins(
    //                                   fontSize: size.iScreen(2.2),
    //                                   fontWeight: FontWeight.w500,
    //                                   color: Colors.black,
    //                                   letterSpacing: -0.20,
                                      
    //                                 )),
    //                             Text('0987654321',
    //                                 style: GoogleFonts.poppins(
    //                                   fontSize: size.iScreen(1.8),
    //                                   fontWeight: FontWeight.normal,
    //                                   color: Colors.black,
    //                                   letterSpacing: -0.20,
    //                                 )),
    //                             Text('Se encuentra en peligro',
    //                                 style: GoogleFonts.poppins(
    //                                   fontSize: size.iScreen(1.8),
    //                                   fontWeight: FontWeight.normal,
    //                                   color: Colors.grey,
    //                                   letterSpacing: -0.40,
    //                                 )),
    //                           ],
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: Container(
    //                     //  color :Colors.red,
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.max,
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         Container(
    //                           // width: size.wScreen(100),
    //                           // height: size.hScreen(60),
    //                           // color :Colors.red,
    //                           child: FlutterMap(
    //   options: MapOptions(
    //     center: latlng.LatLng(37.7749, -122.4194), // Coordenadas de San Francisco
    //     zoom: 12.0,
    //   ),
    //   layers: [
    //     TileLayerOptions(
    //       urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    //       subdomains: ['a', 'b', 'c'],
    //     ),
    //     MarkerLayerOptions(
    //       markers: [
    //         Marker(
    //           width: 40.0,
    //           height: 40.0,
    //           point: latlng.LatLng(37.7749, -122.4194),
    //           builder: (ctx) => Container(
    //             child: FlutterLogo(),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // )
    //                         ),
                           
    //                       ],
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             );
              
              
              
              },
            )),
      ),
    );
  }
}
