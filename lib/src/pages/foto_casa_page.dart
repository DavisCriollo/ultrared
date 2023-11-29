import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class FotosCasaPage extends StatefulWidget {
  const FotosCasaPage({Key? key}) : super(key: key);

  @override
  State<FotosCasaPage> createState() => _FotosCasaPageState();
}

class _FotosCasaPageState extends State<FotosCasaPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData( color: Colors.black),
           centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text('FOTO DE TU CASA',
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
                          height: size.hScreen(2.0),
                        ),
                        SizedBox(
                          width: size.wScreen(80),
                          // height: size.hScreen(8.0),
                          child: Text(
                             'Es necesaria la foto de tu casa para brindarte mejor asistencia cuando lo necesites. Te agradecemos tu comprensión.', 
                             textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: size.iScreen(1.7),
                                fontWeight: FontWeight.w500,
                                color: secondaryColor),
                          ),
                        ),
                        //***********************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                   
                       

                        Container(
                          width: size.wScreen(80.0),
                          height: size.hScreen(40.0),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: [
                              
                                 SizedBox(
                          width: size.wScreen(80),
                          // height: size.hScreen(8.0),
                          child: Center(
                            child: Column(
                              children: [
                               Icon( Icons.camera_alt_rounded,color:Colors.grey,size: size.iScreen(4.0),),
                                Text(
                                  'Tomar Foto',
                                  // textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.5),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                              ],
                            ),
                          ),
                        ),
                        //***********************************************/

                        //***********************************************/
                      
                        SizedBox(
                          height: size.iScreen(10.0),
                        ),
                        //*****************************************/
                        BotonBase(
                          size: size,
                          label: 'GUARDAR',
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
