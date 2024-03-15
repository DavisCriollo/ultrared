

import 'package:animate_do/animate_do.dart';
import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/pages/view_video_page.dart';
import 'package:ultrared/src/pages/vista_imagen.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/snack_info.dart';
import 'package:ultrared/src/utils/theme.dart';


class MessageChat extends StatefulWidget {
  final Map<String, dynamic> messaje;
  final String type;
  // final Map<String, dynamic>sessionUser;
  final Map<String, dynamic> user;
  // final AnimationController animationController;

  const MessageChat({
    Key? key,
    required this.messaje,
    required this.user,
    required this.type,
    // required this.sessionUser,
    //  required this.animationController
  }) : super(key: key);

  @override
  State<MessageChat> createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    String fechaString = "${widget.messaje['msg_FecReg']}";

    // Convertir la cadena a DateTime
    DateTime fecha = DateTime.parse(fechaString);

    // Convertir a la zona horaria local
    DateTime fechaLocal = fecha.toLocal();

    // String horaFormateada = "${fechaLocal.hour}:${fechaLocal.minute}:${fechaLocal.second}";
       // Formatear la fecha con día, mes y año
String fechaFormateada ="${fechaLocal.day < 10 ? '0' : ''}${fechaLocal.day}/${fechaLocal.month < 10 ? '0' : ''}${fechaLocal.month}/${fechaLocal.year}";

    String horaFormateada = "${fechaLocal.hour < 10 ? '0' : ''}${fechaLocal.hour}:${fechaLocal.minute < 10 ? '0' : ''}${fechaLocal.minute}";
    // Formatear la fecha para mostrar solo la hora
  String _fecha= '$horaFormateada  $fechaFormateada';
    // print("Hora local formateada: $horaFormateada");

    // DateFormat.Hm().format(myDate.toLocal())

//     String horaFormateada ='';
//   if (messaje['msg_FecReg'] != null) {

//    horaFormateada =DateFormat.jm().format(DateTime.parse("${messaje['msg_FecReg']}").toLocal());
//   // Resto del código
// } else {
//   // Manejo del caso cuando la fecha es nula
//   horaFormateada='';
// }

    return Container(
      margin: EdgeInsets.symmetric(horizontal:size.iScreen(0.5)),
      child: widget.user['id'] == widget.messaje['person_id']
          ? _myChat(context,size, widget.messaje, widget.type, _fecha)
          // : Text('data')/
          : _noChat( context,size, widget.messaje, widget.type, _fecha),
    );
  }
}

