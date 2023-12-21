import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class ListaGruposChat extends StatefulWidget {
  const ListaGruposChat({Key? key}) : super(key: key);

  @override
  State<ListaGruposChat> createState() => _ListaGruposChatState();
}

class _ListaGruposChatState extends State<ListaGruposChat> {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text('MIS GRUPOS',
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
               if (valueChat.getListaGruposChat==null) {
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
                } else  if (valueChat.getListaGruposChat.isEmpty) {
                  return const NoData(label: 'No tiene grupo asignado');
                }
                    return ListView.builder(
                  shrinkWrap: true,
                  itemCount: valueChat.getListaGruposChat.length,
                  itemBuilder: (context, index) {
                    final _grupo = valueChat.getListaGruposChat[index];
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                // color:  Colors.red,
                                // border: Border.all(color: Colors.blueAccent)
                              ),
                              child: Image.asset(
                                'assets/imgs/groups.png',
                                // scale: 1.5,
                                fit: BoxFit.contain,
                                width: size.iScreen(5.0),
                                scale: 1.0, // URL de la imagen
                              ),
                            
                            ),
                          ),
                          title: Text('${_grupo['chat_name']}',
                              style: GoogleFonts.poppins(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                letterSpacing: -0.40,
                              )),
                          subtitle: Text(
                            ' Disponible',
                          ),
                          onTap: () {
                            final _ctrl = context.read<ChatController>();
                            // _ctrl.buscaUsuariosChat(context, _grupo['chat_id']);



                            // final _ctrlSocket = Provider.of<SocketModel>(
                            //     context,
                            //     listen: false);

                            valueChat.emitEvent('client:lista-usuarios',  {"chat_id": _grupo['chat_id']});


                              //---------------------------------------------------------------// 
                               
                  final _crtlSocket = context.read<SocketModel>();
                  final _crtlHome = context.read<HomeController>();
                  final _crtl = context.read<ChatController>();

                  final _info = {
                    "opcion": "GROUP", // 'INDIVIDUAL' | 'GROUP'
                    "grupo": _grupo,
                    "chat_id": _grupo['chat_id'],
                    "idUsuario": _crtlHome.getUser,
                    // tomar del grupo del chat
                  };
                  _crtl.buscaAllTodoLosChatPaginacion(
                      '', false, _grupo['chat_id'],_crtlSocket);
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
              
                              //---------------------------------------------------------------// 






                            // _ctrl.setListaTodosLosUsuariosChat(_ctrlSocket.mensajeDesdeServidor);



                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: ((context) => ListaUsuariosChat(
                            //               infoGrupo: _grupo,
                            //             ))));
                            // Acción al hacer clic en el ListTile
                            // print('Clic en el ListTile $index');
                          },
                         
                          trailing: Icon(Icons.chevron_right_outlined),
                        ),
                        Divider()
                      ],
                    );
                  },
                );

            
              },
            )),
      ),
    );
  }
}
