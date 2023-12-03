import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/pages/foto_casa_page.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

import 'package:dotted_border/dotted_border.dart';


class AcercaDePage extends StatefulWidget {
  const AcercaDePage({Key? key}) : super(key: key);

  @override
  State<AcercaDePage> createState() => _AcercaDePageState();
}

class _AcercaDePageState extends State<AcercaDePage> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text('ACERCA DE',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
        ),
        body: Container(
            // alignment: Alignment.center,
            // color: Colors.red,

            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: size.hScreen(8),
                  //   width: size.wScreen(100),
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),

                  //   // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                  //   child: Image.asset(
                  //     'assets/imgs/LetrasNegro.png',
                  //     fit: BoxFit.contain, // URL de la imagen
                  //   ),
                  // ),
                  //***********************************************/

                  SizedBox(
                    height: size.iScreen(2.0),
                  ),
                  //*****************************************/
                  Container(
                    // height: size.hScreen(40),
                    width: size.wScreen(100),
                    // color: Colors.green, // Puedes ajustar el color según tus preferencias
                    // Puedes agregar contenido adicional en este contenedor
                    child: Column(
                      children: [
                        // SizedBox(
                        //   width: size.wScreen(80),
                        //   height: size.hScreen(8.0),
                        //   child: Text(
                        //     'Internet por Fibra Óptica',
                        //     textAlign: TextAlign.center,
                        //     style: GoogleFonts.poppins(
                        //         fontSize: size.iScreen(2.5),
                        //         fontWeight: FontWeight.w500,
                        //         color: secondaryColor),
                        //   ),
                        // ),
                        //***********************************************/
                        SizedBox(
                          height: size.hScreen(0.0),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric( horizontal: size.iScreen(4.0)),
                          padding: EdgeInsets.symmetric( horizontal: size.wScreen(3.0),vertical: size.wScreen(2.0)),
                      

                          // clipBehavior: Clip.antiAlias,
                          // decoration: ShapeDecoration(
                          //   shape: RoundedRectangleBorder(
                          //     side: BorderSide(
                          //         width: 01.0,
                          //         color: Colors.grey,
                          //     ),
                          //     borderRadius: BorderRadius.circular(8),
                          //   ),
                          // ),
                          // height: size.hScreen(8.0),

                          child: 
      //                     DottedBorder(
      //                        dashPattern: [8, 4],
      // strokeWidth: 2,
      //                       child: Text(
      //                         'UltraRED es una innovadora aplicación de múltiples propósitos diseñada para proporcionarte internet ultra rápido por fibra óptica.\n\nCon un enfoque en seguridad, nuestra aplicación ofrece una experiencia integral y fácil de usar para todo tipo de usuarios.',
      //                         textAlign: TextAlign.center,
      //                         style: GoogleFonts.poppins(
      //                             fontSize: size.iScreen(1.7),
      //                             fontWeight: FontWeight.w500,
      //                             color: secondaryColor),
      //                       ),
      //                     ),


DottedBorder(
      borderType: BorderType.RRect,
      color :const Color(0xFF9B9B9B),
      dashPattern : const <double>[5, 5],
         strokeWidth: 2,
         strokeCap : StrokeCap.butt,
      radius: Radius.circular(8),
      padding: EdgeInsets.all(size.iScreen(2.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: size.hScreen(50.0),
         width: size.wScreen(100.0),
         
          child: Text(
                              'UltraRED es una innovadora aplicación de múltiples propósitos diseñada para proporcionarte internet ultra rápido por fibra óptica.\n\nCon un enfoque en seguridad, nuestra aplicación ofrece una experiencia integral y fácil de usar para todo tipo de usuarios.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.7),
                                  fontWeight: FontWeight.w500,
                                 color: const Color(0xFFA5A6AC),)
                            ),
        ),
      ),
    )



                        ),
                        //***********************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(10.0),
                        ),
                        //*****************************************/
                        GestureDetector(
                          onTap: () {
                           Navigator.pop(context);
                          },
                          child: BotonBase(
                            size: size,
                            label: 'ACEPTAR',
                          ),
                        ),

                        // SizedBox(
                        //   height: size.hScreen(5.0),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