_myChat(BuildContext context,
    Responsive size, Map<String, dynamic> messaje, String type, String _hora) {
  return FadeOut(
 duration: Duration(milliseconds: 400),
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        // width: size.wScreen(60),
       
        padding: EdgeInsets.all(size.iScreen(0.2)),
        margin: EdgeInsets.only(right: size.iScreen(0.2), bottom:size.iScreen(0.2), left: size.iScreen(0.2)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //  Container(
            //               width: size.iScreen(4.0),
            //               height: size.iScreen(4.0),
            //               margin:EdgeInsets.symmetric(horizontal:size.iScreen(0.3)),
            //               decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 border: Border.all(color: Colors.grey, width: 2.0),
            //               ),
            //               child: ClipOval(
            //                 child: CachedNetworkImage(
            //                   imageUrl:
            //                       '${messaje['foto']}', // Reemplaza con la URL de tu imagen
            //                   placeholder: (context, url) =>
            //                       const CircularProgressIndicator(),
            //                   errorWidget: (context, url, error) =>
            //                       Icon(Icons.error),
            //                   fit: BoxFit.cover,
            //                 ),
            //               )),
  
            messaje['foto'].isNotEmpty
                ? Container(
                    width: size.iScreen(4.0),
                    height: size.iScreen(4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2.0),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            '${messaje['foto']}', // Reemplaza con la URL de tu imagen
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ))
                : Container(
                  padding: EdgeInsets.all(size.iScreen(0.5)),
                   decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade500, width: 2.0),
                    ),
                  child: ClipOval(
                      child: Icon( Icons.person,color: Colors.grey.shade400,size: size.iScreen(2.8),)
                      
                      
                      // Image.asset(
                      //   'assets/imgs/no-image.png',
                      //   // color: Colors.grey.shade200, // Reemplaza con la ruta de tu imagen en los activos
                      //   width: size.iScreen(4.0),
                      //   height: size.iScreen(4.0),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                ),
  
            Container(
                // color: Colors.red ,
                // width: size.wScreen(60.0),
                margin:EdgeInsets.only(left: size.iScreen(0.0)),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: size.iScreen(1.0),
                  vertical: size.iScreen(0.5),
                ),
                decoration: BoxDecoration(
                    color: septinaryColor,
                    // color: Color(0xff4D9EF6),
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Container(
                        //   // width: size.wScreen(60.0),
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     // '${messaje['nombres']} ',
                        //     'Tú',
                        //    textAlign: TextAlign.left,
                        //     style: GoogleFonts.poppins(
                        //       fontSize: size.iScreen(1.5),
                        //       fontWeight: FontWeight.w600,
                        //       color: quinquanaryColor,
                        //       letterSpacing: -0.40,
                        //     ),
                        //   ),
                        // ),
                        Container(
                          // color:  Colors.red,
                            // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
                            // alignment: Alignment.centerLeft,
                            constraints: BoxConstraints(
                                // minHeight: size.wScreen(5.0), // Altura mínima
  
                                minWidth: size.wScreen(25.0),
                                // maxWidth: size.wScreen(60.0) // Ancho máximo
                                ),
                            child: 
                              Column(
                              children: [
                            
                                messaje['message_text'].isNotEmpty? Container(
                                        constraints: BoxConstraints(
                                // minHeight: size.wScreen(1.0), // Altura mínima
  
                                minWidth: size.wScreen(5.0),
                                maxWidth: size.wScreen(60.0) // Ancho máximo
                                ),
                                
                                margin: EdgeInsets.symmetric(vertical:size.iScreen(0.2)),child: _messajeTexto( messaje['message_text'],size,context)):Container(),
                                messaje['message_fotos'].isNotEmpty?Container(margin: EdgeInsets.symmetric(vertical:size.iScreen(0.5)),child: _messajeImagen(context, messaje['message_fotos'],size)):Container(),
                                 messaje['message_videos'].isNotEmpty? Container(margin: EdgeInsets.symmetric(vertical:size.iScreen(0.5)),child: _messajeVideo(context,messaje['message_videos'],size)):Container(),
                                    messaje['message_audio'].isNotEmpty? Container(margin: EdgeInsets.symmetric(vertical:size.iScreen(0.5)),child: _messajeAudio(context,messaje['message_audio'],size)):Container(),
                                
                              ],
                            )
                               
                                  ),
                        SizedBox(
                          height: size.wScreen(4.0),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: -3,
                      right: 0,
                      child: Text(
                        '$_hora ',
                        style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.2),
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          // letterSpacing: -0.40,
                        ),
                        // textAlign: TextAlign.right,
  
                        // overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )),
          ],
        ),
        decoration: BoxDecoration(
            // color: Color(0xff4D9EF6),
            // color: Colors.red,
            borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}

Container _messajeVideo(BuildContext context,List _listUrl,Responsive size) {

final _chatCtrl=context.read<ChatController>();



  return Container(
    // margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5),horizontal: size.iScreen(0.5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      // width: size.wScreen(
      //   60.0,
      // ),
      // height: size.hScreen(
      //   30.0,
      // ),
      child: 
       Wrap(children: _listUrl.map((e) =>   Container(

        // color: Colors.red,
         margin: EdgeInsets.symmetric(vertical: size.iScreen(0.5),horizontal: size.iScreen(0.0)),
         padding: EdgeInsets.symmetric(vertical: size.iScreen(0.5),horizontal:size.iScreen(0.5)),
        child:InkWell( 
          
          
          onTap:   _chatCtrl.getPressed==false? ()async{


          //  Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         // builder: (context) => VideoPlayerScreen(videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4" ),
          //           builder: (context) => VideoPlayerScreen(videoUrl: e),
          //       ),
          //     );
      
      //********DESCARGA DEL VIDEO **********/
            _chatCtrl.setPressed(true);
         await _chatCtrl.descargarYGuardarVideo(e,context);


        } :null,child: Container(
          width: size.wScreen(50),
          child: 
          Consumer<ChatController>(builder: (_, valueDown, __) {  
              return   Row(
            mainAxisAlignment: 
            
            MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.video_camera_back_outlined,size: size.iScreen(3.5),),
              SizedBox(width: size.iScreen(1.0),),
              Text('Ver Video', style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.7),
                          fontWeight: FontWeight.w500,
                          color: sextinaryColor,
                          // letterSpacing: -0.40,
                        )),
                   valueDown.getPressed==false? Icon(Icons.download_outlined,size: size.iScreen(3.5),):CircularProgressIndicator.adaptive(strokeWidth : 2.0,),
                        
            ],
          );
          },)
          
        
        )),
      )).toList())
    ,
      
      
          );}
          


