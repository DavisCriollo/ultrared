

import 'dart:io';


import 'package:audioplayers/audioplayers.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:record_mp3/record_mp3.dart';
import 'package:record/record.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/pages/view_video_page.dart';
import 'package:ultrared/src/utils/responsive.dart';
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


// class VoiceRecorderScreen extends StatefulWidget {
//   @override
//   _VoiceRecorderScreenState createState() => _VoiceRecorderScreenState();
// }

// class RecorderState with ChangeNotifier {
//   bool isRecording = false;
//   String filePath = '';
//   double playbackTime = 0.0;
//   double playbackDuration = 1.0; // Inicia con un valor predeterminado
//   bool _isPlaying = false; // Nuevo campo

//   // Getter para isPlaying
//   bool get isPlaying => _isPlaying;

//   // Setter para isPlaying
//   set isPlaying(bool value) {
//     _isPlaying = value;
//     notifyListeners();
//   }

//   // Método para notificar a los oyentes cuando hay cambios en el estado
//   void notify() {
//     notifyListeners();
//   }

//   Future<void> startRecording(BuildContext context, record, AudioPlayer audioPlayer) async {
//     bool hasPermission = await record.hasPermission();
//     if (hasPermission) {
//       if (!isRecording) {
//         await record.start();
//         isRecording = true;
//         showRecordingModal(context);
//       }
//     } else {
//       // Handle permission denied
//       print('Permission denied to access the microphone.');
//     }
//     notify(); // Notificar cambios en el estado
//   }

//   Future<void> stopRecording(Record record, BuildContext context) async {
//     if (isRecording) {
//       String? result = await record.stop();
//       Navigator.of(context).pop(); // Cerrar el modal al detener la grabación
//       isRecording = false;
//       filePath = result!;
//       print('Recording saved at: $result');
//     }
//     notify(); // Notificar cambios en el estado
//   }

//   Future<void> playRecordedFile(AudioPlayer audioPlayer) async {
//     if (File(filePath).existsSync()) {
//       await audioPlayer.play(filePath, isLocal: true);
//       isPlaying = true;
//     } else {
//       print('File not found: $filePath');
//     }
//     notify(); // Notificar cambios en el estado
//   }

//   Future<void> stopPlaying(AudioPlayer audioPlayer) async {
//     await audioPlayer.stop();
//     isPlaying = false;
//     notify(); // Notificar cambios en el estado
//   }

//   String formatDuration(double milliseconds) {
//     Duration duration = Duration(milliseconds: milliseconds.round());
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$twoDigitMinutes:$twoDigitSeconds';
//   }

//   void showRecordingModal(BuildContext context) {
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
//                       await stopRecording(Record(), context);
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
// }




// class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
//   late Record _record;
//   AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     _record = Record();
//     _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
//       recorderState.playbackTime = duration.inMilliseconds.toDouble();
//       recorderState.notify();
//     });

//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       recorderState.playbackDuration = duration.inMilliseconds.toDouble();
//       recorderState.notify();
//     });
//   }

