import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:record_mp3/record_mp3.dart';
import 'package:record/record.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/view_video_page.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:video_player/video_player.dart';

// class VoiceRecorderScreen extends StatefulWidget {
//   @override
//   _VoiceRecorderScreenState createState() => _VoiceRecorderScreenState();
// }

// class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
//   bool isRecording = false;
//   late String filePath;
//   bool isPlaying = false;
//   double playbackTime = 0.0;
//   double playbackDuration = 1.0; // Inicia con un valor predeterminado

//   late Record _record;
//   AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     _record = Record();
//     _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
//       setState(() {
//         playbackTime = duration.inMilliseconds.toDouble();
//       });
//     });

//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         playbackDuration = duration.inMilliseconds.toDouble();
//       });
//     });
//   }

//   String _formatDuration(double milliseconds) {
//     Duration duration = Duration(milliseconds: milliseconds.round());
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$twoDigitMinutes:$twoDigitSeconds';
//   }

//   Future<void> _startRecording() async {
//     bool hasPermission = await _record.hasPermission();
//     if (hasPermission) {
//       if (!isRecording) {
//         await _record.start();
//         setState(() {
//           isRecording = true;
//         });
//         _showRecordingModal();
//       }
//     } else {
//       // Handle permission denied
//       print('Permission denied to access the microphone.');
//     }
//   }

//   Future<void> _stopRecording() async {
//     if (isRecording) {
//       String? result = await _record.stop();
//       Navigator.of(context).pop(); // Cerrar el modal al detener la grabación
//       setState(() {
//         isRecording = false;
//         filePath = result!;
//       });
//       print('Recording saved at: $result');
//     }
//   }

//   void _showRecordingModal() {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Container(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.mic, size: 40, color: Colors.red),
//                   SizedBox(height: 16),
//                   Text(
//                     'Grabando...',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 16),
//                   IconButton(
//                     onPressed: () async {
//                       await _stopRecording();
//                     },
//                     icon: Icon(Icons.stop),
//                   ),
//                   SizedBox(height: 16),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Cerrar el modal sin detener la grabación
//                     },
//                     icon: Icon(Icons.cancel),
//                   ),
//                   SizedBox(height: 16),
//                   IconButton(
//                     onPressed: () {
//                       // Lógica para enviar el archivo grabado
//                       print('Enviando archivo: $filePath');
//                     },
//                     icon: Icon(Icons.send),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<void> _playRecordedFile() async {
//     if (File(filePath).existsSync()) {
//       await _audioPlayer.play(filePath, isLocal: true);
//       setState(() {
//         isPlaying = true;
//       });
//     } else {
//       print('File not found: $filePath');
//     }
//   }

//   Future<void> _stopPlaying() async {
//     await _audioPlayer.stop();
//     setState(() {
//       isPlaying = false;
//     });
//   }

