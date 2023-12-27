import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
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
  late Record _record;
  AudioPlayer _audioPlayer = AudioPlayer();
    // late BetterPlayerController _betterPlayerController;

  ChatController recorderState = ChatController();
    Map<String, dynamic>? user = {};

    final _scrollController = ScrollController();
     final TextEditingController _textController = TextEditingController();
  // final ScrollController _scrollController = ScrollController();
  
  bool showScrollToTopButton = false;
   
  @override
  void initState() {
  final _crtlChat = context.read<ChatController>();

//*************************/

  _record = Record();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      recorderState.playbackTime = duration.inMilliseconds.toDouble();
      recorderState.notify();
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      recorderState.playbackDuration = duration.inMilliseconds.toDouble();
      recorderState.notify();
    });
//*********************************** */
  _scrollController.addListener(() {

      if (_scrollController.position.minScrollExtent ==
          _scrollController.offset) {
         print('ESTAMOS EN EL FINAL DE LA PANTALLA');
        // _crtlChat.getpage;
        // _crtlChat.setPage(_crtlChat.getpage);
        //  _crtlChat.buscaAllTodoLosChatPaginacion('');

        final _next = context.read<ChatController>();
        final _crtlSocket = context.read<SocketModel>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllTodoLosChatPaginacion('', false,widget.infoChat['chat_id'],_crtlSocket);
      
        } else {
          print("ES NULL POR ESO NO HACER PETICION ");
        }
      }
    });



//************v VIDEO INICALIZA VIDEO  *************/
// _betterPlayerController = BetterPlayerController(
//       BetterPlayerConfiguration(
//         autoPlay: true,
//         fullScreenByDefault: false,
//         controlsConfiguration: BetterPlayerControlsConfiguration(
//           showControls: true,
//           enableFullscreen: true,
//           enableSubtitles: false,
//           enableQualities: true,
//           enableOverflowMenu: true,
//         ),
//       ),
//       betterPlayerDataSource: BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         'https://www.example.com/your_video.mp4',
//       ),
//     );

