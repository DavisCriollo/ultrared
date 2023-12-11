import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/message.dart';

class ChatPage extends StatefulWidget {
    final Map<String,dynamic> infoChat;
  const ChatPage({Key? key, required this.infoChat}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
    Map<String, dynamic>? user = {};
    final _scrollController = ScrollController();
  
  // bool showScrollToTopButton = false;
   
  @override
  void initState() {
   
  _scrollController.addListener(() {

      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //  print('ESTAMOS EN EL FINAL DE LA PANTALLA');
        // _loadListScroll.getpage;
        // _loadListScroll.setPage(_loadListScroll.getpage);
        //  _loadListScroll.buscaAllPropietariosPaginacion('');

        final _next = context.read<ChatController>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllTodoLosChatPaginacion('', false,widget.infoChat['chat_id'],);
      
        } else {
          print("ES NULL POR ESO NO HACER PETICION ");
        }
      }
    });
    super.initState();
    //  _scrollController.addListener(_scrollListener);
  }
 
  @override
  void dispose() {
  _scrollController.dispose();
    super.dispose();
  }


 

  final TextEditingController _textController = TextEditingController();

  // final _focusNode = new FocusNode();




  // List<MessageChat> _messaje = [
  //   MessageChat(
  //     messaje:
  //         'hola dasd  a sd  asd  a sdasdadasd asdasd asdasda asdasd asdasd ',
  //     uid: '123',
  //     type: 'text', uidUser: '143',
  //     // animationController: AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
  //   ),
  //   MessageChat(
  //     messaje: 'hola',
  //     uid: '122',
  //     type: 'img', uidUser: '143',
  //     //  animationController:AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
  //   ),
  //   MessageChat(
  //     messaje: 'hola',
  //     uid: '1232',
  //     type: 'video', uidUser: '143',
  //     //  animationController:AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
  //   ),
  //   MessageChat(
  //     messaje: 'hola',
  //     uid: '123',
  //     type: 'audio', uidUser: '143',
  //     //  animationController:AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
  //   ),
  //   MessageChat(
  //     messaje: 'hola',
  //     uid: '123',
  //     type: 'audio', uidUser: '143',
  //     //  animationController:AnimationController(vsync: this ,duration: Duration( milliseconds: 200 ) ),
  //   ),
  // ];

  // final _focusNode = FocusNode();

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
     final _ctrlHome= context.read<HomeController>();



// print('LA INFORMACION : ${widget.infoChat}');



    final Responsive size = Responsive.of(context);

    return GestureDetector(
         onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true, // Centra el título en el AppBar
            elevation: 0,
            backgroundColor: cuaternaryColor, // Fondo blanco
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 
               Container(
                        width: size.iScreen(4.0),
                        height: size.iScreen(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                '${_ctrlHome.getUser!['foto']}', // Reemplaza con la URL de tu imagen
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        )),
                Spacer(),
                Container(
                  // color: Colors.red,
                  width: size.wScreen(65),
                  child: Text(
                    '${_ctrlHome.getUser!['nombre']} ',
                    style: GoogleFonts.poppins(
                      fontSize: size.iScreen(2.0),
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: -0.40,
                    ),
                    overflow: TextOverflow.ellipsis, // Color del título en negro
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            height: size.hScreen(100),
            width: size.wScreen(100),
            child: Column(
              children: [
                Flexible(child: Consumer<ChatController>(
                  builder: (_, values, __) {
    
    
                    return
                    //  Wrap( children: ( values.getListaTodoLosChatPaginacion as List).map((e) => MessageChat(
                    //       type: 'text',
                    //       uid:e['person_id'].toString(),
                    //       messaje:e['message_text'],
                    //       uidUser: "${_ctrlHome.getUser!['id']}",
                    //        ) ).toList());                 
                    Stack(
                      children: [
                        ListView.builder(
                          physics:const BouncingScrollPhysics(),
                          reverse :true,
                         controller: _scrollController,
    
                          itemCount: values.getListaTodoLosChatPaginacion.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Map<String,dynamic> menssaje = values.getListaTodoLosChatPaginacion[index];
                            return MessageChat(
                              type: 'text',
                              user:menssaje,
                              messaje:'${menssaje['message_text']}',
                              sessionUser: _ctrlHome.getUser!,
                               ) ;
                          },
                        ),
          //                 Positioned(
          //                   bottom: 0.0,
          //                   right: size.iScreen(2.0),
          //         child:
                  
                  
          // //          Consumer<ChatController>(
          // //   builder: (context, scrollProvider, _) {
    
              
          // //     return  _scrollController.position.maxScrollExtent ==
          // //   _scrollController.offset? _BotonFinalListView(size) :Container();
          // //   },
          // // ),
          //         _scrollController.position.maxScrollExtent ==
          //   _scrollController.offset? Container(): _BotonFinalListView(size) 
                  
          //       ),
                      ],
                    );
    
    
    
                    // return ListView.builder(
                    //   controller: _scrollController,
                    //   physics: const BouncingScrollPhysics(),
                    //   reverse: true,
                    //   itemCount: _messaje.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     final messaje = _messaje[index];
                    //     return messaje;
                    //   },
                    // );
                  },
                )),
              
                
                _buildInputField(context, size)
              ],
            ),
          )
          // Column(
          //   children: <Widget>[
          //     Expanded(
          //       child: _buildMessageList(size),
          //     ),
          //     _buildInputField(context,size),
          //   ],
          // ),
          ),
    );