//   @override
//   void dispose() {
//     _record.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Voice Recorder'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: () async {
//                 if (isRecording) {
//                   await _stopRecording();
//                 } else {
//                   await _startRecording();
//                 }
//               },
//               icon: Icon(isRecording ? Icons.stop : Icons.mic),
//               iconSize: 40,
//               color: isRecording ? Colors.red : null,
//             ),
//             SizedBox(height: 20),
//             // IconButton(
//             //   onPressed: () async {
//             //     if (isPlaying) {
//             //       await _stopPlaying();
//             //     } else {
//             //       await _playRecordedFile();
//             //     }
//             //   },
//             //   icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
//             //   iconSize: 40,
//             // ),
//             // SizedBox(height: 20),
//             // Text(
//             //   _formatDuration(playbackTime) +
//             //       ' / ' +
//             //       _formatDuration(playbackDuration),
//             //   // style: TextStyle(fontSize: 16),
//             // ),
//             Container(
//               color:  Colors.grey.shade200,
//               width: size.wScreen(100),
//               margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       InkWell(onTap:  () async {
//                 if (isPlaying) {
//               await _stopPlaying();
//                 } else {
//               await _playRecordedFile();
//                 }
//               },child: Container(
//                 // color:  Colors.green,
//               child: Icon(isPlaying ? Icons.stop : Icons.play_arrow,size: size.iScreen(3.5),))),
//                       Expanded(
//                         child: Slider(
//                           activeColor: Colors.red,
//                           thumbColor: Colors.pink,
//                           min: 0,
//                           value: playbackTime,
//                           max: playbackDuration,
//                           onChanged: (double value) {
//                             _audioPlayer.seek(Duration(milliseconds: value.toInt()));
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                    Row(
//                      children: [
//                        Text(
//                 _formatDuration(playbackTime) +
//                 ' / ' +
//                 _formatDuration(playbackDuration),
//                 style: GoogleFonts.poppins(
//                       fontSize: size.iScreen(1.5),
//                       fontWeight: FontWeight.normal,
//                       color: Colors.black,
//                       letterSpacing: -0.40,
//                     ),
//               ),
//                      ],
//                    ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _control=context.read<HomeController>();
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('prueba'),),
        body: Column(
          children: [
            // CabecerasApp(size:size,colorBase:Colors.white,title:'REGISTRO',onTap:(){
            //   // Navigator.pop(context);
            // },),
   //***********************************************/
    
                          SizedBox(
                            height: size.iScreen(0.0),
                          ),
                          //*****************************************/
                          Container(
                              //  color: Colors.green,
                                    width: size.wScreen(80.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    // color: Colors.red,
                                    width: size.wScreen(65.0),
                                    padding: EdgeInsets.all(size.wScreen(0.0)),
                                    child: Container(
                                      // width: size.wScreen(30.0),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.hScreen(0.5),
                                            vertical: size.iScreen(0.0)),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                    
                                          // border: Border.all(
                                          //   color: Colors.grey,
                                          //   width: 1.0,
                                          // ),
                                        ),
                                        child: 
                                        
                                      
                                          TextFormField(
                                             
                                          
                                          maxLength: 13,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          decoration: InputDecoration(
                                            suffixIcon: const Icon(Icons.assignment_ind),
                                            hintText: 'CÉDULA',
                                            // border: InputBorder.none,
                                            contentPadding: const EdgeInsets.fromLTRB(
                                                10.0, 15.0, 0.0, 0.0),
                                            focusedBorder: const OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: Colors.grey)),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                    
                                            // labelText: 'Nome',
                                          ),
                                          onChanged: (text) {
                                            _control.setItemCedua(text.trim());
                                          },
                                        )
                                       
                                        
                                       ),
                                  ),
                                ),
                                Container(
                                 height: size.iScreen(5.0),
                                  decoration: BoxDecoration(
                                    
                                    color: tercearyColor,
                                    border: Border.all(color: tercearyColor),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                
                                  child: IconButton(
                                    // splashColor:tercearyColor ,
                                    splashRadius: 20,
                                    onPressed: () async{
                                        ProgressDialog.show(context);
            final response = await _control. verificaCedulaCliente(context);
            ProgressDialog.dissmiss(context);


if (response != null  ) {
   _control.setItemNombre(response['nombre']) ;
                         Navigator.pop(context);
//  showDialog(
//           // barrierDismissible :false,
//             context: context,
//             builder: (context) {
//               // final controllerMulta = context.read<MultasGuardiasContrtoller>();
          
//               return AlertDialog(
                
//                 title: const Text('Datos Encontrados'),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [

//                      Text('${response['nombre']}'),
//                   ],
//                 ),
//                 actions: <Widget>[
                 
//                   TextButton(
//                       onPressed: ()  {
                       
//                          _control.setItemNombre(response['nombre']) ;
//                          Navigator.pop(context);
//                       },
//                       child: Text(
//                         'Aceptar',
//                         style: GoogleFonts.lexendDeca(
//                             fontSize: size.iScreen(1.8),
//                             // color: Colors.white,
//                             fontWeight: FontWeight.normal),
//                       )),
//                 ],
//               );
//             });

}
                                  
                                  }, icon: Icon(Icons.search,color: Colors.white,)),
                                )
                              ],
                            ),
                          ),


          ],
        ),
      ),
    );
  }
}
