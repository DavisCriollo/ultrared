

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
            width: size.wScreen(100.0),
            height: size.hScreen(100.0),
            child: SingleChildScrollView(
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
                                  //***********************************************/
                    Container(
                      // color: Colors.red,
                      width: size.wScreen(80.0),
                    padding:  EdgeInsets.all(size.wScreen(0.0)),
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
                  decoration: const InputDecoration(
                     suffixIcon:Icon(Icons.account_circle_rounded),
                    hintText: 'ESCRIBE TU USUARIO',
                    border: InputBorder.none,
                  ),
                ),
              ),
                    ),
                  ),
                                  //***********************************************/
            
                                  SizedBox(
                                    height: size.iScreen(1.0),
                                  ),
                                  //*****************************************/
                                  //***********************************************/
                    Container(
                      // color: Colors.red,
                      width: size.wScreen(80.0),
                    padding:  EdgeInsets.all(size.wScreen(0.0)),
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
                  // decoration: InputDecoration(
                    
                  //   hintText: 'Ingresa tu texto',
                  //   border: InputBorder.none,
                  
                  // ),
                    decoration: InputDecoration(
    
                          border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  //  filled: true, // Habilita el fondo lleno
                  // fillColor: Colors.grey[300], // Establece el color de fondo (gris)
                       hintText: 'INGRESA TU CONTRASEÑA',
                                    suffixIcon: IconButton(
                                        splashRadius: 5.0,
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        icon: _obscureText
                                            ? const Icon(
                                                Icons.visibility_off_outlined)
                                            : const Icon(
                                                Icons.remove_red_eye_outlined)),
                                  ),
                                     obscureText: _obscureText,
                                     
                ),
              ),
                    ),
                  ),
                                  //***********************************************/
            
                                  SizedBox(
                                    height: size.iScreen(1.5),
                                  ),
                                  //*****************************************/
                  BotonBase(size: size,label: 'INICIAR SESIÓN',),
                  
                  SizedBox(
                    height: size.hScreen(4.0),
                  ),
                  Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '¿No recuerdas tu contraseña?. ',
                    style: 
                  
                    GoogleFonts.poppins(
                            fontSize: size.iScreen(1.5),
                            fontWeight: FontWeight.w400,
                            // color: Colors.white
                           
                            ),
                  ),
             
                  TextSpan(
                    text: 'RECUPÉRALA',
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
              ),
            )),
      ),
    );
  }
}


