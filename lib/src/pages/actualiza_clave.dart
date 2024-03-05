import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/inicial.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';
import 'package:ultrared/src/service/notification_push.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';

class ActualizaClave extends StatefulWidget {
  const ActualizaClave({Key? key}) : super(key: key);

  @override
  State<ActualizaClave> createState() => _ActualizaClaveState();
}

class _ActualizaClaveState extends State<ActualizaClave> {
  TextEditingController _textRecuperaPasword = TextEditingController();
  @override
  void dispose() {
    _textRecuperaPasword.clear();
    super.dispose();
  }
 bool _obscureTextClaveA = true;
 bool _obscureTextClaveB = true;
 bool _obscureTextRecuperaClaveB = true;

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _control = context.read<HomeController>();

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   CabecerasStandarApp(colorBase: Colors.white,size: size,onTap: (){Navigator.pop(context);},title:'CONTRASEÑA' ,),
                      
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
                          //       Container(
                          //         height: size.hScreen(15.0),
                          //         width: size.wScreen(100),
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: size.iScreen(0.0)),
    
                          //         // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                          //         child: Image.asset(
                          //           'assets/imgs/letras_UR.png', scale: 1.0,
                          //           fit: BoxFit.contain, // URL de la imagen
                          //         ),
                          //       ),
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
                          // //***********************************************/
                          //***********************************************/
                          SizedBox(
                            height: size.hScreen(10.0),
                          ),
    
                          //***********************************************/
                          SizedBox(
                            width: size.wScreen(80),
                            height: size.hScreen(8.0),
                            child: Text(
                              'Actualiza tu Contraseña',
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
                                    horizontal: size.hScreen(1.0),
                                    vertical: size.iScreen(0.0)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextFormField(
                                  //  controller: _textUsuario,
                                  decoration:  InputDecoration(
                                    suffixIcon: IconButton(
                                              splashRadius: 5.0,
                                              onPressed: () {
                                                setState(() {
                                                  _obscureTextClaveA = !_obscureTextClaveA;
                                                });
                                              },
                                              icon: _obscureTextClaveA
                                                  ? const Icon(
                                                      Icons.visibility_off_outlined)
                                                  : const Icon(
                                                      Icons.remove_red_eye_outlined)),
    
    
    
                                                      
                                    hintText: 'CLAVE ACTUAL',
                                    border: InputBorder.none,
                                  ),
                                     obscureText: _obscureTextClaveA,
                                  onChanged: (text) {
                                    _control.onChangeClaveActual(text);
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Ingrese Clave';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          //***********************************************/
    
                          SizedBox(
                            height: size.iScreen(1.0),
                          ),
                          //*****************************************/
    
                          Container(
                            // color: Colors.red,
                            width: size.wScreen(80.0),
                            padding: EdgeInsets.all(size.wScreen(0.0)),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.hScreen(1.0),
                                    vertical: size.iScreen(0.0)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextFormField(
                                  //  controller: _textUsuario,
                                  decoration:  InputDecoration(
                                     suffixIcon: IconButton(
                                              splashRadius: 5.0,
                                              onPressed: () {
                                                setState(() {
                                                  _obscureTextClaveB = !_obscureTextClaveB;
                                                });
                                              },
                                              icon: _obscureTextClaveB
                                                  ? const Icon(
                                                      Icons.visibility_off_outlined)
                                                  : const Icon(
                                                      Icons.remove_red_eye_outlined)),
                                    hintText: 'CLAVE NUEVA',
                                    border: InputBorder.none,
                                  ),
                                    obscureText: _obscureTextClaveB,
                                  onChanged: (text) {
                                    _control.onChangeClaveNueva(text);
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Ingrese Clave';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          //***********************************************/
                          //***********************************************/
    
                          SizedBox(
                            height: size.iScreen(1.0),
                          ),
                          //*****************************************/
    
                          Container(
                            // color: Colors.red,
                            width: size.wScreen(80.0),
                            padding: EdgeInsets.all(size.wScreen(0.0)),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.hScreen(1.0),
                                    vertical: size.iScreen(0.0)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextFormField(
                                  //  controller: _textUsuario,
                                  decoration:  InputDecoration(
                                    suffixIcon: IconButton(
                                              splashRadius: 5.0,
                                              onPressed: () {
                                                setState(() {
                                                  _obscureTextRecuperaClaveB= !_obscureTextRecuperaClaveB;
                                                });
                                              },
                                              icon: _obscureTextRecuperaClaveB
                                                  ? const Icon(
                                                      Icons.visibility_off_outlined)
                                                  : const Icon(
                                                      Icons.remove_red_eye_outlined)),
                                    hintText: 'VERIFICA CLAVE NUEVA',
                                    border: InputBorder.none,
                                  ),
                                    obscureText: _obscureTextRecuperaClaveB,
                                  onChanged: (text) {
                                    _control.onChangeVerificaClaveNueva(text);
                                  },
                                  validator: (text) {
                                    if (text!.trim().isNotEmpty) {
                                      return null;
                                    } else {
                                      return 'Verifique Clave';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                            //***********************************************/
                          SizedBox(
                            height: size.hScreen(10.0),
                          ),
    
                          //***********************************************/
                          //***********************************************/
    
                          GestureDetector(
                            onTap: () {
                              _onSubmit(context, _control, size);
                            },
                            child: BotonBase(
                              size: size,
                              label: 'ACTUALIZAR',
                            ),
                          ),
    
                          // SizedBox(
                          //   height: size.hScreen(5.0),
                          // ),
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
      ),
    );
  }

  void _onSubmit(BuildContext context, HomeController controller, size) async {
    if (controller.getClaveActual!.isEmpty) {
      NotificatiosnService.showSnackBarDanger('Ingrese Clave Actual');
    } 
   else if (controller.getClaveNueva!.isEmpty) {
      NotificatiosnService.showSnackBarDanger('Ingrese Clave Nueva');
    } 
   else if (controller.getVerificaClaveNueva!.isEmpty) {
      NotificatiosnService.showSnackBarDanger('Ingrese Verificación de Clave');
    } 
   else if (controller.getClaveNueva!=controller.getVerificaClaveNueva!) {
      NotificatiosnService.showSnackBarDanger('Datos nuevos no coinciden');
    } 
    
    else {


      ProgressDialog.show(context);
      final response = await controller.actualizaClaveUsuario(context);
      final responseSeseion = await controller.cierreSesionUsuario(context);
      ProgressDialog.dissmiss(context);
      if (response != null && responseSeseion != null) {
     
        _modalMessageResponse(context, response['msg'], size);
      
      } else {
        NotificatiosnService.showSnackBarError('No se pudo actualizar la Contraseña');
      }


                       
//                 var ctrlHome = context.read<HomeController>();
        
//              ProgressDialog.show(context);
//             final response = await ctrlHome.cierreSesionUsuario(context);
//             ProgressDialog.dissmiss(context);

// if (response != null ) {
     
//   //----------------------------------------------------//
//            final _tokenFCM = await Auth.instance.getTokenFireBase();
//            ctrlHome.setTokennotificacion(_tokenFCM, 'eliminar');
//            await FirebaseService.deleteFirebaseInstance();
//            await Auth.instance.deleteTokenFireBase();
//            Navigator.pop(context);
//            await Auth.instance.deleteSesion(context);
     
//               //----------------------------------------------------//



//     }else  {

//        NotificatiosnService.showSnackBarDanger( response.toString());
      
//     } 
    
         //----------------------------------------------------//






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
              width: size.wScreen(100),
              color: Colors.red,
              child: TextButton(
                onPressed: () async{
                 await Auth.instance.deleteSesion(context);
                 await Auth.instance.deleteDataRecordarme();
            Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Inicial()),
          (Route<dynamic> route) => false);
              },
                child:  Text('OK',style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
              ),
            )
          ]),
    );
  }
}