Container _messajeAudio(BuildContext context,String _urlAudio, size) {
String _formatDuration(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }


  return Container(
    width: size.iScreen(20.0),
    height: size.iScreen(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        // color: Colors.grey,
          // color: Colors.yellow,
      ),child:  
      Column(
        mainAxisSize : MainAxisSize.min,
      children: [
             Consumer<ChatController>(
            builder: (context, audioProvider, child) {
              return Container(
                  // color: Colors.green,
                  height: size.iScreen(4.0),
                       width: size.iScreen(30.0),
                child:
                 Row(
                  children: [
                    IconButton(
                      icon: Icon(audioProvider.isPlaying ? Icons.stop : Icons.play_arrow),
                      onPressed: () {
                        var audioProvider = Provider.of<ChatController>(context, listen: false);
                        audioProvider.play(_urlAudio);
                      },
                    ),
                    // Slider(
                    //   value: audioProvider.position,
                    //   max: audioProvider.duration,
                    //   onChanged: (value) {
                    //     audioProvider.seek(value);
                    //   },
                     
                    // ),
                    Container(
          // color: Colors.red,
          padding:  EdgeInsets.symmetric(horizontal:size.iScreen(0.2),vertical:size.iScreen(0.0)),
          child: Consumer<ChatController>(
            builder: (context, audioProvider, child) {
              return Text(
                '${_formatDuration(audioProvider.position.toInt())} / ${_formatDuration(audioProvider.duration.toInt())}',
                 style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.5),
                          fontWeight: FontWeight.w500,
                          color: sextinaryColor,
                          // letterSpacing: -0.40,
                        )
              );
            },
          ),
        ),




        
                  ],
                ),
              );
            },
          ),

        // Container(
        //   // color: Colors.red,
        //   padding:  EdgeInsets.symmetric(horizontal:size.iScreen(0.2),vertical:size.iScreen(0.0)),
        //   child: Consumer<ChatController>(
        //     builder: (context, audioProvider, child) {
        //       return Text(
        //         '${_formatDuration(audioProvider.position.toInt())} / ${_formatDuration(audioProvider.duration.toInt())}',
        //          style: GoogleFonts.poppins(
        //                   fontSize: size.iScreen(1.5),
        //                   fontWeight: FontWeight.w500,
        //                   color: sextinaryColor,
        //                   // letterSpacing: -0.40,
        //                 )
        //       );
        //     },
        //   ),
        // ),
      ],
    ),
    );
      

}

