// import 'package:flutter/material.dart';
// import 'package:http/http.dart';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:ultrared/src/utils/responsive.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   _SplashPageState createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   // final controllerLogin = LoginController();
//   // final controllerHome = HomeController();
//   // final controllerAppTheme = AppTheme();
//   //   final _api = ApiProvider();
//   //  Session? session ;

//   @override
//   void initState() {
//     super.initState();
// // VERIFICO SI EL CONTEXTO  ESTA INICIALIZADO//
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       _chechLogin();
      
//     });
//   }

//   _chechLogin() async {
//   //  session = await Auth.instance.getSession();
 

// // Future.delayed(Duration(seconds: 1),(){
//   // final BuildContext _size;




// // final _size=Responsive.of(context);
// //      int? _primColor=int.parse(session!.colorPrimario!.replaceAll("#",'0xff'));
// //   int? _secColor=int.parse(session.colorSecundario!.replaceAll("#",'0xff'));
// // Color? _colorPrimario=Color(_primColor);
// // Color? _colorSecundario=Color(_secColor);

// // Provider.of<AppTheme>(context,listen: false).setAppTheme(true,'',_colorPrimario,Colors.white,_colorSecundario,_size);
// // print('veces q repite:');
// //   });


//     if (session != null  ) {
  

        




//       final   response = await _api. revisaToken(session!.token);
//       // print('revisa token============> :$response');
       
//        if(response==404||response==401){
//            Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const LoginPage()),
//           (Route<dynamic> route) => false);
//        }else{
//           Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => HomePage(user: session)),
//           (Route<dynamic> route) => false);
//        }
      
//     } else {
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const LoginPage()),
//           (Route<dynamic> route) => false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Responsive size = Responsive.of(context);
  
 









    
    
//     return Scaffold(
//       body: SizedBox(
//         width: size.wScreen(100.0),
//         height: size.hScreen(100.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const CircularProgressIndicator(),
//               SizedBox(
//                 height: size.iScreen(2.0),
//               ),
//               const Text('Preparando Contenido.... '),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
