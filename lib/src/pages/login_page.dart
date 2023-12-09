

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

import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/service/provider_socket.dart';
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
          // color: Colors.blue, // Puedes ajustar el color del contenedor según tus preferencias
          // borderRadius: BorderRadius.circular(10.0),
          // image: DecorationImage(
          //   image: AssetImage('assets/imgs/banner1.png'), // Reemplaza con la ruta de tu imagen de fondo
          //   fit: BoxFit.contain,
          // ),
        ),
        child:  Stack(
                  children: [
                    Container(
                      height: size.hScreen(40),
                      width: size.wScreen(100),
                      // color: Colors.blue, // Puedes ajustar el color según tus preferencias
                      // child: Image.asset(
                      //   'assets/imgs/banner1.png',
                      //   fit: BoxFit.cover, // URL de la imagen
                      // ),
                    ),
                  Positioned(
                    top:  size.iScreen(5.0),
                    left:size.iScreen(2.0),
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
                  height: size.hScreen(50),
                  width:size.wScreen(100),
                  // color: Colors.green, // Puedes ajustar el color según tus preferencias
                  // Puedes agregar contenido adicional en este contenedor
                  child: Form(
                    key: controller.loginFormKey,
                    child: SingleChildScrollView(
                      child: Column(
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
                       padding: EdgeInsets.symmetric(  horizontal: size.hScreen(2.0), vertical: size.iScreen(0.0)),
                                   
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
                                           
                      ),
                                  ),
                          ),
                        ),
                                        //***********************************************/
                                
                                        SizedBox(
                                          height: size.iScreen(1.5),
                                        ),
                                        //*****************************************/
                        GestureDetector(onTap: () {
                          _onSubmit(context,controller);
                          //  Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: ((context) => HomePage())));
                        },child: BotonBase(size: size,label: 'INICIAR SESIÓN',)),
                        
                        SizedBox(
                          height: size.hScreen(3.0),
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
                          height: size.iScreen(5.0),
                        ),
                        //*****************************************/
                        ],
                      ),
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
            if (response != null) {
                final infoUser  = await Auth.instance.getSession();
            //     final _ctrlInitProvider =context.read<InitProvider>();
            // var _ctrlAuth = Provider.of<AuthProvider>(context, listen: false);
            var _ctrlSocket = Provider.of<SocketModel>(context, listen: false);
              _ctrlSocket.connectToSocket("${infoUser!['token']}", "${infoUser!['rucempresa']}");
                
        
              _ctrlSocket.emitEvent( 'client:lista-usuarios', {"chat_id": 4} );
            //  SocketService(_ctrlInitProvider);


            //------------------/
// // _ctrlSocket..emitMessage("${infoUser!['token']}", "${infoUser!['rucempresa']}");
//  _ctrlAuth.authenticateUser("${infoUser!['token']}", "${infoUser!['rucempresa']}");
//             _ctrlSocket.emitMessage('mensaje_desde_flutter', 'Hola desde Flutter');



            //    Provider.of<AuthProvider>(context, listen: false)
            //     .login("${infoUser!['token']}", "${infoUser!['rucempresa']}");

            // // Conectamos al socket después de iniciar sesión
            //  Provider.of<SocketService>(context, listen: false)
            //     .connectToSocket();


            //------------------/

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomePage(
                     
                      )));

    //                    _ctrlAuth.setCredentials("${infoUser!['token']}", "${infoUser!['rucempresa']}");
            
    //         // Inicializa y conecta el socket
    //         _ctrlSocket.initializeSocket();
    //         _ctrlSocket.socket.connect();
    //             // final _ctrlSocket =context.read<SocketProvider>();
    // //                             _ctrlSocket.emitEvent('client:lista-usuarios', {
    // //    "chat_id" : 4
    // // });

            }
            else{
              NotificatiosnService.showSnackBarError('Error de conexión con el servidor');
            }

        // if (status == PermissionStatus.granted) {
        //   await controllerHome.getCurrentPosition();
        //   if (controllerHome.getCoords != '') {
           
        //   }
        } else {
          // print('============== NOOOO TIENE PERMISOS');
          Navigator.pushNamed(context, 'gps');
        }
      }
    }
  


}


