import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/pages/chats.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/service/socket.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/no_data.dart';

class ListaGruposChat extends StatefulWidget {
final Map<String,dynamic> users ;

  
   const ListaGruposChat({Key? key, required this.users}) : super(key: key);

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
            child: Consumer<SocketService>(
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
                    return 
                    Consumer<SocketService>(builder: (_, valueGrupos, __) {  
                        return  ListView.builder(
                  shrinkWrap: true,
                  itemCount: valueGrupos.getListaGruposChat.length,
                  itemBuilder: (context, index) {
                    final _grupo = valueGrupos.getListaGruposChat[index];
                    return FadeInLeftBig(
                          duration: Duration(milliseconds: 400),

                      child: Column(
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
                             _grupo['active_persons']>0? 'Disponible':'No Disponible',style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.4),
                                  fontWeight: FontWeight.normal,
                                  color: _grupo['active_persons']>0? Colors.green:Colors.grey,
                                  letterSpacing: -0.40,
                                )
                            ),
                            onTap: () {
                      //         final _ctrl = context.read<ChatController>();
                             
                      //         valueChat.emitEvent('client:lista-usuarios',  {"chat_id": _grupo['chat_id']});
                    
                    
                      //           //---------------------------------------------------------------// 
                                 
                      //                 final _crtlSocket = context.read<SocketModel>();
                      //                 final _crtlHome = context.read<HomeController>();
                      //                 final _crtl = context.read<ChatController>();
                    
                      //                 final _info = {
                      // "opcion": "GROUP", // 'INDIVIDUAL' | 'GROUP'
                      // "grupo": _grupo,
                      // "chat_id": _grupo['chat_id'],
                      // "idUsuario": _crtlHome.getUser,
                      // // tomar del grupo del chat
                      //                 };
                      //                 _crtl.buscaAllTodoLosChatPaginacion(context,
                      //   '', false, _grupo['chat_id'],_crtlSocket);
                      //                 for (var item in _crtl.getListaTodoLosChatPaginacion) {
                      // _crtlSocket.setListaDeMensajesChat(item);
                      //                 }
                      // //  _crtlSocket.setListaDeMensajesChat(_info);
                      //                 Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: ((context) => ChatPage(
                      //             infoChat: _info,
                      //           ))));
                                  
                                //-----------------------------NUEVA FORMA DEL CHAT----------------------------------// 
                                final _crtlSocket = context.read<SocketService>();
                                      final _crtlHome = context.read<HomeController>();
                                      final _crtl = context.read<ChatController>();
                   
                                      final _info = {
                      "opcion": "GROUP", // 'INDIVIDUAL' | 'GROUP'
                      "grupo": _grupo,
                      "chat_id": _grupo['chat_id'],
                      "idUsuario": _crtlHome.getUser,
                      // tomar del grupo del chat
                                      };
// _crtlSocket.setMsgNoLeidos(0);
 _crtl.setInfoChat(_info);
   _crtl.buscaAllTodoLosChats(context,'', false, _grupo['chat_id'],valueGrupos);

_crtlSocket.setIsEnChat(true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Chats(
                              user: widget.users,
                                  // infoChat: _info,US
                                )))).then((value) {
                                  



//  final _ctrlChat =Provider.of<ChatController>(context, listen: false);
//       final _ctrlSocket =Provider.of<SocketModel>(context, listen: false);


 final _ctrlChat =context.read<ChatController>();
     final _ctrlSocket =context.read<SocketService>();

_ctrlSocket.setIsEnChat(false);
_ctrlSocket.setIsEnChat(false);
_ctrlChat.setPressed(false);
_ctrlChat.setDescargaOk(false);

    _ctrlChat.setPage(0);
    _ctrlChat.setCantidad(25);
  // _ctrlChat.deleteListChat();
  valueGrupos.deleteListChatSocket();
  valueGrupos.emitEvent(
                                                            'client:lista-chats-grupos',
                                                            {});
  //  valueGrupos.emitEvent(
  //                                                           'client:lista-chats-grupos',
  //                                                           {});
    // _ctrlChat.buscaAllTodoLosChats(context,'', false, _ctrlChat.getInfoChat['chat_id'],_ctrlSocket);



                                });
                                  
                    
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
                           
                            trailing: Container(
                              width: size.iScreen(7),
                              // color:Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                          //             Badge(
                          //                 position:
                          //       const BadgePosition(top: -3.0, start: 45.0),
                          //   badgeContent: 
                          //  Text(
                          
                          //     '1254',
                          //     style: GoogleFonts.poppins(
                          //       fontSize: size.iScreen(1.4),
                          //       fontWeight: FontWeight.normal,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                           
                          //   badgeColor: tercearyColor,
                          //             ),

                               _grupo['unread_messages']>0 ?   Container(
                                    //  width: size.iScreen(7),
                                    constraints:BoxConstraints(
                                      maxWidth:size.iScreen(4.0),
                                       minWidth:size.iScreen(2.0)
                                    ),
                                    // width: size.iScreen(2.0),
                                    
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),  color:Colors.red,),
                                    padding:EdgeInsets.symmetric(vertical:size.iScreen(0.0),horizontal: size.iScreen(0.4)),
                            child:
                                  //  Text('${_grupo['unread_messages']}',
                                  Text(_grupo['unread_messages']<99?'${_grupo['unread_messages']}':'+ 100',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: size.iScreen(1.3),
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                
                              ),
                            )
                                   ,):Container(),
                                  Icon(Icons.chevron_right_outlined),
                                ],
                              )),
                          ),
                          Divider()
                        ],
                      ),
                    );
                  },
                );

                    },);
                    
                   
            
              },
            )),
      ),
    );
  }
}