//   }

// Widget _buildMessageList(Responsive size) {
//   return Consumer<ChatController>(
//     builder: (context, chatModel, _) {
//       return ListView.builder(
//         reverse: true,
//         itemCount: chatModel.messages.length, // <- Aquí está la referencia a 'length'
//         itemBuilder: (context, index) {
//           var message = chatModel.messages[index];
//           return _buildMessageWidget(message,size);
//         },
//       );
//     },
//   );
// }

//     Widget _buildMessageWidget(Message message, Responsive size) {
//     IconData icon;
//     switch (message.type) {
//       case MessageType.image:
//         icon = Icons.image;
//         break;
//       case MessageType.audio:
//         icon = Icons.audiotrack;
//         break;
//       case MessageType.video:
//         icon = Icons.videocam;
//         break;
//       default:
//         icon = Icons.message;
//     }

//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       children: [
//         CircleAvatar(
//           radius: 20.0, // Ajusta el radio para que el tamaño total sea de 40
//           child: Icon(icon),
//         ),
//         SizedBox(width: 16.0),
//         Expanded(
//           child: Text(
//             message.text,
//             style: TextStyle(fontSize: 16.0),
//           ),
//         ),
//       ],
//     ),
//   );
  }

  InkWell _BotonFinalListView(Responsive size) {
    return InkWell(          
                  onTap: (){
                     _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
                        );
                  },
                  child: Container(        
               width: size.iScreen(5.0),
               height: size.iScreen(5.0),
               decoration: ShapeDecoration(
                             shape: CircleBorder(), //here we set the circular figure
                             color: Colors.green.shade100
                           ),
                         child: Center(
                              child: Icon(
                                     Icons.keyboard_arrow_down_outlined,
                                     size: 30,
                                      color: Colors.black87,
                                      )
                            ),
                        )
            );
  }

  Widget _buildInputField(BuildContext context, Responsive size) {
    return Consumer<ChatController>(
      builder: (_, valueChat, __) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(
                horizontal: size.wScreen(2.0), vertical: size.iScreen(0.0)),
            padding: EdgeInsets.symmetric(
                horizontal: size.hScreen(1.0), vertical: size.iScreen(0.0)),
            child: Row(
              children: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.image),
                //   onPressed: () {
                //     // _sendMessage(MessageType.image,context);
                //   },
                // ),
                // IconButton(
                //   icon: Icon(Icons.audiotrack),
                //   onPressed: () {
                //     // _sendMessage(MessageType.audio,context);
                //   },
                // ),
                Container(
                  // color: Colors.red,
                  child: Icon(
                    Icons.add,
                    color:  Colors.black54,
                    size: size.iScreen(4),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Color(0xFFF2F2F2),
                      // color:Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    // color:Colors.red,
                    margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                    child: TextField(
                      onSubmitted: _hansdleSubmit,
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        valueChat.setCajaText(value);
                      },
                    ),
                  ),
                ),

                Container(
                    child: Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              'Enviar',
                              style: GoogleFonts.poppins(
                                fontSize: size.iScreen(1.5),
                                fontWeight: FontWeight.w600,
                                color: valueChat.getCajaTextoChat != ""
                                    ? Colors.black
                                    : Colors.grey.shade400,
                                // letterSpacing: -0.40,
                              ),
                            ),
                            onPressed:
                                valueChat.getCajaTextoChat != "" ? () {
                                  //  _hansdleSubmit(value);
                                
                                _hansdleSubmit(valueChat.getCajaTextoChat);
                                } : null,
                          )
                        :

                        // IconButton(

                        //     icon: Icon(
                        //       Icons.send,
                        //       color: valueChat.getCajaTextoChat != ""
                        //           ? tercearyColor
                        //           : Colors.grey.shade400,
                        //     ),

                        //     onPressed:
                        //         valueChat.getCajaTextoChat != "" ? () {} : null,

                        GestureDetector(
                            onTap:
                                valueChat.getCajaTextoChat != "" ? () {
                                   
                                _hansdleSubmit(valueChat.getCajaTextoChat);
                                  
                                } : null,
                            child: Container(
                              width: size.wScreen(
                                  13), // Puedes ajustar el tamaño del contenedor según tus necesidades
                              height: size.hScreen(12),
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // Hace que el contenedor sea circular
                                color: valueChat.getCajaTextoChat != ""
                                    ? tercearyColor
                                    : Colors.grey
                                        .shade400, // Puedes ajustar el color del contenedor
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_upward_outlined,
                                  color: valueChat.getCajaTextoChat != ""
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          )),
              ],
            ),
          ),
        );
      },
    );
  }

