

import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/auth_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/controllers/login_controller.dart';
import 'package:ultrared/src/pages/home_page.dart';
import 'package:ultrared/src/pages/password_page.dart';
import 'package:ultrared/src/pages/splash_screen.dart';

import 'package:ultrared/src/service/notifications_service.dart';

import 'package:ultrared/src/service/socket_service.dart';

import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   TextEditingController? _textUsuario = TextEditingController();
  TextEditingController? _textClave = TextEditingController();
 final logData = LoginController();
    @override
  void dispose() {
    _textUsuario!.clear(); 
    _textClave!.clear(); 
    super.dispose();
  }

  @override
  void initState() {
    inicialData();
    super.initState();
  }

  void inicialData() async {
    final datosRecordarme = await Auth.instance.getDataRecordarme();
    if (datosRecordarme != null && datosRecordarme[0] == 'true') {
   
      _textUsuario!.text = '${datosRecordarme[2]}';
      _textClave!.text = '${datosRecordarme[3]}';

      logData.onRecuerdaCredenciales(true);

      logData.setLabelNombreEmpresa(datosRecordarme[1]);
      logData.onChangeUser(datosRecordarme[2]);
      logData.onChangeClave(datosRecordarme[3]);
    } else if (datosRecordarme == null || datosRecordarme[0] == 'false') {

          logData.onRecuerdaCredenciales(false);
      _textUsuario!.text = '';
      _textClave!.text = '';
    }
  }

   bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
  
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
         backgroundColor: cuaternaryColor, 
        body: 
         ChangeNotifierProvider(
          create: (_) => LoginController(),
          builder: (context, __) {
              final controller = context.read<LoginController>();
     return  SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
       child: SizedBox(
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              
              
               Container(
                  height: size.hScreen(50),
                  width:size.wScreen(100),
                  // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                  decoration: BoxDecoration(
          color: Colors.blue, // Puedes ajustar el color del contenedor según tus preferencias
          // borderRadius: BorderRadius.circular(10.0),
          // image: DecorationImage(
          //   image: AssetImage('assets/imgs/banner1.png'), // Reemplaza con la ruta de tu imagen de fondo
          //   fit: BoxFit.contain,
          // ),
        ),
        child:  Stack(
                  children: [
                    Container(
                      height: size.hScreen(50),
                      width: size.wScreen(100),
                      color: Colors.blue, // Puedes ajustar el color según tus preferencias
                      child: Image.asset(
                        'assets/imgs/Banner.png',
                        fit: BoxFit.cover, // URL de la imagen
                      ),
                    ),
                  Positioned(
                    top:  size.iScreen(5.0),
                    left:size.iScreen(1.0),
                      child: GestureDetector(
                            onTap:(){
                        Navigator.pop(context);
                        },
     
                        child: Container(
                          // color:Colors.red,
                          width: size.wScreen(10.0),
                          height: size.wScreen(10.0),
                          child: Icon(
                                              Icons.arrow_back,
                                              color: Colors.black,
                                              size: size.iScreen(3.5),
                                            ),
                        ),
                      ),
                    ),
                  ],
                ),
        //  SvgPicture.asset(
        //       'assets/imgs/banner1.svg', // Reemplaza con la ruta de tu imagen SVG
        //       // color: Colors.white, // Color de la imagen SVG
        //     ),
                  // child: Image.asset(
                  //   'assets/imgs/banner1.png', // URL de la imagen
                   
                  // ),
                ),
                
                // Segundo Container (40% de la pantalla)
                Container(
                  // height: size.hScreen(50),
                  width:size.wScreen(100),
                  // color: Colors.green, // Puedes ajustar el color según tus preferencias
                  // Puedes agregar contenido adicional en este contenedor
                  child: Form(
                    key: controller.loginFormKey,
                    child: Stack(
                      children: [
                        Column(
                          children: [

                              SizedBox(
                                height: size.hScreen(0.0),
                              ),
                              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1), // Ajusta los valores según sea necesario
                child: Container(
                          color: Colors.transparent,
                ),
              ),
                               SizedBox(
                            height: size.hScreen(10.0),
                          ),
                          //     Container(
                          //   height: size.hScreen(7),
                          //   width: size.wScreen(100),
                          //   padding:
                          //       EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                                        
                          //   // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                          //   child: Image.asset(
                          //     'assets/imgs/LetrasNegro.png',
                          //     fit: BoxFit.contain, // URL de la imagen
                          //   ),
                          // ),
                            SizedBox(
                            height: size.hScreen(0.0),
                          ),
                           SizedBox(
                            width: size.wScreen(80),
                            height: size.hScreen(5.0),
                            child: Text(
                            'Seguridad Móvil',
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
                         padding: EdgeInsets.symmetric(  horizontal: size.hScreen(2.0), vertical: size.iScreen(0.0)),
                                     
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: TextFormField(
                           controller: _textUsuario,
                          decoration: const InputDecoration(
                             suffixIcon:Icon(Icons.account_circle_rounded),
                            hintText: 'ESCRIBE TU USUARIO',
                            border: InputBorder.none,
                          ),
                           onChanged: (text) {
                                          controller.onChangeUser(text);
                                        },
                                        validator: (text) {
                                          if (text!.trim().isNotEmpty) {
                                            return null;
                                          } else {
                                            return 'Usuario Incorrecto';
                                          }
                                        },
                                         onSaved: (value) {
                                      controller.onChangeUser(value!);
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
                                          //***********************************************/
                            Container(
                              // color: Colors.red,
                              width: size.wScreen(80.0),
                            padding:  EdgeInsets.all(size.wScreen(0.0)),
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
                           controller: _textClave,
                       
                            decoration: InputDecoration(
                          
                                  border: InputBorder.none,
                          focusedBorder: InputBorder.none,
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
                                              onChanged: (text) {
                                          controller.onChangeClave(text);
                                        },
                                        validator: (text) {
                                          if (text!.trim().isNotEmpty) {
                                            return null;
                                          } else {
                                            return 'Contraseña Incorrecta';
                                          }
                                        },
                                          onSaved: (value) {
                                      controller.onChangeClave(value!);
                                    },
                                             
                        ),
                                    ),
                            ),
                          ),
                           //***********************************************/

                            SizedBox(
                              height: size.iScreen(0.0),
                            ),
                            //*****************************************/

                            //***********************************************/

                            //     )),
                            SizedBox(
                              width: size.wScreen(80),
                              height: size.hScreen(7.0),
                              child: 
                              
                              // Row(
                              //   children: [
                              //     Consumer <HomeController>(builder: (_, valueCheck, __) { 

                              //       return  Checkbox(
                              //       value:  valueCheck.getItemIsEdad,
                              //       onChanged: (value) {

                              //         // setState(() {
                              //         //   // _isChecked = value!;

                              //         // });
                              //           valueCheck.setItemIsEdad(value);



                              //       },
                              //     );

                              //      },),

                                 
                              //     Text(
                              //       'Recordar usuario',
                              //       textAlign: TextAlign.center,
                              //       style: GoogleFonts.poppins(
                              //           fontSize: size.iScreen(1.5),
                              //           fontWeight: FontWeight.w400,
                              //           color: secondaryColor),
                              //     ),
                              //   ],
                              // ),
                              Row(
                                  children: [
                                    Consumer<LoginController>(
                                      builder: (_, provider, __) {
                                        return Container(
                                          // color: Colors.red,
                                          child: Checkbox(
                                              focusColor: Colors.white,
                                              value:
                                                  provider.getRecuerdaCredenciales,
                                              onChanged: (value) {
                                                provider
                                                    .onRecuerdaCredenciales(value!);
                                                // print(value);
                                              }),
                                        );
                                      },
                                    ),
                                    Text(
                                      'Recordarme',
                                      style: GoogleFonts.lexendDeca(
                                          fontSize: size.iScreen(1.7),
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                            ),
                                          //***********************************************/
                                  
                                          SizedBox(
                                            height: size.iScreen(1.0),
                                          ),
                                          //*****************************************/
                          GestureDetector(onTap: () {
                            _onSubmit(context,controller);
                            //  Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: ((context) => HomePage())));
                          },child: BotonBase(size: size,label: 'INICIAR SESIÓN',)),
                          
                           
                            //***********************************************/

                          SizedBox(
                            height: size.hScreen(2.0),
                          ),
                                        
                                     GestureDetector(
                                       onTap:(){
                                Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                PasswordPage())));
                              },
                                
                                  child: Text.rich(
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
                                  ),
                                ),
                                  //***********************************************/
                        
                          SizedBox(
                            height: size.iScreen(0.0),
                          ),
                          //*****************************************/
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
                ),
               
                  ],
                ),
              )
         
         
           ),
     );
      }
        
       
    
    
      )));
    
  }

