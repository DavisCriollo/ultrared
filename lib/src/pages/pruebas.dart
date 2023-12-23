

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:record_mp3/record_mp3.dart';
import 'package:record/record.dart';




// class VoiceRecorderScreen extends StatefulWidget {
//   @override
//   _VoiceRecorderScreenState createState() => _VoiceRecorderScreenState();
// }

// class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
//   bool isRecording = false;
//   late String filePath;
//   bool isPlaying = false;

//   late Record _record;
//   AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     _record = Record();
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
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.mic, size: 40, color: Colors.red),
//               SizedBox(width: 16),
//               Text(
//                 'Grabando...',
//                 style: TextStyle(fontSize: 20),
//               ),
//               SizedBox(width: 16),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _stopRecording();
//                 },
//                 child: Text('Detener'),
//               ),
//             ],
//           ),
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
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Voice Recorder'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 if (isRecording) {
//                   await _stopRecording();
//                 } else {
//                   await _startRecording();
//                 }
//               },
//               child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (isPlaying) {
//                   await _stopPlaying();
//                 } else {
//                   await _playRecordedFile();
//                 }
//               },
//               child: Text(isPlaying ? 'Stop Playback' : 'Play Recorded File'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';



class VoiceRecorderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Consumer<ChatController>( builder: (_, value,__) { 
 return  ElevatedButton(
              onPressed: () async {
              
                if (value.isRecording) {
                  await value.stopRecording();
                } else {
                  await value.startRecording();
                }
                // Mostrar la modal
                _showRecordingModal(context);
              },
              child:  Text(value.isRecording ? 'Stop Recording' : 'Start Recording')
                
              
            );
             },),
           
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final provider = Provider.of<ChatController>(context, listen: false);
                if (provider.isPlaying) {
                  await provider.stopPlaying();
                } else {
                  await provider.playRecordedFile();
                }
              },
              child: Consumer<ChatController>(
                builder: (context, provider, child) {
                  return Text(provider.isPlaying ? 'Stop Playback' : 'Play Recorded File');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar la modal
  void _showRecordingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ChatController>(
          builder: (context, provider, child) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mic, size: 40, color: Colors.red),
                      SizedBox(width: 16),
                      Text(
                        'Grabando...',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: () async {
                         await provider.stopRecording();
    // Esperar a que se complete la grabación antes de imprimir la dirección del archivo
  
    // Navigator.of(context).pop()
                          // Navigator.of(context).pop(); // Cerrar la modal al detener la grabación
                        },
                        icon: Icon(Icons.stop),
                        tooltip: 'Detener Grabación',
                      ),
                      SizedBox(width: 16),
                      if (provider.isSendButtonVisible) // Mostrar el botón "Enviar" solo si se detuvo la grabación
                        IconButton(
                          onPressed: () async{
                            // Lógica para enviar el archivo grabado
                           await Future.delayed(Duration(milliseconds: 500)); // Puedes ajustar el tiempo de espera según sea necesario
    print('Enviando archivo: ${provider.filePath}');
      await provider.stopRecording();
                            // Cerrar la modal
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.send),
                          tooltip: 'Enviar',
                        ),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cerrar la modal sin detener la grabación
                        },
                        icon: Icon(Icons.cancel),
                        tooltip: 'Cancelar',
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}