import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController _textRecuperaPasword = TextEditingController();
  @override
  void dispose() {
    _textRecuperaPasword.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _control = context.read<HomeController>();

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: cuaternaryColor,
          // appBar: AppBar(
          //   iconTheme: const IconThemeData(color: Colors.black),
          //   centerTitle: true, // Centra el título en el AppBar
          //   elevation: 0,
          //   backgroundColor: cuaternaryColor, // Fondo blanco
          //   title: Text('CONTRASEÑA',
          //       style: GoogleFonts.poppins(
          //         fontSize: size.iScreen(2.0),
          //         fontWeight: FontWeight.w700,
          //         color: Colors.black,
          //         letterSpacing: -0.40,
          //       ) // Color del título en negro
          //       ),
          // ),
          
          body: Container(
              // alignment: Alignment.center,
              // color: Colors.red,
    
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
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
    
                        // ***********************************************/
    
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
                        // Container(
                        //   // color:  Colors.red,
                        //   child: Column(
                        //     children: [
                        //        Container(
                        //     height: size.hScreen(15.0),
                        //     width: size.wScreen(100),
                        //     padding:
                        //        EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
    
                        //     // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                        //     child: Image.asset(
                        //       'assets/imgs/letras_UR.png', scale: 1.0,
                        //       fit: BoxFit.contain, // URL de la imagen
                        //     ),
                        //   ),
                        //       SizedBox(
                        //         width: size.wScreen(80),
                        //         height: size.hScreen(6.0),
                        //         child: Text(
                        //           'Seguridad Móvil',
                        //           textAlign: TextAlign.center,
                        //           style: GoogleFonts.poppins(
                        //               fontSize: size.iScreen(2.5),
                        //               fontWeight: FontWeight.w500,
                        //               color: secondaryColor),
                        //         ),
                        //       ),
                             
                        //     ],
                        //   ),
                        // ),
                          CabecerasApp(size: size, colorBase:cuaternaryColor , title: 'CONTRASEÑA',onTap:(){
                          Navigator.pop(context);
                        }),
                        //***********************************************/
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.hScreen(2.0),
                                        vertical: size.iScreen(0.0)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _textRecuperaPasword,
                                      // maxLength: 1,
                                      decoration: const InputDecoration(
                                        suffixIcon: Icon(Icons.assignment_ind),
                                        hintText: 'ESCRIBE TU USUARIO',
                                        border: InputBorder.none,
                                      ),
                                      // keyboardType: TextInputType.number,
                                      // inputFormatters: <TextInputFormatter>[
                                      //   FilteringTextInputFormatter.allow(
                                      //       RegExp(r'[0-9]')),
                                      // ],
                                      onChanged: (text) {
                                        _control.setItemCedulaRecupera(text.trim());
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              //***********************************************/
    
                              SizedBox(
                                height: size.iScreen(10.0),
                              ),
                              //*****************************************/
    
                              //***********************************************/
    
                              GestureDetector(
                                onTap: () {
                                  _onSubmit(context, _control, size);
                                },
                                child: BotonBase(
                                  size: size,
                                  label: 'ENVIAR',
                                ),
                              ),
    
                            
                              SizedBox(
                                height: size.hScreen(10.0),
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
                  ),
                  // Positioned(
                  //     bottom: 0.0,
                  //      child: 
                  //      Container(
                  //                 height: size.hScreen(10),
                  //                 width: size.wScreen(100),
                  //                 padding:
                  //                     EdgeInsets.symmetric(horizontal: size.iScreen(0.0)),
                                          
                  //                 // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Text('Provider to  ', style: TextStyle(
                  //                             color: Color(0xFF080623),
                  //                             fontSize: size.iScreen(1.7),
                  //                             fontFamily: 'Poppins',
                  //                             fontWeight: FontWeight.w400,
                  //                             height: size.iScreen(0.1),
                  //                           ),),
                  //                     Container(
                  //                       height: size.iScreen(4.0),
                  //                       child: Image.asset(
                  //                         'assets/imgs/LetrasNegro.png', scale: 1.0,
                  //                         fit: BoxFit.contain, // URL de la imagen
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                                       ),
                  //    ),
                ],
              )),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context, HomeController controller, size) async {
    if (controller.getItemCedulaRecupera!.length < 10) {
      NotificatiosnService.showSnackBarDanger('Falta agregar  información');
    } else {
      ProgressDialog.show(context);
      final response = await controller.buscaRecuperaClave();
      ProgressDialog.dissmiss(context);
      if (response != null) {
        //  NotificatiosnService.showSnackBarSuccsses('${response['msg']}');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute<void>(
        //         builder: (BuildContext context) => const HomePage()));
        _modalMessageResponse(context, response['msg'], size);
        _textRecuperaPasword.text = '';
      } else {
        NotificatiosnService.showSnackBarError(
            'No se pudo realizar la petición');
      }
    
    }
  }

  Future<void> _modalMessageResponse(
      BuildContext context, String _message, Responsive size) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Center(child: Text('Información')),
          content: SizedBox(
            // height: size.hScreen(50.0),
            width: double.maxFinite,
            child: ListTile(
             
              title: Text(_message),
            ),
          ),
          actions: <Widget>[
            Container(
              width: size.wScreen(80),
              color: colorPrimario,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  Navigator.pop(context);
                },
                child: const Text('OK',style: TextStyle(color: Colors.white),),
              ),
            )
          ]),
    );
  }
}
