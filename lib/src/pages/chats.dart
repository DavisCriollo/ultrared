import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/service/socket.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/message.dart';
import 'package:ultrared/src/widgets/modal_permisos.dart';

class Chats extends StatefulWidget {
    final Map<String,dynamic>? user;
  const Chats({Key? key, this.user}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> with TickerProviderStateMixin {

 final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

//*************AUDIO PLAYER**************/

 bool isRecording = false;
  late String filePath;
  bool isPlaying = false;
  double playbackTime = 0.0;
  double playbackDuration = 1.0; // Inicia con un valor predeterminado
 

  late Record _record;
  AudioPlayer _audioPlayer = AudioPlayer();

//***********************************/
  ChatController recorderState = ChatController();
    Map<String, dynamic>? user = {};

    // final _scrollController = ScrollController();
     final TextEditingController _textController = TextEditingController();
@override
  void initState() {
   
  final _crtlChat = context.read<ChatController>();

//*************************/

 
 _record = Record();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        playbackTime = duration.inMilliseconds.toDouble();
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        playbackDuration = duration.inMilliseconds.toDouble();
      });
    });

//****************   SCROOL DEL LA PANTALLA ******************* */
  _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //  print('ESTAMOS EN EL FINAL DE LA PANTALLA');
        // _loadListScroll.getpage;
        // _loadListScroll.setPage(_loadListScroll.getpage);
        //  _loadListScroll.buscaAllPropietariosPaginacion('');

        final _next = context.read<ChatController>();
          final _crtlSocket = context.read<SocketService>();
        if (_next.getpage != null) {
          _next.setPage(_next.getpage);
          //       providerSearchPropietario.setCantidad(25);
          _next.buscaAllTodoLosChats(context,'', false, _next.getInfoChat['chat_id'],_crtlSocket);
        } else {
          print("ES NULL POR ESO NO HACER PETICION ");
        }
      }
    });
//*********************************** */
   
    super.initState();
  }
