

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


class AudioProvider with ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  double _position = 0.0;
  double _duration = 1.0; // Inicializado en 1.0 para evitar la división por cero

  bool get isPlaying => _isPlaying;
  double get position => _position;
  double get duration => _duration;

  void play(String url) async {
    if (_isPlaying) {
      _audioPlayer.stop();
    } else {
      await _audioPlayer.play(url);
      _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
        _position = duration.inMilliseconds.toDouble();
        notifyListeners();
      });

      _audioPlayer.onDurationChanged.listen((Duration duration) {
        _duration = duration.inMilliseconds.toDouble();
        notifyListeners();
      });
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void seek(double value) {
    if (_isPlaying) {
      _audioPlayer.seek(Duration(milliseconds: value.toInt()));
    }
  }

  void stop() {
    _audioPlayer.stop();
    _isPlaying = false;
    _position = 0.0;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final List<String> _lista = [
    'https://documentos.neitor.com/contable/chats/ULTRA2022/4579c25b-e05e-4453-b81e-529e24f6c8fd.m4a',
    // Agrega el resto de los enlaces aquí
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => AudioProvider(),
          child: AudioListView(_lista),
        ),
      ),
    );
  }
}

class AudioListView extends StatelessWidget {
  final List<String> _lista;

  AudioListView(this._lista);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _lista.length,
      itemBuilder: (context, index) {
        return AudioListItem(_lista[index]);
      },
    );
  }
}

class AudioListItem extends StatelessWidget {
  final String _audioUrl;

  AudioListItem(this._audioUrl);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Audio ${_audioUrl.split('/').last}'),
          subtitle: Consumer<AudioProvider>(
            builder: (context, audioProvider, child) {
              return Row(
                children: [
                  IconButton(
                    icon: Icon(audioProvider.isPlaying ? Icons.stop : Icons.play_arrow),
                    onPressed: () {
                      var audioProvider = Provider.of<AudioProvider>(context, listen: false);
                      audioProvider.play(_audioUrl);
                    },
                  ),
                  Expanded(
                    child: Slider(
                      value: audioProvider.position,
                      max: audioProvider.duration,
                      onChanged: (value) {
                        audioProvider.seek(value);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Consumer<AudioProvider>(
            builder: (context, audioProvider, child) {
              return Text(
                '${_formatDuration(audioProvider.position.toInt())} / ${_formatDuration(audioProvider.duration.toInt())}',
                style: TextStyle(fontSize: 12),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatDuration(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}