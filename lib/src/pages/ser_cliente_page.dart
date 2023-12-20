import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/registro_page.dart';
import 'package:ultrared/src/pages/selecciona_sector.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class SerClientePage extends StatelessWidget {
  const SerClientePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      backgroundColor: cuaternaryColor,
      
      body: Container(
          width: size.wScreen(100.0),
          height: size.hScreen(100.0),
          child: SingleChildScrollView(
            child: 
            Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                Container(
                  height: size.hScreen(60),
                  width: size.wScreen(100),
                  // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                  child: Image.asset(
                    'assets/imgs/Banner.png',
                    fit: BoxFit.cover, // URL de la imagen
                  ),
                ),
                 
                // Segundo Container (40% de la pantalla)
                Container(
                  // color:Colors.red,
                  height: size.hScreen(40),
                  width: size.wScreen(100),
                  // color: Colors.green, // Puedes ajustar el color según tus preferencias
                  // Puedes agregar contenido adicional en este contenedor
                  child: Stack(
                    children: [
                      Column(
                        children: [
                            SizedBox(
                            height: size.hScreen(0.0),
                          ),
                          BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Ajusta los valores según sea necesario
                child: Container(
                      color: Colors.transparent,
                ),
              ),
          
                          // Container(
                          // height: size.hScreen(8),
                          // width: size.wScreen(100),
                          // padding:
                          //     EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                                  
                          // // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                          // child: Image.asset(
                          //   'assets/imgs/letras_UR.png', scale: 1.0,
                          //   fit: BoxFit.contain, // URL de la imagen
                          // ),
                          //                       ),
                         
                          SizedBox(
                          height: size.hScreen(11.0),
                        ),
                          SizedBox(
                            width: size.wScreen(80),
                            height: size.hScreen(6.0),
                            child: Text(
                              'Seguridad Móvil',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(2.1),
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor),
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              //      final _ctrlHome= context.read<HomeController>();
                              //   _ctrlHome.resetAllValues();
                              
                              // Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: ((context) =>
                              //                       const RegistroPage(action: 'CREATE',))));
                                   final _ctrlHome= context.read<HomeController>();
                                _ctrlHome.resetAllValues();
                                _ctrlHome.setItemLugarServicio('HOGAR');
                              
                              Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const SeleccionaSector(action: 'CREATE',))));
                            },
                              child: BotonBase(
                            size: size,
                            label: 'NUEVO USUARIO',
                          )),
                          SizedBox(
                            height: size.hScreen(4.0),
                          ),
          
         
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    LoginPage())));
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Ya soy cliente. ',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.iScreen(1.5),
                                      fontWeight: FontWeight.w400,
                                      // color: Colors.white
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'INICIAR SESIÓN',
                                    style: TextStyle(
                                      color: Color(0xFFB32523),
                                      fontSize: size.iScreen(1.5),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: size.iScreen(0.1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                           Container(
                          height: size.hScreen(10),
                          width: size.wScreen(100),
                          padding:
                              EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                                  
                          // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Provider to  ', style: TextStyle(
                                      color: Color(0xFF080623),
                                      fontSize: size.iScreen(1.7),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: size.iScreen(0.1),
                                    ),),
                              Container(
                                height: size.iScreen(4.0),
                                child: Image.asset(
                                  'assets/imgs/LetrasNegro.png', scale: 1.0,
                                  fit: BoxFit.contain, // URL de la imagen
                                ),
                              ),
                            ],
                          ),
                                                )
                        ],
                      ),
                      Positioned( 
                        top: -4.0,
                        child:  Container(
                          height: size.hScreen(12),
                          width: size.wScreen(100),
                          padding:
                              EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                                  
                          // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                          child: Image.asset(
                            'assets/imgs/letras_UR.png', scale: 1.0,
                            fit: BoxFit.contain, // URL de la imagen
                          ),
                                                ),)
                    ],
                  ),
                ),
              ],
            ),
          
          
          
      //     Column(
      //   children: [
      //     // Primer contenedor que ocupa el 60% de la pantalla
      //     Container(
      //       width: size.wScreen(100.0),
      //     height: size.hScreen(60.0),
      //       child: Container(
      //         color: Colors.blue,
      //         child: Image.network(
      //           'https://pbs.twimg.com/media/CFUO8nQUsAATjgm?format=jpg&name=medium', // Reemplaza con la URL de tu imagen
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //     // Segundo contenedor que ocupa el 40% de la pantalla
      //     Container(
      //        width: size.wScreen(100.0),
      //     height: size.hScreen(40.0),
      //       child: Container(
      //         color: Colors.green,
      //         padding: EdgeInsets.all(16.0),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             // Dos input text
      //             TextField(
      //               decoration: InputDecoration(labelText: 'Ingrese texto 1'),
      //             ),
      //             SizedBox(height: 16.0),
      //             TextField(
      //               decoration: InputDecoration(labelText: 'Ingrese texto 2'),
      //             ),
      //             SizedBox(height: 16.0),
      //             // Botón
      //             ElevatedButton(
      //               onPressed: () {
      //                 // Acción al presionar el botón
      //               },
      //               child: Text('Enviar'),
      //             ),
      //             SizedBox(height: 16.0),
      //             // Imagen en el segundo contenedor
      //             Image.network(
      //               'https://pbs.twimg.com/media/CFUO8nQUsAATjgm?format=jpg&name=medium', // Reemplaza con la URL de tu imagen
      //               width: double.infinity,
      //               height: 100.0,
      //               fit: BoxFit.cover,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    
    
    
    
    
    )
          
          
          )
    );
  }
}