// void _scrollListener() {
//   if (_scrollController.position.atEdge) {
//     if (_scrollController.position.pixels == 0) {
//       // Estás en la parte superior del contenido (scroll hacia arriba)
//       print("Estás en la parte superior del contenido");
//     } else {
//       // Estás en la parte inferior del contenido (scroll hacia abajo)
//       print("Estás en la parte inferior del contenido");
//     }
//   }
// }
 @override
  void dispose() {
  _scrollController.dispose();
   _record.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
//**************  AUDIO************************/
 String _formatDuration(double milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds.round());
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  Future<void> _startRecording(Responsive size,Map<String,dynamic> infoChat) async {
    bool hasPermission = await _record.hasPermission();
    if (hasPermission) {
      if (!isRecording) {
        await _record.start();
        setState(() {
          isRecording = true;
        });
        _showRecordingModal(size,infoChat);
      }
    } else {
      // Handle permission denied
      print('Permission denied to access the microphone.');
    }
  }

 

    void _showRecordingModal(Responsive size,Map<String,dynamic> infoChat) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.mic, size: size.iScreen(5.0), color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Grabando...',
                    style: TextStyle(fontSize: 20),
                  ),
                  // SizedBox(height: 16),
                  // IconButton(
                  //   onPressed: () async {
                  //     await _stopRecording();
                  //   },
                  //   icon: Icon(Icons.stop),
                  // ),
                  // SizedBox(height: 16),
                   IconButton(
                    onPressed: ()async {
                      // Lógica para enviar el archivo grabado
//  print('Enviando archivo: ${filePath}');
 await _stopRecording();
                      _playRecordedFile();
                     
                    },
                    icon: Icon(Icons.play_arrow,size: size.iScreen(3.5),),
                  ),
                   IconButton(
                    onPressed: () async{
                      // Lógica para enviar el archivo grabado
//  print('Enviando archivo: ${filePath}');
 await _stopRecording();
                          _stopPlaying();
                     
                    },
                    icon: Icon(Icons.stop),
                  ),
                  IconButton(
                    onPressed: () async {
                          await _stopRecording();
                          _stopPlaying();
                      Navigator.of(context).pop(); // Cerrar el modal sin detener la grabación
                    },
                    icon: const Icon(Icons.cancel),
                  ),
                  IconButton(
                    onPressed: () async {
                          // await _stopRecording();
                          // _stopPlaying();
                          print('Enviando archivo: ${filePath}'); 

final _ctrlChat = context.read<ChatController>();
    final _ctrlHome = context.read<HomeController>();
    final _ctrlSocket = context.read<SocketService>();
                  _ctrlChat.setImage( File(filePath));
                  ProgressDialog.show(context);
     final response=    await _ctrlChat.getUrlServerChats();
                  ProgressDialog.dissmiss(context);

                if (response!=null) {
                          

                        //****************************************//
                        final _data={
  "opcion": "GROUP", // 'INDIVIDUAL' | 'GROUP'
  "rucempresa": "ULTRA2022", // login
  "rol": '${ _ctrlHome.getUser!['rol']}',
  "chat_id": infoChat['chat_id'], // tomar del grupo del chat
  "person_id": '${ _ctrlHome.getUser!['id']}', // login
  "message_text": '', //texto
  "message_audio": _ctrlChat.getUrlImagenVideo, // vacio de momento
  "message_fotos": [], // vacio de momento
   "message_videos": [] // vacio de momento
};



// print('se imprima data para socket $_data');
  _ctrlSocket.emitEvent('client:send-mensaje', _data);

  _ctrlChat.addItemsChatPaginacion(_ctrlSocket.getMensajeChat);


   //****************************************//
Navigator.of(context).pop();


                      } else {

                          NotificatiosnService.showSnackBarDanger('No se pudo enviar... ');
                      }


//  Navigator.of(context).pop();


                    },
                    icon: const Icon(Icons.send),
                  ),
                  // SizedBox(height: 16),
                 
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _stopRecording() async {
    if (isRecording) {
      String? result = await _record.stop();
      // Navigator.of(context).pop(); // Cerrar el modal al detener la grabación
      setState(() {
        isRecording = false;
        filePath = result!;
      });
      print('Recording saved at: $result');
    }
  }

  Future<void> _playRecordedFile() async {
    if (File(filePath).existsSync()) {
      await _audioPlayer.play(filePath, isLocal: true);
      setState(() {
        isPlaying = true;
      });
       print('File ok: $filePath');
    } else {
      print('File not found: $filePath');
    }
  }

  Future<void> _stopPlaying() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }








  @override
  Widget build(BuildContext context) {
      final Responsive size = Responsive.of(context);
 final _ctrlHome= context.read<HomeController>();
      final _ctrlChat= context.read<ChatController>();


    return GestureDetector(
       onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                       '${_ctrlChat.getInfoChat['grupo']['chat_name']}', 
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


                                 final _ctrlSocket =context.read<SocketService>();
                  _ctrlSocket.emitEvent('client:lista-usuarios', { "chat_id" : _ctrlChat.getInfoChat['grupo']['chat_id'] });



                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ListaUsuariosChat(
                                            infoGrupo: _ctrlChat.getInfoChat['grupo'],
                                          ))));
                    },
                    child: Container(
                      width: size.wScreen(10.0),
                      height: size.hScreen(3.5),
                      padding: EdgeInsets.all(size.iScreen(0.3)),
                      decoration: ShapeDecoration(
                        color: Color(0xFFB32623),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
            body: Container(
              // color:Colors.yellow,
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
              width: size.wScreen(100),
              height: size.hScreen(100),
              child:
              Consumer<SocketService>(builder: (_, valueChat, __) {  
                    return Stack(
                      children: [
                        Column(
                      
                          children: [
                            Expanded(
                              child: NotificationListener<ScrollNotification>(
                                 onNotification: (scrollNotification) {
          setState(() {
            _showButton = scrollNotification.metrics.pixels > 0;
          });
          return true;
        },
                                child: ListView.builder(
                                  reverse: true,
                                  padding: EdgeInsets.only(bottom: 16.0), // Agrega espacio en la parte inferior
                                   controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                          itemCount: valueChat.getListaDeMensajeChat.length+1,
                                          itemBuilder: (BuildContext context, int index) {
                                
                                              if (index<valueChat.getListaDeMensajeChat.length) {
                                final _chat = valueChat.getListaDeMensajeChat[index];
                                            return 
                                            
                                            // //********************************//
                                            //  Container(
                                            //   width: size.wScreen(100),
                                            //   height: size.iScreen(10.0),
                                            //   color: Colors.grey.shade300,
                                            //   child: Text('${_chat['message_text']} -- ${_chat['message_id']}'));
                                            //   //********************************//
                              
                              
                                                _chat.isNotEmpty?
                                    MessageChat(
                                      type: 'text',
                                      user:_ctrlHome.getUser!,
                                      messaje:_chat,
                                     
                                       ):Container() ;
                                        
                              
                              
                              
                              
                                               // //********************************//
                              
                              
                                          }
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          else{
                                 return Consumer<ChatController>(
                                      builder: (_, valueNext, __) {
                                        return valueNext.getpage == null
                                            ? Container(
                                              
                                                margin: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(2.0)),
                                                child: Center(
                                                  child: Container(
                                                     padding: EdgeInsets.symmetric(
                                                    vertical: size.iScreen(0.2),
                                                    horizontal:  size.iScreen(0.5),
                                                    ),
                                                    decoration:BoxDecoration(borderRadius: BorderRadius.circular(8),
                                                    color: Colors.lightGreen,),
                                                    
                                                    child: Text(
                                                      'Estás al día',
                                                      style: GoogleFonts.lexendDeca(
                                                          fontSize:
                                                              size.iScreen(1.3),
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                    ),
                                                  ),
                                                ))
                                            : valueChat.getListaDeMensajeChat.length >
                                                    25
                                                ? Container(
                                                    margin: EdgeInsets.symmetric(
                                                        vertical:
                                                            size.iScreen(2.0)),
                                                    child: const Center(
                                                        child:
                                                            CircularProgressIndicator()))
                                                : Container();
                                      },
                                    );
                                
                                          }
                                            
                                          },
                                          
                                        ),
                              ),
                            ),
                             _buildInputField(context, size),
                          ],
                        ),
                          Consumer<ChatController>(builder: (_, values, __) { 


        return Positioned(
  bottom: 50.0,
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
                                   
                            
                            // //**************************/
 await _ctrlHome.checkAndRequestPermissions();
           
                    if (_ctrlHome.hasCameraPermission) {
                          values.setFileChat(false);
                            values.setTipoMensajeChat('image');
                             bottomSheetImagen(_ctrlHome,context,size,values.getInfoChat);
                    } else {
                      showPermissionModal(context,size,'Es necesario otorgar permisos de cámara para utilizar el chat de nuestra aplicación.');
                      
                    }   


                                        
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
                                      () async{


                                        
                                    


                                      await _ctrlHome.checkAndRequestPermissions();
           
                    if (_ctrlHome.hasCameraPermission) {
                           values.setFileChat(false);
                                      values.setTipoMensajeChat('video');
                                      bottomSheetVideo(_ctrlHome,context,size,values.getInfoChat);
                    } else {
                      showPermissionModal(context,size,'Es necesario otorgar permisos de cámara para utilizar el chat de nuestra aplicación.');
                      
                    } 




                                      
                                        
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
      
                                         
                                     
                                      //****************************/
                                              await _ctrlHome.checkAndRequestPermissions();
           
                    if (_ctrlHome.hasCameraPermission) {
                           values.setFileChat(false);
                                      values.setTipoMensajeChat('audio');
                    } else {
                      showPermissionModal(context,size,'Es necesario otorgar permisos de micrófono para utilizar el chat de nuestra aplicación.');
                      
                    } 

                                           //******************************/




                // if (isRecording) {
                //   await _stopRecording();
                // } else {
                //   await _startRecording();
                // }


               await _startRecording(size,values.getInfoChat);



//******************************/







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
              },)),
              
            floatingActionButton: Visibility(
        visible: _showButton,
        child: FloatingActionButton(
          mini: true,
          onPressed: () {
            // Scroll to the top when the button is pressed
            // Scrollable.ensureVisible(context,
            //     alignment: 5.0, duration: Duration(milliseconds: 500));
            scrollToEnd();
          },
          child: Icon(Icons.arrow_downward),
          backgroundColor: Colors.grey, // Cambia el color a rojo
        ),
      ),
    
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,   
      ),
    );
  }
void scrollToEnd() {
    // Scroll to the end of the list
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

   Future<void> onRefresh() async {
    final _ctrlChat =Provider.of<ChatController>(context, listen: false);
      final _ctrlSocket =Provider.of<SocketService>(context, listen: false);
    _ctrlChat.setPage(0);
    _ctrlChat.setCantidad(25);
    _ctrlChat.buscaAllTodoLosChats(context,'', false, _ctrlChat.getInfoChat['chat_id'],_ctrlSocket);
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
                                  Icons.insert_comment_outlined,
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
    _hansdleSubmit(value) {
    final valueChat = context.read<ChatController>();
    final _ctrlHome = context.read<HomeController>();
    final _ctrlSocket = context.read<SocketService>();
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
  "chat_id": valueChat.getInfoChat['chat_id'], // tomar del grupo del chat
  "person_id": '${ _ctrlHome.getUser!['id']}', // login
  "message_text": valueChat.getCajaTextoChat, //texto
  "message_audio": "", // vacio de momento
  "message_fotos": [] // vacio de momento
};



// print('se imprima data para socket $_data');

_ctrlSocket.setUserApp(widget.user);

  _ctrlSocket.emitEvent('client:send-mensaje', _data);
  //   _ctrlSocket.emitEvent(
  //                                                           'client:lista-chats-grupos',
  //                                                           {});

  // valueChat.addItemsChatPaginacion(_ctrlSocket.getMensajeChat);


  // valueChat.setInfoBusquedaTodoLosChats([],_ctrlSocket);






//  valueChat.buscaAllTodoLosChatPaginacion('false',false,widget.infoChat['chat_id']);

 _scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );

    valueChat.setCajaText('');
  }





 Future<void> _modalImagen(BuildContext context,Responsive size ,Map<String,dynamic> infoChat) {
  final _ctrlSocket=context.read<SocketService>();
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
_ctrlSocket.setUserApp(widget.user);
  _ctrlSocket.emitEvent('client:send-mensaje', _data);

  // _ctrl.addItemsChatPaginacion(_ctrlSocket.getMensajeChat);


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
  final _ctrlSocket=context.read<SocketService>();
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


_ctrlSocket.setUserApp(widget.user);
// print('se imprima data para socket $_data');
  _ctrlSocket.emitEvent('client:send-mensaje', _data);

  // _ctrl.addItemsChatPaginacion(_ctrlSocket.getMensajeChat);


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
    final pickedFile = await picker.pickImage(source: source,imageQuality: 50);

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }
  Future<File?> _getVideo(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: source,);

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

// final _ctrlHome=context.read<HomeController>();

    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                      // _ctrlHome.setIsCamara(true);
                   final image = await _getImage(context, ImageSource.camera);
                              if (image != null) {
                                _ctrlChat.setImage(image);
                              }
                    Navigator.pop(context);
                     if (image != null) {
                                 _modalImagen(context,size,infoChat);
                              }
                           
                 
                      




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
                    //  _ctrlHome.setIsCamara(true);
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
// final _ctrlHome=context.read<HomeController>();

    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                      // _ctrlHome.setIsCamara(true);
                   final image = await _getVideo(context, ImageSource.camera);
                              if (image != null) {
                                _ctrlChat.setImage(image);
                              }
                    // Navigator.pop(context);
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
                      // _ctrlHome.setIsCamara(true);
                    final image = await _getVideo(context, ImageSource.gallery);
                              if (image != null) {
                                _ctrlChat.setImage(image);
                              }
                                //  Navigator.pop(context);
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
  
  
  
  
  
  
  
  
  
  }