
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:ultrared/src/controllers/home_controller.dart';
// import 'package:ultrared/src/utils/responsive.dart';



// class AccesoGPSPage extends StatefulWidget {
//   const AccesoGPSPage({Key? key}) : super(key: key);

//   @override
//   _AccesoGPSPageState createState() => _AccesoGPSPageState();
// }

// class _AccesoGPSPageState extends State<AccesoGPSPage>
//     with WidgetsBindingObserver {
//   @override
//   void initState() {
//     WidgetsBinding.instance!.addObserver(this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance!.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
    
    
//     if (state == AppLifecycleState.resumed) {
//       final _ctrlhome=context.read <HomeController>();
//     if (state == AppLifecycleState.resumed) {
//       if (await Permission.location.isGranted) {
//         // Navigator.pushReplacementNamed(context, 'home');
//         Navigator.pushReplacementNamed(context, 'inicial');
//       }
//     }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.info_outline,size: size.iScreen(5.0),color: Colors.green,),
//             SizedBox(height: size.iScreen(2.0),),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)),
//               child: Text('Es necesario activar el GPS para poder utilizar el boton de pánico de nuestra aplicación',
//                   style: GoogleFonts.poppins(
//                       fontSize: size.iScreen(2.0),
//                       color: Colors.black54,
//                       fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
//             ),
//                     SizedBox(height: size.iScreen(3.0),),
//             MaterialButton(
//               color: Colors.black,
//               shape: const StadiumBorder(),
//               elevation: 0,
//               splashColor: Colors.transparent,
//               child: Text(
//                 'Solicitar Acceso',
//                 style: GoogleFonts.poppins(
//                     fontSize: size.iScreen(1.7),
//                     color: Colors.white,
//                     fontWeight: FontWeight.normal),
//               ),
//               onPressed: () async {
//                 // Extraemos el estatus del Permiso del GPS
// openAppSettings()
// .then((value) => Navigator.pushNamed(context, 'splash'));

//                 // final status = await Permission.location.request();
//                 // accesoGPS(status);
//                 //   final _ctrlhome=context.read <HomeController>();
//                 // _ctrlhome.getLocation();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }



//   // void accesoGPS(PermissionStatus status) {
  
//   //   switch (status) {
//   //     case PermissionStatus.granted:
//   //       // Navigator.pushReplacementNamed(context, 'home');
//   //       Navigator.pushReplacementNamed(context, 'login');
//   //       break;
     
//   //     case PermissionStatus.denied:
//   //     case PermissionStatus.restricted:
//   //     case PermissionStatus.permanentlyDenied:
//   //     case PermissionStatus.limited:
//   //       openAppSettings();
//   //   }
//   // }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/selecciona_sector.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';



class AccesoGPSPage extends StatefulWidget {
  final String? tipo;
  const AccesoGPSPage({Key? key, required this.tipo}) : super(key: key);

  @override
  _AccesoGPSPageState createState() => _AccesoGPSPageState();
}

class _AccesoGPSPageState extends State<AccesoGPSPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    //  final ctrlHome=context.read<HomeController>();
    return SafeArea(
      child: Scaffold(
        body: Container( 
          // color: Colors.red,
          width: size.wScreen(100.0),
          height: size.hScreen(100.0),

          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
                CabecerasStandarApp(colorBase: cuaternaryColor,size: size,onTap: (){
                          Navigator.pop(context); },title:'INFORMACIÓN',user: '',),
              
              Container(
                       width: size.wScreen(100.0),
          height: size.hScreen(60.0),
                // color: Colors.red,
                child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline,size: size.iScreen(5.0),color: Colors.green,),
                SizedBox(height: size.iScreen(2.0),),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.5)),
                      child: Text('Es indispensable activar el GPS para habilitar la función de ubicación del botón de pánico en nuestra aplicación.',
                          style: GoogleFonts.poppins(
                              fontSize: size.iScreen(2.0),
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                    ),
                             SizedBox(height: size.iScreen(3.0),),
                MaterialButton(
                  color: Colors.black,
                  shape: const StadiumBorder(),
                  elevation: 0,
                  splashColor: Colors.transparent,
                  child: Text(
                    'Entiendo',
                    style: GoogleFonts.poppins(
                        fontSize: size.iScreen(1.7),
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () async {
                    
                  
                    if (widget.tipo=='CREATE') {
                       final _ctrlHome= context.read<HomeController>();
                                    _ctrlHome.resetAllValues();
                                    _ctrlHome.setItemLugarServicio('HOGAR');
                                  
                                  Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const SeleccionaSector(action: 'CREATE',))));
                      
                    } else if (widget.tipo=='LOGIN') {
                           Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        LoginPage())));
                    }
                  
                                 
                   
                  },
                ),
                  ],
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }



  // void accesoGPS(PermissionStatus status) {
  
  //   switch (status) {
  //     case PermissionStatus.granted:
  //       // Navigator.pushReplacementNamed(context, 'home');
  //       Navigator.pushReplacementNamed(context, 'login');
  //       break;
     
  //     case PermissionStatus.denied:
  //     case PermissionStatus.restricted:
  //     case PermissionStatus.permanentlyDenied:
  //     case PermissionStatus.limited:
  //       openAppSettings();
  //   }
  // }
}