Container _messajeImagen(BuildContext context,List _listUrl,Responsive size) {
  final ctrlChar= context.read<ChatController>();
  return Container(
    // margin: EdgeInsets.all(size.iScreen(0.5)),
    //  padding: EdgeInsets.all(size.iScreen(0.2)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey,
      ),
      // width: size.wScreen(
      //   60.0,
      // ),
      // height: size.hScreen(
      //   30.0,
      // )
      child:   _listUrl.isNotEmpty? Wrap(children:_listUrl.map((e) =>  InkWell(
        onTap: () {
                                            final _infoImage={"id":1,"lugar":'CHAT', "url":'$e'};
                                               Navigator.push(context,
        MaterialPageRoute(builder: ((context) => PreviewPhoto(infoImage:_infoImage))));
                                            
                                          },
                                          onLongPress: (){

                                            ctrlChar.descargarImagen(e,context);
                                          },
        child: Container(
           constraints: BoxConstraints(
                              // minHeight: size.wScreen(5.0), // Altura mínima

                              minWidth: size.wScreen(5.0),
                              maxWidth: size.wScreen(50.0),
                              // Ancho máximo
                              ),
          child: FadeInImage(
                                                              placeholder:
                                                                  const AssetImage(
                                                                      'assets/imgs/loader.gif'),
                                                              image: NetworkImage(
                                                                '${e}',
                                                              ),
                                                            ),
        ),
      )).toList()):Container());
}