//   void _sendMessage(MessageType type,BuildContext context) {
  _hansdleSubmit(value) {
    final valueChat = context.read<ChatController>();
    final _ctrlHome = context.read<HomeController>();
    final _ctrlSocket = context.read<SocketModel>();
    // print(value);
    valueChat.setCajaText(value);
    _textController.clear();
    // final _newMessaje =
        //  MessageChat(uid: '123',messaje: valueChat.getCajaTextoChat,animationController: AnimationController(vsync: this ,duration: Duration( milliseconds: 200 )),);
    //     MessageChat(
    //   uid: '${ _ctrlHome.getUser!['id']}',
    //   messaje: valueChat.getCajaTextoChat,
    //   type: 'text',
    //    uidUser:'${ _ctrlHome.getUser!['id']}',
    // );
      //   valueChat.setInfoBusquedaTodoLosChatPaginacion([{
			// 	"message_id": 12,
			// 	"chat_id": 23,//'${ _ctrlHome.getUser!['id']}',
			// 	"person_id":3,
			// 	"message_text": valueChat.getCajaTextoChat,
			// 	"message_audio": "",
			// 	"reply_to_message_id": null,
			// 	"eliminado": 0,
			// 	"msg_FecReg": "2023-12-03T22:28:25.000Z",
			// 	"nombres": "ADMINISTRATOR",
			// 	"foto": "https://documentos.neitor.com/contable/fotoperfil/NE2021/58d090f0-f1b5-4a30-bbcb-1f6fb04864f5.jpg",
			// 	"message_fotos": []
			// }]);

final _data={
  "opcion": "GROUP", // 'INDIVIDUAL' | 'GROUP'
  "rucempresa": "ULTRA2022", // login
  "rol": '${ _ctrlHome.getUser!['rol']}',
  "chat_id": widget.infoChat['chat_id'], // tomar del grupo del chat
  "person_id": '${ _ctrlHome.getUser!['id']}', // login
  "message_text": valueChat.getCajaTextoChat, //texto
  "message_audio": "", // vacio de momento
  "message_fotos": [] // vacio de momento
};



// print('se imprima data para socket $_data');
  _ctrlSocket.emitEvent('client:send-mensaje', _data);

  valueChat.addItemsChatPaginacion(_ctrlSocket.getMensajeChat);
  // valueChat.setInfoBusquedaTodoLosChatPaginacion([_ctrlSocket.getMensajeChat]);





 valueChat.buscaAllTodoLosChatPaginacion('false',false,widget.infoChat['chat_id']);

 _scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );

      // valueChat.setMensaje(_newMessaje);


    //     MessageChat(
    //   uid: '123',
    //   messaje: valueChat.getCajaTextoChat,
    // );
    //  _newMessaje.add(
    //     {'uid': '123',
    //     "messaje": valueChat.getCajaTextoChat,
    //     "animationController": AnimationController(vsync: this ,duration: Duration( milliseconds: 200 )),
    //  } );
    // valueChat.addMessage( _newMessaje);
    // valueChat.addMessage( _newMessaje);

    // valueChat.getCajaTextoChat['animationController'].forward();

    // valueChat.setCajaText('');

    // _messaje.insert(0, _newMessaje);

    // _focusNode.requestFocus();
  }
}