//************************************************/


    super.initState();
    //  _scrollController.addListener(_scrollListener);
  }
 
  @override
  void dispose() {
  _scrollController.dispose();
    super.dispose();
  }



  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {

final _infoChat=widget.infoChat;

     final _ctrlHome= context.read<HomeController>();
      final _ctrlChat= context.read<ChatController>();







    final Responsive size = Responsive.of(context);

    return GestureDetector(
         onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          // backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true, // Centra el título en el AppBar
            elevation: 0,
            backgroundColor: cuaternaryColor, // Fondo blanco
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 
               Container(
                        width: size.iScreen(4.0),
                        height: size.iScreen(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ),
                        child: ClipOval(
                        child: Image.asset(
                          'assets/imgs/groups.png', // Reemplaza con la ruta de tu imagen en los activos
                          width: size.iScreen(7.5),
                          height: size.iScreen(7.5),
                          fit: BoxFit.cover,
                        ),
                      ),),
                // Spacer(),
                Container(
                  // color: Colors.red,
                  width: size.wScreen(45),
                  child: Text(
                     '${widget.infoChat['grupo']['chat_name']}', 
                    style: GoogleFonts.poppins(
                      fontSize: size.iScreen(2.0),
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: -0.40,
                    ),
                    overflow: TextOverflow.ellipsis, // Color del título en negro
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ListaUsuariosChat(
                                          infoGrupo: widget.infoChat['grupo'],
                                        ))));
                  },
                  child: Container(
                    width: size.wScreen(12.0),
                    height: size.hScreen(5.0),
                    padding: EdgeInsets.all(size.iScreen(0.2)),
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
                      child: Icon(Icons.segment_outlined,color:  Colors.white,)
                    ),
                  ),
                ),

              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
          // Oculta el teclado antes de regresar a la página anterior
          FocusScope.of(context).unfocus();
          return true; // Permite que la página retroceda
        },
            child: Stack(
              children: [
                Container(
              
                  height: size.hScreen(100),
                  width: size.wScreen(100),
                  child: Column(
                    children: [
               
                      Flexible(child: Consumer<SocketModel>(
                        builder: (_, values, __) {
                  
                  
                          return
                                      
                          Stack(
                            children: [

                            
                              ListView.builder(
                                physics:const BouncingScrollPhysics(),
                                reverse :true,
                               controller: _scrollController,
                  
                                itemCount: values.getListaDeMensajeChat.length,
                                itemBuilder: (BuildContext context, int index) {
                                    if (values.getListaDeMensajeChat.isEmpty) {
                                      CircularProgressIndicator();
          
          
                                    }
          
                                  if (values.getListaDeMensajeChat.isNotEmpty) {
          
                                    final Map<String,dynamic> menssaje = values.getListaDeMensajeChat[index];
         
                                  return 
                               menssaje.isNotEmpty?
                                  MessageChat(
                                    type: 'text',
                                    user:_ctrlHome.getUser!,
                                    messaje:menssaje,
                                   
                                     ):Container() ;
          
                               
          
          
          
          
          
                                  }
                                  
                                  else{
                                    
                                  return CircularProgressIndicator();
                                  } 
                                  
                                },
                              ),
              
           


       Consumer<ChatController>(builder: (_, values, __) { 


        return Positioned(
  bottom: 0.0,
   child: 
   
   values.getFileChat!?
   Container(
      margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
     child: Column(
       children: [
        
          FadeInUp(
            child: GestureDetector(
                                  onTap:
                                      () async{
                                       values.setFileChat(false);


//  values.playInternetAudio("https://documentos.neitor.com/contable/chats/ULTRA2022/cade09f3-e2a1-4225-8b92-5f4585653ffb.ogg");



                            values.setTipoMensajeChat('image');

                            // //***************************/
                            bottomSheetImagen(_ctrlHome,context,size,_infoChat);
                            // final image = await _getImage(context, ImageSource.camera);
                            //   if (image != null) {
                            //     values.setImage(image);
                            //   }
                            // _modalImageVideo(context,size,_infoChat);
                            // //**************************/



                                        
                                      } ,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.4)),
                                    width: size.iScreen(
                                        5.5), // Puedes ajustar el tamaño del contenedor según tus necesidades
                                    height: size.iScreen(5.5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape
                                          .circle, // Hace que el contenedor sea circular
                                      color: Colors.grey
                                              .shade400, // Puedes ajustar el color del contenedor
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.image_rounded,
                                        color:Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
          ),
            FadeInUp(
              child: GestureDetector(
                                  onTap:
                                      () {
                                         
                                      values.setFileChat(false);
                                      values.setTipoMensajeChat('video');
                                      bottomSheetVideo(_ctrlHome,context,size,_infoChat);

                                      
                                        
                                      } ,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.4)),
                                    width: size.iScreen(
                                        6.0), // Puedes ajustar el tamaño del contenedor según tus necesidades
                                    height: size.iScreen(6.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape
                                          .circle, // Hace que el contenedor sea circular
                                      color: Colors.grey
                                              .shade400, // Puedes ajustar el color del contenedor
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.video_call_rounded,
                                        color:Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
            ),
                               FadeInUp(
                                 child: GestureDetector(
                                  onTap:
                                      ()async{


                      // if (recorderState.isRecording) {
                      //   await recorderState.stopRecording(_record, context);
                      // } else {
                      //   await recorderState.startRecording(context,_record, _audioPlayer);
                      // }
      
                                         
                                      values.setFileChat(false);
                                      values.setTipoMensajeChat('audio');
                                      //****************************/










                                      //****************************/

                                        
                                      } ,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: size.iScreen(0.4)),
                                    width: size.iScreen(
                                        6.0), // Puedes ajustar el tamaño del contenedor según tus necesidades
                                    height: size.iScreen(6.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape
                                          .circle, // Hace que el contenedor sea circular
                                      color: Colors.grey
                                              .shade400, // Puedes ajustar el color del contenedor
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.record_voice_over_outlined,
                                        color:Colors.black,
                                      ),
                                    ),
                                  ),
                                                             ),
                               ),
           
       ],
     ),
   ):Container(),
 );

               
       


        },)  
               
               
                            ],
                          );
                 
                  
                        },
                      )),
                    
                      
                      _buildInputField(context, size),
//                                                     Consumer<ChatController>(builder: (_, valuesAudio,__) { 
// return    Container(
//                     color: Colors.grey.shade200,
//                     width: size.wScreen(100),
//                     margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () async {
//                                 if (valuesAudio.isPlaying) {
//                                   await valuesAudio.stopPlaying(_audioPlayer);
//                                 } else {
//                                   await valuesAudio.playRecordedFile(_audioPlayer);
//                                 }
//                               },
//                               child: Container(
//                                 child: Icon(valuesAudio.isPlaying ? Icons.stop : Icons.play_arrow, size: size.iScreen(3.5)),
//                               ),
//                             ),
//                             Expanded(
//                               child: Slider(
//                                 activeColor: Colors.red,
//                                 thumbColor: Colors.pink,
//                                 min: 0,
//                                 value: valuesAudio.playbackTime,
//                                 max: valuesAudio.playbackDuration,
//                                 onChanged: (double value) {
//                                   _audioPlayer.seek(Duration(milliseconds: value.toInt()));
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               valuesAudio.formatDuration(valuesAudio.playbackTime) +
//                                   ' / ' +
//                                   valuesAudio.formatDuration(valuesAudio.playbackDuration),
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                                },),
                            

