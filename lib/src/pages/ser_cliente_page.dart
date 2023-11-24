

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class SerClientePage extends StatelessWidget {
  const SerClientePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      body: Container(
          width: size.wScreen(100.0),
          height: size.hScreen(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


 SizedBox(
            height: size.hScreen(60),
            width:size.wScreen(100),
            // color: Colors.blue, // Puedes ajustar el color según tus preferencias
            child: Image.asset(
              'assets/imgs/banner1.jpeg',fit: BoxFit.cover, // URL de la imagen
             
            ),
          ),
          // Segundo Container (40% de la pantalla)
          Container(
            height: size.hScreen(40),
            width:size.wScreen(100),
            // color: Colors.green, // Puedes ajustar el color según tus preferencias
            // Puedes agregar contenido adicional en este contenedor
            child: Column(
              children: [
                SizedBox(
                height: size.hScreen(4.0),
              ),
               SizedBox(
                width: size.wScreen(80),
                height: size.hScreen(8.0),
                child: Text(
                  'Internet por Fibra Óptica',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: size.iScreen(2.0),
                      fontWeight: FontWeight.w500,
                      color: secondaryColor),
                ),
              ),
              BotonBase(size: size,label: 'QUIERO SER CLIENTE',),
              SizedBox(
                height: size.hScreen(4.0),
              ),
              Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: 'Ya soy cliente. ',
        style: 
        // TextStyle(
        //   color: Color(0xFF080623),
        //   fontSize: 12,
        //   fontFamily: 'Poppins',
        //   fontWeight: FontWeight.w400,
        //   height: 0.08,
        // ),
        GoogleFonts.poppins(
                        fontSize: size.iScreen(1.5),
                        fontWeight: FontWeight.w400,
                        // color: Colors.white
                       
                        ),
      ),
      TextSpan(
        text: ' ',
        style: 
        // TextStyle(
        //   color: Color(0xFF24A59E),
        //   fontSize: 12,
        //   fontFamily: 'Poppins',
        //   fontWeight: FontWeight.w600,
        //   height: 0.08,
        // ),
         GoogleFonts.poppins(
                        fontSize: size.iScreen(1.5),
                        fontWeight: FontWeight.w600,
                        // color: Colors.white
                       
                        ),
      ),
      TextSpan(
        text: 'INICIAR SESIÓN',
        style: TextStyle(
          color: Color(0xFFB32523),
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: 0.08,
        ),
      ),
    ],
  ),
)
              ],
            ),
          ),
            ],
          )),
    );
  }
}