Widget _messajeTexto(String messaje, Responsive size,BuildContext context) {
  return GestureDetector(
    onLongPress: ()async{
       await Clipboard.setData(ClipboardData(
                                              text:messaje.toString()));

                                          final snackBar = sNackCopy(
                                              'Texto Copiado',
                                              size,
                                              Colors.green.shade400
                                              );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                       
      
    },
    child: Container(
      // color: Colors.red,
        constraints: BoxConstraints(
                                // minHeight: size.wScreen(5.0), // Altura mínima
  
                                minWidth: size.wScreen(10.0),
                                maxWidth: size.wScreen(50.0),
                                // Ancho máximo
                                ),
      // width: size.iScreen(30.0),
      child: Text(
        messaje.toString(),
        style: GoogleFonts.poppins(
          fontSize: size.iScreen(1.5),
          fontWeight: FontWeight.w400,
          color: sextinaryColor,
          // letterSpacing: -0.40,
        ),
        textAlign: TextAlign.left,
  
        // maxLines: 20, // Número máximo de líneas permitidas
        // overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}

_noChat(BuildContext context,
    Responsive size, Map<String, dynamic> messaje, String type, String _hora) {
  return FadeIn(
    duration: Duration(milliseconds: 400),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // color:  Colors.red,
        padding: EdgeInsets.all(size.iScreen(0.2)),
        margin: EdgeInsets.only(right: size.iScreen(0.2), bottom:size.iScreen(0.2), left: size.iScreen(0.2)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //     width: size.iScreen(4.0),
            //     height: size.iScreen(4.0),
            //     margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.3)),
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(color: Colors.grey, width: 2.0),
            //     ),
            //     child: ClipOval(
            //       child: CachedNetworkImage(
            //         imageUrl:
            //             '${messaje['foto']}', // Reemplaza con la URL de tu imagen
            //         placeholder: (context, url) =>
            //             const CircularProgressIndicator(),
            //         errorWidget: (context, url, error) => Icon(Icons.error),
            //         fit: BoxFit.cover,
            //       ),
            //     )),
            messaje['foto'].isNotEmpty
                ? Container(
                    width: size.iScreen(4.0),
                    height: size.iScreen(4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2.0),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            '${messaje['foto']}', // Reemplaza con la URL de tu imagen
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ))
                : ClipOval(
                    child: Image.asset(
                      'assets/imgs/no-image.png', // Reemplaza con la ruta de tu imagen en los activos
                      width: size.iScreen(4.0),
                      height: size.iScreen(4.0),
                      fit: BoxFit.cover,
                    ),
                  ),
            Container(
                // color: Colors.red ,
                // width: size.wScreen(60.0),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: size.iScreen(1.0),
                  vertical: size.iScreen(0.5),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    // color: Color(0xff4D9EF6),
                    borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          // width: size.wScreen(60.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${messaje['nombres']} ',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontSize: size.iScreen(1.5),
                              fontWeight: FontWeight.w600,
                              color: quinquanaryColor,
                              letterSpacing: -0.40,
                            ),
                          ),
                        ),

                        Container(
                          // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
                        //   // alignment: Alignment.centerLeft,
                          constraints: BoxConstraints(
                              // minHeight: size.wScreen(5.0), // Altura mínima
  
                              minWidth: size.wScreen(25.0),
                              // maxWidth: size.wScreen(60.0) // Ancho máximo
                              ),
                        //   child:messaje['message_text']._messajeTexto(messaje['message_text'], size)
                        //   //  Text('data'),
                        ),
                        // type == 'text'
                        //     ? messaje['message_text']._messajeTexto(messaje['message_text'], size)
                        //     : type == 'img'
                        //         ? _messajeImagen(size)
                        //         : type == 'video'
                        //             ? _messajeVideo(size)
                        //             : _messajeAudio(size)),
                         Container(
                            // constraints: BoxConstraints(maxWidth: size.wScreen(60.0)),
                            // alignment: Alignment.centerLeft,
                            constraints: BoxConstraints(
                            //     minHeight: size.wScreen(5.0), // Altura mínima
  
                                minWidth: size.wScreen(25.0),
                                // maxWidth: size.wScreen(60.0) // Ancho máximo
                                ),
                            
                            child: 
                              Column(
                              children: [
                             
                                // messaje['message_text'].isNotEmpty? _messajeTexto( messaje['message_text'],size):Container(),
                                // messaje['message_fotos'].isNotEmpty? _messajeImagen(context,messaje['message_fotos'],size):Container(),
                                   messaje['message_text'].isNotEmpty? Container(
                                    constraints: BoxConstraints(
                                // minHeight: size.wScreen(1.0), // Altura mínima
  
                                minWidth: size.wScreen(5.0),
                                maxWidth: size.wScreen(60.0) // Ancho máximo
                                ),
                                    // width:size.iScreen(25)
                                  
                                margin: EdgeInsets.symmetric(vertical:size.iScreen(0.2)),child: _messajeTexto( messaje['message_text'],size,context)):Container(),
                                messaje['message_fotos'].isNotEmpty?Container(margin: EdgeInsets.symmetric(vertical:size.iScreen(0.5)),child: _messajeImagen(context, messaje['message_fotos'],size)):Container(),
                                 messaje['message_videos'].isNotEmpty? Container(margin: EdgeInsets.symmetric(vertical:size.iScreen(0.5)),child: _messajeVideo(context,messaje['message_videos'],size)):Container(),
                                    messaje['message_audio'].isNotEmpty? Container(margin: EdgeInsets.symmetric(vertical:size.iScreen(0.5)),child: _messajeAudio(context,messaje['message_audio'],size)):Container(),
                                
                              ],
                            )
                                        
                                        ),
                        SizedBox(
                          height: size.wScreen(4.0),
                        )
                      ],
                    ),
                    Positioned(
                    
                      bottom: -3,
                      right: 0,
                      child: Text(
                      // '$_hora - ${messaje['message_id']}',
                       '$_hora',
                        style: GoogleFonts.poppins(
                          fontSize: size.iScreen(1.2),
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          // letterSpacing: -0.40,
                        ),
                        // textAlign: TextAlign.right,
  
                        // overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )),
          ],
        ),
        decoration: BoxDecoration(
            // color: Color(0xff4D9EF6),
            // color: Colors.red,
            borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}

class VideoListItem extends StatefulWidget {
  final String videoUrl;

  const VideoListItem({required this.videoUrl});

  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

   _betterPlayerController = BetterPlayerController(
  BetterPlayerConfiguration(
    autoPlay: false,
    fullScreenByDefault: false,
    controlsConfiguration: BetterPlayerControlsConfiguration(
      showControls: true,
      enableFullscreen: true,
      enableSubtitles: false,
      enableQualities: true,
      enableOverflowMenu: true,
    ),
  ),
  betterPlayerDataSource: BetterPlayerDataSource(
    BetterPlayerDataSourceType.network,
    widget.videoUrl,
    // No es necesario configurar DRM si no lo estás utilizando
  ),
);
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _betterPlayerController.play();
      },
      child: AspectRatio(
        aspectRatio: 16 / 9, // Puedes ajustar el aspect ratio según tus necesidades
        child: BetterPlayer(
          controller: _betterPlayerController,
        ),
      ),
    );
  }
}