// AudioPlayerWidget(
//   valuesAudio: recorderState, // Pasa la instancia de RecorderState
//   audioPlayer: _audioPlayer, // Pasa la instancia de AudioPlayer
// )


   

   
    
                         

                    ],
                  ),
                ),
                
              ],
            ),
          ),
          // Column(
          //   children: <Widget>[
          //     Expanded(
          //       child: _buildMessageList(size),
          //     ),
          //     _buildInputField(context,size),
          //   ],
          // ),
          // floatingActionButton: Column(
          //   children: [
          //     FloatingActionButton(
          //       onPressed: () {
          //         // Lógica del tercer botón
          //       },
          //       child: Icon(Icons.delete),
          //     ),
          //      FloatingActionButton(
          //       onPressed: () {
          //         // Lógica del tercer botón
          //       },
          //       child: Icon(Icons.delete),
          //     ),
          //      FloatingActionButton(
          //       onPressed: () {
          //         // Lógica del tercer botón
          //       },
          //       child: Icon(Icons.delete),
          //     ),
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
            height: size.iScreen(6.0),
            margin: EdgeInsets.symmetric(
                horizontal: size.wScreen(0.0), vertical: size.iScreen(0.0)),
            padding: EdgeInsets.symmetric(
                horizontal: size.hScreen(1.0), vertical: size.iScreen(1.0)),
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
                GestureDetector(
                  onTap: () {
                    valueChat.setFileChat(!valueChat.getFileChat!);
                  },
                  child: Container(
                    // color: Colors.red,
                    child: Icon(
                      Icons.add,
                      color:  Colors.black54,
                      size: size.iScreen(4),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(height: size.iScreen(4.0),
                    decoration: ShapeDecoration(
                      color: Color(0xFFF2F2F2),
                      // color:Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
    valueChat.setTipoMensajeChat('message');
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





//  valueChat.buscaAllTodoLosChatPaginacion('false',false,widget.infoChat['chat_id']);

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




//------------MENSAJE TIPO TEXTO---------------//


// Text _messajeTexto(String messaje, Responsive size) {
//   return Text(
//     messaje.toString(),
//     style: GoogleFonts.poppins(
//       fontSize: size.iScreen(1.5),
//       fontWeight: FontWeight.w400,
//       color: sextinaryColor,
//       // letterSpacing: -0.40,
//     ),
//     textAlign: TextAlign.left,

//     maxLines: 2, // Número máximo de líneas permitidas
//     // overflow: TextOverflow.ellipsis,
//   );
// }


 Future<void> _modalImagen(BuildContext context,Responsive size ,Map<String,dynamic> infoChat) {
  final _ctrlSocket=context.read<SocketModel>();
    final _ctrlHome=context.read<HomeController>();
 
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return
        Consumer<ChatController>(builder: (_, _ctrl, __) { 

  return    AlertDialog(
          title: Text('Mi Imagen'),
          content: Container(
            // width: size.wScreen(100.0),
            // height: size.hScreen(30.0),
            child: 
            _ctrl.getTipoMensajeChat=='image'
            ?
            _ctrl.selectedImage!=null
              ? Image.file(_ctrl.selectedImage!)
           :Container():Container()
              
          )
          ,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {

                _ctrl.deleteImage();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enviar'),
              onPressed: () async{

                  ProgressDialog.show(context);
         await _ctrl.getUrlServerChats();
                  ProgressDialog.dissmiss(context);

                if (_ctrl.getUrlImagenVideo.isNotEmpty ) {
                          Navigator.of(context).pop();

                        //****************************************//
                        final _data={
  "opcion": "GROUP", // 'INDIVIDUAL' | 'GROUP'
  "rucempresa": "ULTRA2022", // login
  "rol": '${ _ctrlHome.getUser!['rol']}',
  "chat_id": infoChat['chat_id'], // tomar del grupo del chat
  "person_id": '${ _ctrlHome.getUser!['id']}', // login
  "message_text": '', //texto
  "message_audio": "", // vacio de momento
  "message_fotos": [_ctrl.getUrlImagenVideo], // vacio de momento
   "message_videos": [] // vacio de momento
};



// print('se imprima data para socket $_data');
  _ctrlSocket.emitEvent('client:send-mensaje', _data);

  _ctrl.addItemsChatPaginacion(_ctrlSocket.getMensajeChat);


   //****************************************//



                      } else {

                          NotificatiosnService.showSnackBarDanger('No se pudo enviar... ');
                      }

               
              },
            ),
          ],
        );

         },);
      
      },
    );

  }
   Future<void> _modalVideo(BuildContext context,Responsive size ,Map<String,dynamic> infoChat) {
  final _ctrlSocket=context.read<SocketModel>();
    final _ctrlHome=context.read<HomeController>();
 
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return
        Consumer<ChatController>(builder: (_, _ctrl, __) { 

  return    AlertDialog(
          title: Text( 'Mi Video'),
          content: Container(
            // width: size.wScreen(100.0),
            // height: size.hScreen(30.0),
            child: 
            
            _ctrl.selectedImage!=null
              ? _ctrl.getTipoMensajeChat=='video'
              ?  Container(
          width: size.wScreen(50),
          child: Row(
            children: [
              Icon(Icons.video_camera_back_outlined,size: size.iScreen(3.5),),
              SizedBox(width: size.iScreen(1.0),),
              Text('Ver Video', style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.7),
                          fontWeight: FontWeight.w500,
                          color: sextinaryColor,
                          // letterSpacing: -0.40,
                        )),
            ],
          ),
        ):Container():Container()
              
          ),
          
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {

                _ctrl.deleteImage();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enviar'),
              onPressed: () async{

                  ProgressDialog.show(context);
         await _ctrl.getUrlServerChats();
                  ProgressDialog.dissmiss(context);

                if (_ctrl.getUrlImagenVideo.isNotEmpty ) {
                          Navigator.of(context).pop();

                        //****************************************//
                        final _data={
  "opcion": "GROUP", // 'INDIVIDUAL' | 'GROUP'
  "rucempresa": "ULTRA2022", // login
  "rol": '${ _ctrlHome.getUser!['rol']}',
  "chat_id": infoChat['chat_id'], // tomar del grupo del chat
  "person_id": '${ _ctrlHome.getUser!['id']}', // login
  "message_text": '', //texto
  "message_audio": "", // vacio de momento
  "message_fotos": [], // vacio de momento
  "message_videos": [_ctrl.getUrlImagenVideo] // vacio de momento
};



// print('se imprima data para socket $_data');
  _ctrlSocket.emitEvent('client:send-mensaje', _data);

  _ctrl.addItemsChatPaginacion(_ctrlSocket.getMensajeChat);


   //****************************************//



                      } else {

                          NotificatiosnService.showSnackBarDanger('No se pudo enviar... ');
                      }

               
              },
            ),
          ],
        );

         },);
      
      },
    );

  }

  Future<File?> _getImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }
  Future<File?> _getVideo(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: source);

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }




   void bottomSheetImagen(
    HomeController _controller,
    BuildContext context,
    Responsive size,
    Map<String,dynamic> infoChat
  ) {

final _ctrlChat=context.read<ChatController>();


    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                   final image = await _getImage(context, ImageSource.camera);
                              if (image != null) {
                                _ctrlChat.setImage(image);
                              }
                    Navigator.pop(context);
                            _modalImagen(context,size,infoChat);
                 
                    // _getImageFromCamera(context,_controller);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Cámara',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    final image = await _getImage(context, ImageSource.gallery);
                              if (image != null) {
                                _ctrlChat.setImage(image);
                              }
                                 Navigator.pop(context);
                            _modalImagen(context,size,infoChat);
                    // Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Galería',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
              ],
            ));
  }

   void bottomSheetVideo(
    HomeController _controller,
    BuildContext context,
    Responsive size,
    Map<String,dynamic> infoChat
  ) {

final _ctrlChat=context.read<ChatController>();


    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                   final image = await _getVideo(context, ImageSource.camera);
                              if (image != null) {
                                _ctrlChat.setImage(image);
                              }
                    Navigator.pop(context);
                            _modalVideo(context,size,infoChat);
                 
                    // _getImageFromCamera(context,_controller);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Cámara',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    final image = await _getVideo(context, ImageSource.gallery);
                              if (image != null) {
                                _ctrlChat.setImage(image);
                              }
                                 Navigator.pop(context);
                            _modalVideo(context,size,infoChat);
                    // Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Galería',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
              ],
            ));
  }