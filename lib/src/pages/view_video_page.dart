import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:video_player/video_player.dart';

// class VideoScreenPage extends StatefulWidget {
//    final  String urlVideo;
//   const VideoScreenPage({Key? key, required this.urlVideo}) : super(key: key);

//   @override
//   State<VideoScreenPage> createState() => _VideoScreenPageState();
// }

// class _VideoScreenPageState extends State<VideoScreenPage> {
//   @override
//   Widget build(BuildContext context) {
//     Responsive size = Responsive.of(context);
  

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           'Video',
//           style: Theme.of(context).textTheme.headline2,
//         ),
//       ),
//       body: Container(
//         color: primaryColor,
//         width: size.wScreen(100),
//         height: size.hScreen(100),
//         child: BetterPlayer.network(
//           widget.urlVideo,
//           betterPlayerConfiguration: const BetterPlayerConfiguration(
//             aspectRatio: 16 / 16,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(widget.videoUrl);
    await _controller.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      customControls: MaterialControls(),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reproductor de Video"),
      ),
      body: _controller.value.isInitialized
          ? Chewie(controller: _chewieController)
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}