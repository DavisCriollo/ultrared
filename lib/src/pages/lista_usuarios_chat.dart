import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/no_data.dart';

class ListaUsuariosChat extends StatefulWidget {
  final Map<String, dynamic> infoGrupo;
  const ListaUsuariosChat({Key? key, required this.infoGrupo})
      : super(key: key);

  @override
  State<ListaUsuariosChat> createState() => _ListaUsuariosChatState();
}

class _ListaUsuariosChatState extends State<ListaUsuariosChat> {
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
    //   // if (data['tabla'] == 'acta_entrega_recepcion') {
    //   //   // loadInfo.buscaGestionDocumental('', 'ENVIADO');
    //   //   // NotificatiosnService.showSnackBarSuccsses(data['msg']);
    //   // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final user = Auth.internal().getSession();
    final _crtl = context.read<SocketModel>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text("${widget.infoGrupo['chat_name']}",
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
        ),
        body: Stack(
          children: [
            Container(
              // alignment: Alignment.center,
              // color: Colors.red,

              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child: Consumer<SocketModel>(
                builder: (context, socketUsuarios, child) {
                  if (socketUsuarios.getListaUsuariosChat.isEmpty) {
                    return Center(
                      // child: CircularProgressIndicator(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Esperando Datos...',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.5),
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          //***********************************************/
                          SizedBox(
                            height: size.iScreen(1.0),
                          ),
                          //*****************************************/
                          const CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: socketUsuarios.getListaUsuariosChat.length,
                    itemBuilder: (context, index) {
                      final _usuario =
                          socketUsuarios.getListaUsuariosChat[index];
                      return Column(
                        children: [
                          ListTile(
                            dense: true,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                alignment: Alignment.center,
                                width: size.iScreen(5.0),
                                height: size.iScreen(5.0),
                                // decoration:  BoxDecoration(borderRadius: BorderRadius.circular(100),
                                // color:  Colors.red
                                // ),
                                child:
                                    // Image.asset(
                                    //                 'assets/imgs/Avatar.png',
                                    //                 // scale: 1.5,
                                    //                 fit: BoxFit.contain,
                                    //                 width: size.iScreen(5.0),
                                    //                 scale: 1.0, // URL de la imagen
                                    //               ),
                                    // CachedNetworkImage(
                                    //                               imageUrl: 'https://www.recetasnestle.com.mx/sites/default/files/inline-images/comidas-fritas-plato-apanado-ensalada.jpg',
                                    //                               fit: BoxFit.contain,
                                    //                               placeholder: (context,
                                    //                                       url) =>
                                    //                                   const CupertinoActivityIndicator(),
                                    //                               // Image.asset(
                                    //                               //     'assets/imgs/loader.gif'),

                                    //                               errorWidget: (context, url,
                                    //                                       error) =>
                                    //                                   const Icon(Icons.error),
                                    //
                                    //                ),

                                    _usuario!['foto'].isNotEmpty
                                        ? Container(
                                            width: size.iScreen(9.0),
                                            height: size.iScreen(9.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2.0),
                                            ),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${_usuario!['foto']}', // Reemplaza con la URL de tu imagen
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                        : ClipOval(
                                            child: Image.asset(
                                              'assets/imgs/no-image.png', // Reemplaza con la ruta de tu imagen en los activos
                                              width: size.iScreen(7.5),
                                              height: size.iScreen(7.5),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            ),
                            title: Text('${_usuario['nombres']}',
                                style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  letterSpacing: -0.40,
                                )),
                            subtitle: 
                                  Text(
                            _usuario['perOnline'] == 1
                                  ?  'Disponible':'No Disponible', style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.5),
                                  fontWeight: FontWeight.normal,
                                  color: _usuario['perOnline'] == 1
                                  ?  Colors.green:Colors.black,
                                  letterSpacing: -0.40,
                                ),
                                  
                            ),
                            onTap: () {
                              // Acción al hacer clic en el ListTile
                              print('Clic en el ListTile $index');
                            },
                            trailing: Text('11:35',
                                style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.6),
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  // letterSpacing: -0.40,
                                )),
                          ),
                          Divider()
                        ],
                      );
                    },
                  );
                },
              ),
              //           Consumer<ChatController>(builder: (_, valueUsuarios, __) {
              //              if (valueUsuarios.getErrorUsuariosChat == null) {
              //             return Center(
              //               // child: CircularProgressIndicator(),
              //               child: Column(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   Text(
              //                     'Cargando Datos...',
              //                     style: GoogleFonts.lexendDeca(
              //                         fontSize: size.iScreen(1.5),
              //                         color: Colors.black87,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   //***********************************************/
              //                   SizedBox(
              //                     height: size.iScreen(1.0),
              //                   ),
              //                   //*****************************************/
              //                   const CircularProgressIndicator(),
              //                 ],
              //               ),
              //             );
              //           } else if (valueUsuarios.getErrorUsuariosChat == false) {
              //             return const NoData(
              //               label: 'No existen datos para mostar',
              //             );
              //             // Text("Error al cargar los datos");
              //           } else if (valueUsuarios.getListaTodosLosUsuariosChat.isEmpty) {
              //             return const NoData(
              //               label: 'No existen datos para mostar',
              //             );
              //           }
              //             return  ListView.builder(
              //             shrinkWrap:true ,
              //       itemCount: valueUsuarios.getListaTodosLosUsuariosChat.length,
              //       itemBuilder: (context, index) {
              //         final _usuario=valueUsuarios.getListaTodosLosUsuariosChat[index];
              //         return
              //         Column(
              //           children: [
              //             ListTile(
              //               dense: true,
              //               leading: ClipRRect(
              //                 borderRadius: BorderRadius.circular(100),
              //                 child: Container(
              //                   alignment:  Alignment.center,
              //                   width: size.iScreen(5.0),
              //           height: size.iScreen(5.0),
              //                     // decoration:  BoxDecoration(borderRadius: BorderRadius.circular(100),
              //                     // color:  Colors.red
              //                     // ),
              //                   child:
              //                   // Image.asset(
              //                   //                 'assets/imgs/Avatar.png',
              //                   //                 // scale: 1.5,
              //                   //                 fit: BoxFit.contain,
              //                   //                 width: size.iScreen(5.0),
              //                   //                 scale: 1.0, // URL de la imagen
              //                   //               ),
              //                   // CachedNetworkImage(
              //                   //                               imageUrl: 'https://www.recetasnestle.com.mx/sites/default/files/inline-images/comidas-fritas-plato-apanado-ensalada.jpg',
              //                   //                               fit: BoxFit.contain,
              //                   //                               placeholder: (context,
              //                   //                                       url) =>
              //                   //                                   const CupertinoActivityIndicator(),
              //                   //                               // Image.asset(
              //                   //                               //     'assets/imgs/loader.gif'),

