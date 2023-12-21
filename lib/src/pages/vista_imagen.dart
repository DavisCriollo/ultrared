import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class PreviewPhoto extends StatelessWidget {
  final Map<String,dynamic>? infoImage;

  const PreviewPhoto({
    Key? key,
   required this.infoImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      appBar:AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text('FOTO ${infoImage!['lugar']}',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
        ),
      body: InteractiveViewer(
        clipBehavior :Clip.hardEdge,
  alignPanAxis :false,
   boundaryMargin :EdgeInsets.zero,
   constrained :true,
 maxScale :2.5,
 minScale :0.8,

        child: Hero(
          tag: infoImage!['id'].toString(),
          child: SizedBox(
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            child: Image.network(infoImage!['url'],
         
          ),
             
            ),
          ),
        ),
      
    );
  }
}