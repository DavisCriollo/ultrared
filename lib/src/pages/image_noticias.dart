import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/fecha_local_convert.dart';

import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';

class InfoPublicidad extends StatelessWidget {
  final Map<String, dynamic>? infoPublicidad;

  const InfoPublicidad({
    Key? key,
    required this.infoPublicidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    String fechaLocal = DateUtility.fechaLocalConvert(infoPublicidad!['noti_fecreg']!.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true, // Centra el título en el AppBar
        elevation: 0,
        backgroundColor: cuaternaryColor, // Fondo blanco
        title: Text('${infoPublicidad!['noti_titulo']}',
            style: GoogleFonts.poppins(
              fontSize: size.iScreen(2.0),
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.40,
            ) // Color del título en negro
            ),
      ),
      body: Container(
         padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
        width: size.wScreen(100.0),
        height: size.hScreen(100.0),
        // color: Colors.red,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: size.iScreen(0.0)),
              width: size.wScreen(100.0),
              height: size.hScreen(40.0),
              child: InteractiveViewer(
                clipBehavior: Clip.hardEdge,
                alignPanAxis: false,
                boundaryMargin: EdgeInsets.zero,
                constrained: true,
                maxScale: 2.5,
                minScale: 0.8,
                child: Container(
                  // width: size.wScreen(100.0),
                  // height: size.hScreen(100.0),
                  child: CachedNetworkImage(
                    imageUrl: infoPublicidad!['noti_foto'],
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    // Image.asset(
                    //     'assets/imgs/loader.gif'),

                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
                  child: Column(
                    children: [
                      SizedBox(height: size.iScreen(1.0),),
                      Container(
                        
                              // color: Colors.yellow,
                        width: size.wScreen(100.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              //  color: Colors.yellow,
                              // width: size.wScreen(100.0),
                              //  height: size.hScreen(60.0),
                              child: Text(
                                'Fecha : ',
                                // textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.7),
                                  fontWeight: FontWeight.normal,
                                  color: octinaryColor,
                                ),
                              ),
                            ),
                            Container(
                              //  color: Colors.yellow,
                              // width: size.wScreen(100.0),
                              //  height: size.hScreen(60.0),
                              child: Text(
                                fechaLocal,
                                // textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.8),
                                  fontWeight: FontWeight.w400,
                                  color: octinaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
  Container(
                        //  color: Colors.yellow,
                        width: size.wScreen(100.0),
                        //  height: size.hScreen(60.0),
                        child: Text(
                          '${infoPublicidad!['noti_titulo']}',
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w700,
                            color: octinaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: size.iScreen(1.0),),
                      Container(
                        //  color: Colors.yellow,
                        width: size.wScreen(100.0),
                        //  height: size.hScreen(60.0),
                        child: Text(
                          '${infoPublicidad!['noti_descripcion']}',
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.8),
                            fontWeight: FontWeight.normal,
                            color: octinaryColor,
                          ),
                        ),
                      ),
                         
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