              //                   //                               errorWidget: (context, url,
              //                   //                                       error) =>
              //                   //                                   const Icon(Icons.error),
              //                   //
              //                   //                ),

              //                     _usuario!['foto'].isNotEmpty
              //               ? Container(
              //                   width: size.iScreen(9.0),
              //                   height: size.iScreen(9.0),
              //                   decoration: BoxDecoration(
              //                     shape: BoxShape.circle,
              //                     border: Border.all(color: Colors.blue, width: 2.0),
              //                   ),
              //                   child: ClipOval(
              //                     child: CachedNetworkImage(
              //                       imageUrl:
              //                           '${_usuario!['foto']}', // Reemplaza con la URL de tu imagen
              //                       placeholder: (context, url) =>
              //                           const CircularProgressIndicator(),
              //                       errorWidget: (context, url, error) =>
              //                           Icon(Icons.error),
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ))
              //               : ClipOval(
              //                   child: Image.asset(
              //                     'assets/imgs/no-image.png', // Reemplaza con la ruta de tu imagen en los activos
              //                     width: size.iScreen(7.5),
              //                     height: size.iScreen(7.5),
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 ),
              //               ),
              //               title: Text('${_usuario['nombres']}',
              //               style: GoogleFonts.poppins(
              //               fontSize: size.iScreen(1.8),
              //               fontWeight: FontWeight.normal,
              //               color: Colors.black,
              //               letterSpacing: -0.40,
              //             ) ),
              //               subtitle: Text(_usuario['perOnline']==1?'Disponible':'No Disponible',
              //               ),
              //               onTap: () {
              //                 // Acción al hacer clic en el ListTile
              //                 print('Clic en el ListTile $index');
              //               },
              //               trailing:  Text('11:35',style: GoogleFonts.poppins(
              //               fontSize: size.iScreen(1.6),
              //               fontWeight: FontWeight.normal,
              //               color: Colors.black,
              //               // letterSpacing: -0.40,
              //             )),
              //             ),
              //           Divider()
              //           ],
              //         );

              //       },
              // );
              //           },)
            ),
            Positioned(
              bottom: size.wScreen(2),
              right: size.wScreen(2.0),
              child: GestureDetector(
                onTap: () {
                  final _crtl = context.read<ChatController>();
                  final _crtlSocket = context.read<SocketModel>();

                  final _info = {
                    "opcion": "GROUP", // 'INDIVIDUAL' | 'GROUP'
                    "grupo": widget.infoGrupo,
                    "chat_id": widget.infoGrupo['chat_id'],
                    "idUsuario": user,
                    // tomar del grupo del chat
                  };
                  _crtl.buscaAllTodoLosChatPaginacion(
                      '', false, widget.infoGrupo['chat_id'],_crtlSocket);
                  for (var item in _crtl.getListaTodoLosChatPaginacion) {
                    _crtlSocket.setListaDeMensajesChat(item);
                  }
                    //  _crtlSocket.setListaDeMensajesChat(_info);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ChatPage(
                                infoChat: _info,
                              ))));
                },
                child: Container(
                  width: size.wScreen(25.0),
                  height: size.hScreen(6.0),
                  padding: EdgeInsets.all(size.iScreen(1.0)),
                  decoration: ShapeDecoration(
                    color: Color(0xFFB32623),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x33123B93),
                        blurRadius: 20,
                        offset: Offset(8, 8),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Ir al Chat',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: size.iScreen(1.5),
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        // letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
