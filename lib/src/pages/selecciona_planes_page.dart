import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class SeleccionaPlanPage extends StatefulWidget {
  const SeleccionaPlanPage({Key? key}) : super(key: key);

  @override
  State<SeleccionaPlanPage> createState() => _SeleccionaPlanPageState();
}

class _SeleccionaPlanPageState extends State<SeleccionaPlanPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white, // Fondo blanco
          title: Text('REGISTRO',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
        ),
        body: Container(
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.hScreen(10),
                    width: size.wScreen(100),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),

                    // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                    child: Image.asset(
                      'assets/imgs/banner2.jpeg',
                      fit: BoxFit.cover, // URL de la imagen
                    ),
                  ),
                  //***********************************************/

                  SizedBox(
                    height: size.iScreen(1.0),
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
                          height: size.hScreen(2.0),
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
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        //***********************************************/
                        Container(
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.iScreen(2.0),
                              vertical: size.iScreen(2.0)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Espacio entre el icono y el texto
                              Container(
                                // color: Colors.red,
                                width: size.wScreen(60.0),
                                child: Text(
                                  'SELECCIONA TU PLAN  ',
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        16.0, // Ajusta según tus necesidades
                                    fontWeight: FontWeight.w400,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons
                                    .keyboard_arrow_down_outlined, // Cambia el icono según tus necesidades
                                color: Colors.grey, // Color del icono
                              ),
                            ],
                          ),

                          
                        ),
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(1.0),
                        ),
                        //*****************************************/
                        //***********************************************/
                        Container(
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.iScreen(2.0),
                              vertical: size.iScreen(2.0)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Espacio entre el icono y el texto
                              Container(
                                // color: Colors.red,
                                width: size.wScreen(60.0),
                                child: Text(
                                  'SELECCIONA TU PLAN  ',
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        16.0, // Ajusta según tus necesidades
                                    fontWeight: FontWeight.w400,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons
                                    .keyboard_arrow_down_outlined, // Cambia el icono según tus necesidades
                                color: Colors.grey, // Color del icono
                              ),
                            ],
                          ),

                          
                        ),
                       
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        Container(
                          // color: Colors.red,
                          width: size.wScreen(80.0),
                          padding: EdgeInsets.all(size.wScreen(0.0)),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                maxLength: 3,
                                decoration: const InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.account_circle_rounded),
                                  hintText: 'ESCRIBE TU SECTOR (OPCIONAL)',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(3.0),
                        ),
                        //*****************************************/
                        //***********************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                        BotonBase(
                          size: size,
                          label: 'SIGUIENTE',
                        ),

                        SizedBox(
                          height: size.hScreen(5.0),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '¿No recuerdas tu contraseña?. ',
                                style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.5),
                                  fontWeight: FontWeight.w400,
                                  // color: Colors.white
                                ),
                              ),
                              TextSpan(
                                text: 'RECUPÉRALA',
                                style: TextStyle(
                                  color: Color(0xFFB32523),
                                  fontSize: size.iScreen(1.3),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: size.iScreen(0.1),
                                ),
                              ),
                            ],
                          ),
                        )
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
