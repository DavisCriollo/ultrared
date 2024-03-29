import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class PreviewPhotoComprobante extends StatelessWidget {
  final String? infoImage;

  const PreviewPhotoComprobante({
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
          title: Text('Comprobante de Pago',
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

        child: SizedBox(
          width: size.wScreen(100.0),
          height: size.hScreen(100.0),
          child: 
          // Image.network('${infoImage!}',
          CachedNetworkImage(
    imageUrl: infoImage!,
    placeholder: (context, url) => const Center(child: CupertinoActivityIndicator(color:colorPrimario)), // Indicador de carga mientras se carga la imagen
    errorWidget: (context, url, error) => const Icon(Icons.error), // Widget a mostrar si ocurre un error al cargar la imagen
    fit: BoxFit.cover, // Ajuste de la imagen
  ),
         
        ),
           
          ),
        
      
    );
  }
}