//*******************************************************//

  void _onSubmit(BuildContext context, LoginController controller) async {
     final _ctrlSocket = Provider.of<SocketModel>(context, listen: false);
    final isValid = controller.validateForm();
    controller.loginFormKey.currentState?.save();
    if (!isValid) return;
    if (isValid) {
      final conexion = await Connectivity().checkConnectivity();
      if (controller.getlNombreEmpresa == null) {
        NotificatiosnService.showSnackBarError('Seleccione Empresa');
      } else if (conexion == ConnectivityResult.none) {
        NotificatiosnService.showSnackBarError('SIN CONEXION A INTERNET');
      } else if (conexion == ConnectivityResult.wifi ||
          conexion == ConnectivityResult.mobile) {
        // final controllerHome = HomeController();

             ProgressDialog.show(context);
            final response = await controller.loginApp(context);
            ProgressDialog.dissmiss(context);

//  NotificatiosnService.showSnackBarDanger( response['msg']);


// if (response != null  && !response.containsKey('msg' ) ) {

// await Auth.instance.saveSession(response);  
//    final infoUser  = await Auth.instance.getSession();
         
//             var _ctrlSocket = Provider.of<SocketModel>(context, listen: false);
//               _ctrlSocket.connectToSocket("${infoUser!['token']}", "${infoUser!['rucempresa']}");
//                  context.read<HomeController>().buscarNoticias(context);
//                  context.read<HomeController>().buscarNotificaciones(context);
        
//                //------------------/

//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute<void>(
//                       builder: (BuildContext context) =>  HomePage(
//                         user: infoUser,
                     
//                       )));


//     } 
    
//      if (response != null  && response.containsKey('msg')) {
//        NotificatiosnService.showSnackBarDanger( response['msg']);
    
//     }

if (response != null  ) {

await Auth.instance.saveSession(response);  
  //  final infoUser  = await Auth.instance.getSession();
         
//             var _ctrlSocket = Provider.of<SocketModel>(context, listen: false);
//             //  _ctrlSocket.disconnectSocket();
//               _ctrlSocket.connectToSocket("${infoUser!['token']}", "${infoUser!['rucempresa']}");
//                  context.read<HomeController>().buscarNoticias(context);
//                  context.read<HomeController>().buscarNotificaciones(context);
        
//                //------------------/

//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute<void>(
//                       builder: (BuildContext context) =>  HomePage(
//                         user: infoUser,
                     
//                       )));



          // _ctrlSocket.connectToSocket("${infoUser['token']}", "${infoUser['rucempresa']}");
 if (response != null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SplashPage()));
            }
            else{
              NotificatiosnService.showSnackBarError('Error de conexión con el servidor');
            }

    } 
    
     if (response != null  && response.containsKey('msg')) {
       NotificatiosnService.showSnackBarDanger( response['msg']);
    
    }
   
      }
    }
  


}
}


