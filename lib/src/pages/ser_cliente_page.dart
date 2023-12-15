import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/registro_page.dart';
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
                  child: Column(
                    children: [
                        SizedBox(
                        height: size.hScreen(2.0),
                      ),
          
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
                      GestureDetector(
                        onTap:(){
                               final _ctrlHome= context.read<HomeController>();
                            _ctrlHome.resetAllValues();
                          
                          Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const RegistroPage(action: 'CREATE',))));
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
                                  fontSize: size.iScreen(1.3),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: size.iScreen(0.1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