//   ChatController recorderState = ChatController();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ChatController>(
//       create: (context) => recorderState,
//       child: Consumer<ChatController>(
//         builder: (context, state, child) {
//           final Responsive size = Responsive.of(context);
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Voice Recorder'),
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () async {
//                       if (recorderState.isRecording) {
//                         await recorderState.stopRecording(_record, context);
//                       } else {
//                         await recorderState.startRecording(context,_record, _audioPlayer);
//                       }
//                     },
//                     icon: Icon(recorderState.isRecording ? Icons.stop : Icons.mic),
//                     iconSize: 40,
//                     color: recorderState.isRecording ? Colors.red : null,
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     color: Colors.grey.shade200,
//                     width: size.wScreen(100),
//                     margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () async {
//                                 if (recorderState.isPlaying) {
//                                   await recorderState.stopPlaying(_audioPlayer);
//                                 } else {
//                                   await recorderState.playRecordedFile(_audioPlayer);
//                                 }
//                               },
//                               child: Container(
//                                 child: Icon(recorderState.isPlaying ? Icons.stop : Icons.play_arrow, size: size.iScreen(3.5)),
//                               ),
//                             ),
//                             Expanded(
//                               child: Slider(
//                                 activeColor: Colors.red,
//                                 thumbColor: Colors.pink,
//                                 min: 0,
//                                 value: recorderState.playbackTime,
//                                 max: recorderState.playbackDuration,
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
//                               recorderState.formatDuration(recorderState.playbackTime) +
//                                   ' / ' +
//                                   recorderState.formatDuration(recorderState.playbackDuration),
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// class VoiceRecorderScreen extends StatefulWidget {
//   @override
//   _VoiceRecorderScreenState createState() => _VoiceRecorderScreenState();
// }

// // class RecorderState with ChangeNotifier {
//  class RecorderState with ChangeNotifier {
//   bool isRecording = false;
//   String filePath = '';
//   double playbackTime = 0.0;
//   double playbackDuration = 1.0;
//   bool _isPlaying = false;
//   bool _isInternetAudioPlaying = false;
//   bool _isInternetAudioPaused = false; // Nuevo campo
//   double _internetAudioPlaybackTime = 0.0;
//   double _internetAudioPlaybackDuration = 1.0;

//   // Getter y Setter para isPlaying
//   bool get isPlaying => _isPlaying;
//   set isPlaying(bool value) {
//     _isPlaying = value;
//     notifyListeners();
//   }

//   // Getter y Setter para isInternetAudioPlaying
//   bool get isInternetAudioPlaying => _isInternetAudioPlaying;
//   set isInternetAudioPlaying(bool value) {
//     _isInternetAudioPlaying = value;
//     notifyListeners();
//   }

//   // Getter y Setter para isInternetAudioPaused
//   bool get isInternetAudioPaused => _isInternetAudioPaused;
//   set isInternetAudioPaused(bool value) {
//     _isInternetAudioPaused = value;
//     notifyListeners();
//   }

//   // Getter y Setter para internetAudioPlaybackTime
//   double get internetAudioPlaybackTime => _internetAudioPlaybackTime;
//   set internetAudioPlaybackTime(double value) {
//     _internetAudioPlaybackTime = value;
//     notifyListeners();
//   }

//   // Getter y Setter para internetAudioPlaybackDuration
//   double get internetAudioPlaybackDuration => _internetAudioPlaybackDuration;
//   set internetAudioPlaybackDuration(double value) {
//     _internetAudioPlaybackDuration = value;
//     notifyListeners();
//   }

//   // Método para notificar a los oyentes cuando hay cambios en el estado
//   void notify() {
//     notifyListeners();
//   }

//   Future<void> playInternetAudio(AudioPlayer audioPlayer, String audioUrl) async {
//     await audioPlayer.play(audioUrl);
//     isInternetAudioPlaying = true;
//     audioPlayer.onAudioPositionChanged.listen((Duration duration) {
//       internetAudioPlaybackTime = duration.inMilliseconds.toDouble();
//       notify();
//     });

//     audioPlayer.onDurationChanged.listen((Duration duration) {
//       internetAudioPlaybackDuration = duration.inMilliseconds.toDouble();
//       notify();
//     });
//     notify();
//   }

//   Future<void> stopInternetAudio(AudioPlayer audioPlayer) async {
//     await audioPlayer.stop();
//     isInternetAudioPlaying = false;
//     notify();
//   }

//   Future<void> pauseInternetAudio(AudioPlayer audioPlayer) async {
//     await audioPlayer.pause();
//     isInternetAudioPaused = true;
//     notify();
//   }

//   Future<void> resumeInternetAudio(AudioPlayer audioPlayer) async {
//     await audioPlayer.resume();
//     isInternetAudioPaused = false;
//     notify();
//   }

//   String formatDuration(double milliseconds) {
//     Duration duration = Duration(milliseconds: milliseconds.round());
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$twoDigitMinutes:$twoDigitSeconds';
//   }
// }
// class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
//   late Record _record;
//   AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     _record = Record();
//     _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
//       recorderState.playbackTime = duration.inMilliseconds.toDouble();
//       recorderState.notify();
//     });

//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       recorderState.playbackDuration = duration.inMilliseconds.toDouble();
//       recorderState.notify();
//     });
//   }

//   RecorderState recorderState = RecorderState();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<RecorderState>(
//       create: (context) => recorderState,
//       child: Consumer<RecorderState>(
//         builder: (context, state, child) {
//           final Responsive size = Responsive.of(context);
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Voice Recorder'),
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     onPressed: () async {
//                       // if (recorderState.isRecording) {
//                       //   await recorderState.stopRecording(_record, context);
//                       // } else {
//                       //   await recorderState.startRecording(_record, _audioPlayer);
//                       // }
//                     },
//                     icon: Icon(recorderState.isRecording ? Icons.stop : Icons.mic),
//                     iconSize: 40,
//                     color: recorderState.isRecording ? Colors.red : null,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       // Reemplaza la URL con la URL real del archivo de audio en Internet
//                       String audioUrl = "https://documentos.neitor.com/contable/chats/ULTRA2022/cade09f3-e2a1-4225-8b92-5f4585653ffb.ogg";
//                       await recorderState.playInternetAudio(_audioPlayer, audioUrl);
//                     },
//                     child: Text('Reproducir Audio desde Internet'),
//                   ),
//                   SizedBox(height: 20),
//                   Visibility(
//                     visible: recorderState.isInternetAudioPlaying,
//                     child: Container(
//                       color: Colors.grey.shade200,
//                       width: size.wScreen(100),
//                       margin: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () async {
//                                   if (recorderState.isInternetAudioPaused) {
//                                     await recorderState.resumeInternetAudio(_audioPlayer);
//                                   } else {
//                                     await recorderState.pauseInternetAudio(_audioPlayer);
//                                   }
//                                 },
//                                 icon: Icon(recorderState.isInternetAudioPaused ? Icons.play_arrow : Icons.stop),
//                               ),
//                               Expanded(
//                                 child: Slider(
//                                   activeColor: Colors.red,
//                                   thumbColor: Colors.pink,
//                                   min: 0,
//                                   value: recorderState.internetAudioPlaybackTime,
//                                   max: recorderState.internetAudioPlaybackDuration,
//                                   onChanged: (double value) {
//                                     _audioPlayer.seek(Duration(milliseconds: value.toInt()));
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 recorderState.formatDuration(recorderState.internetAudioPlaybackTime) +
//                                     ' / ' +
//                                     recorderState.formatDuration(recorderState.internetAudioPlaybackDuration),
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<String> _listaVideos = [
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    // Agrega los demás enlaces de tus videos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Videos"),
      ),
      body: ListView.builder(
        itemCount: _listaVideos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Video ${index + 1}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoUrl: _listaVideos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
