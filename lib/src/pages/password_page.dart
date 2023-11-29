import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
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
          title: Text('CONTRASEÑA',
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
                  Container(
                    height: size.hScreen(8),
                    width: size.wScreen(100),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),

                    // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                    child: Image.asset(
                      'assets/imgs/LetrasNegro.png',
                      fit: BoxFit.contain, // URL de la imagen
                    ),
                  ),
                 // ***********************************************/

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
                        SizedBox(
                          width: size.wScreen(80),
                          height: size.hScreen(8.0),
                          child: Text(
                            'Internet por Fibra Óptica',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.w500,
                                color: secondaryColor),
                          ),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.hScreen(10.0),
                        ),
                       

                        //***********************************************/
                        SizedBox(
                          width: size.wScreen(80),
                          height: size.hScreen(8.0),
                          child: Text(
                           'Recupera tu Contraseña',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.w500,
                                
                                ),
                          ),
                        ),
                        //***********************************************/
                        SizedBox(
                          height: size.hScreen(1.0),
                        ),
                       

                        //***********************************************/
 
                        Container(
                          // color: Colors.red,
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.all(size.wScreen(0.0)),
                          child: Center(
                            child: Container(
                               padding: EdgeInsets.symmetric(  horizontal: size.hScreen(2.0), vertical: size.iScreen(0.0)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                // maxLength: 3,
                                decoration: const InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.email),
                                  hintText:    'ESCRIBE TU CORREO',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(20.0),
                        ),
                        //*****************************************/
                   
                       

                      
                        //***********************************************/

                      
                        BotonBase(
                          size: size,
                          label: 'ENVIAR',
                        ),

                        // SizedBox(
                        //   height: size.hScreen(5.0),
                        // ),
                         SizedBox(
                          height: size.hScreen(5.0),
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text: 'Ya tienes cuenta. ',
                        //         style: GoogleFonts.poppins(
                        //           fontSize: size.iScreen(1.5),
                        //           fontWeight: FontWeight.w400,
                        //           // color: Colors.white
                        //         ),
                        //       ),
                        //       TextSpan(
                        //         text: 'INICIAR SESIÓN',
                        //         style: TextStyle(
                        //           color: Color(0xFFB32523),
                        //           fontSize: size.iScreen(1.3),
                        //           fontFamily: 'Poppins',
                        //           fontWeight: FontWeight.w600,
                        //           height: size.iScreen(0.1),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // )
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
