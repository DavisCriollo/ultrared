import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
// import 'socket_provider.dart'; // Asegúrate de importar tu SocketProvider

class SocketStatusScreen extends StatefulWidget {
  const SocketStatusScreen({Key? key}) : super(key: key);

  @override
  State<SocketStatusScreen> createState() => _SocketStatusScreenState();
}

class _SocketStatusScreenState extends State<SocketStatusScreen>with WidgetsBindingObserver {



  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //  setUpNotificationPlugins();

      initData();
    });
    super.initState();
  }


// ======================= OBSERVABLE  ==========================//

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // final homeController = Provider.of<HomeController>(context, listen: false);
    if (state == AppLifecycleState.resumed) {
      // await homeController.validaInicioDeSesion(context);
      print('EL ESTADO ES: $state');
      //  Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute<void>(
      //                 builder: (BuildContext context) => const SplashPage()));


//  final _isTurned= 
// homeController.buscaNotificacionesPush('');
//       homeController.buscaNotificacionesPush2('');
          // homeController.setGetTestTurno(null);
        // homeController.getValidaTurnoServer();



    }
    if (state == AppLifecycleState.inactive) { print('EL ESTADO ES: $state');}
    if (state == AppLifecycleState.paused) { print('EL ESTADO ES: $state');}
  }





  initData() async {
      WidgetsBinding.instance!.addObserver(this);
    // final serviceSocket = Provider.of<SocketService>(context, listen: false);

 var socketManager = context.read  <SocketService>();
    if (socketManager.status == SocketStatus.desconectado) {
      socketManager.conectar();
    }


  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        final Responsive size = Responsive.of(context);
    var socketProvider =context.read <SocketService>();
    // var socketProvider =Provider.of<SocketProvider>(context,listen:  true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Estado del Socket'),
      ),
      body: 
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'Estado del Socket:',
      //         style: TextStyle(fontSize: 18.0),
      //       ),
      //       SizedBox(height: 16.0),
      //       _buildStatusWidget(socketProvider.status),
      //       SizedBox(height: 16.0),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Realiza alguna acción según el estado actual del socket
      //           if (socketProvider.status == SocketStatus.desconectado) {
      //             socketProvider.conectar();
      //           } else if (socketProvider.status == SocketStatus.conectado) {
      //             socketProvider.desconectar();
      //           }
      //         },
      //         child: 
      //         Consumer<SocketService>(builder: (_, value, __) {  
      //           return  Text(
      //           value.status == SocketStatus.desconectado
      //               ? 'Conectar'
      //               : 'Desconectar',
      //         );
      //         },)
              
             
      //       ),
      //     ],
      //   ),
      // ),

Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   socketManager.status == SocketStatus.desconectado
            //       ? 'Conectar'
            //       : 'Desconectar',
            //   style: TextStyle(fontSize: 24.0),
            // ),
             Consumer<SocketService>(builder: (_, value, __) {  
                return  Text(
                value.status == SocketStatus.desconectado
                    ? 'Conectar'
                    : 'Desconectar',
              );
              },),


              Container(
  width: size.wScreen(80),
  height: size.hScreen(5.0),
  clipBehavior: Clip.antiAlias,
  decoration: ShapeDecoration(
    color: Color(0xFFB32523),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child: Center(
    child: Text(
                  'QUIERO SER CLIENTE',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                            fontSize: size.iScreen(1.8),
                            // fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                  // TextStyle(
                  //   color: Colors.white,
                  //   fontSize: size.iScreen(1.8),
                  //   fontFamily: 'Poppins',
                  //   fontWeight: FontWeight.w500,
                  //   // height: 0.09,
                  // ),
                ),
  ),
  // Stack(
  //   children: [
  //     Positioned(
  //       left: 84.50,
  //       top: 12,
  //       child: Container(
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'QUIERO SER CLIENTE',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16,
  //                 fontFamily: 'Poppins',
  //                 fontWeight: FontWeight.w500,
  //                 height: 0.09,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ],
  // ),
)



              
            // Otros widgets de la página principal
          ],
        ),
      ),

    );
  }

  Widget _buildStatusWidget(SocketStatus status) {
    String statusText;
    Color statusColor;

    switch (status) {
      case SocketStatus.conectado:
        statusText = 'Conectado';
        statusColor = Colors.green;
        break;
      case SocketStatus.desconectado:
        statusText = 'Desconectado';
        statusColor = Colors.red;
        break;
      case SocketStatus.conectando:
        statusText = 'Conectando';
        statusColor = Colors.orange;
        break;
    }

    return Text(
      statusText,
      style: TextStyle(fontSize: 24.0, color: statusColor),
    );
  }
}