



import 'package:animate_do/animate_do.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/acercaDe.dart';
import 'package:ultrared/src/pages/actualiza_clave.dart';
import 'package:ultrared/src/pages/lista_estado_cuenta.dart';
import 'package:ultrared/src/pages/lista_notificaciones.dart';

import 'package:ultrared/src/pages/selecciona_sector.dart';


import 'package:ultrared/src/service/notification_push.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/service/socket.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';

import 'package:url_launcher/url_launcher.dart';


class DrawerMenu extends StatefulWidget {
  // final Map<String, dynamic>? user;

  const DrawerMenu({Key? key,}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
    // final  _ctrl =HomeController();

  @override
  void initState() {
  //  inicio();
    super.initState();
  }

// void inicio() async{
//    final  _ctrl =context.read <HomeController>();
//     _ctrl.buscaUsuarioById(context);


// }


  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
  final  _ctrl =context.read <HomeController>();
        //  _ctrl.getUser
  
                                          
    return 
    
    
    
    
    
    Drawer(
      child: 
      Consumer<HomeController>(builder: (_, value, __) { 

              //   if (value.getInfoUsuarioById.isEmpty) {

                 
              //   return Center(
              //     // child: CircularProgressIndicator(),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Text(
              //           'Cargando Datos...',
              //           style: GoogleFonts.lexendDeca(
              //               fontSize: size.iScreen(1.5),
              //               color: Colors.black87,
              //               fontWeight: FontWeight.bold),
              //         ),
              //         //***********************************************/
              //         SizedBox(
              //           height: size.iScreen(1.0),
              //         ),
              //         //*****************************************/
              //         const CircularProgressIndicator(),
              //       ],
              //     ),
              //   );
              // } else if (value.getInfoUsuarioById.isEmpty) {
              //   return const NoData(
              //     label: 'Cargando Datos....',
              //   );
              // }  

        return  Container(
           color: Colors.white,
          child: ListView(
          padding: EdgeInsets.zero,
          children: [

            CabecerasIconDrawerApp(size: size, colorBase: Colors.white,name:  '${value.getUser!['nombre']}',code:  '${value.getUser!['usuario']}  ',onTap: (){
               //                       //--------------------//
                                    _ctrl.resetAllValues();

            _ctrl.buscaUsuarioById(context);

            

                if (_ctrl.getInfoUsuarioById.isNotEmpty) {
                  
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const SeleccionaSector( action: 'EDIT',)));
                 
                }
                



            },),

            













            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color:
            //         tercearyColor, // Puedes ajustar el color del encabezado según tus preferencias
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
                  
            //           Row(
            //             mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            //             children: [
            //               Container(
            //                   width: size.iScreen(9.0),
            //                   height: size.iScreen(9.0),
            //                   decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     border: Border.all(color: Colors.white, width: 2.0),
            //                   ),
            //                   child: 
            //                 value.getUser!['foto']!=null?ClipOval(
            //                     child: CachedNetworkImage(
            //                       imageUrl:
            //                           '${value.getUser!['foto']}', // Reemplaza con la URL de tu imagen
            //                       placeholder: (context, url) =>
            //                           const CircularProgressIndicator(),
            //                       errorWidget: (context, url, error) =>
            //                           const Icon(Icons.error),
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ) : ClipOval(
            //               child: Image.asset(
            //                 'assets/imgs/no-image.png', // Reemplaza con la ruta de tu imagen en los activos
            //                 width: size.iScreen(7.5),
            //                 height: size.iScreen(7.5),
            //                 fit: BoxFit.cover,
            //               ),
            //             ),),
            //               InkWell(
            //                 onTap: () async {

            //                       //--------------------//
            //                         _ctrl.resetAllValues();

            // _ctrl.buscaUsuarioById(context);

            

            //     if (_ctrl.getInfoUsuarioById.isNotEmpty) {
                  
            //                       Navigator.pop(context);
            //                       Navigator.of(context).push(MaterialPageRoute(
            //                           builder: (context) => const SeleccionaSector( action: 'EDIT',)));
                 
            //     }
                


            //                 },
            //                 child: Column(
            //                   children: [
            //                     Text('Editar Perfil',style: GoogleFonts.poppins(
            //                 fontSize: size.iScreen(1.3),
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.white),),
            //                     // Icon(Icons.manage_accounts_outlined,size: size.iScreen(3.0),color: Colors.white,),
                  
            //                     // Icon(Icons.manage_accounts_outlined,size: size.iScreen(3.0),color: Colors.white,),
            //                     ClipOval(
            //               child: Image.asset(
            //                 'assets/imgs/user.png',color:Colors.white, // Reemplaza con la ruta de tu imagen en los activos
            //                 width: size.iScreen(4),
            //                 height: size.iScreen(4),
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
                         
                       
            //                   ],
            //                 ),
            //               ),
                         
            //             ],
            //           ),
                     
            //       Container(
            //         width: size.wScreen(80.0),
            //         child: Text(
            //           '${value.getUser!['nombre']}',
            //           overflow: TextOverflow.ellipsis,
            //           // maxLines: 2,

            //           style: GoogleFonts.poppins(
            //               fontSize: size.iScreen(1.8),
            //               fontWeight: FontWeight.w900,
            //               color: Colors.white),
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.symmetric(vertical: 2.0),
            //         padding: EdgeInsets.all(2.0),
            //         // width: size.wScreen(20),
            //         constraints: BoxConstraints(minWidth: size.iScreen(1.0)),
            //         decoration: BoxDecoration(
            //           color: Colors
            //               .white, // Puedes ajustar el color del contenedor según tus preferencias
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Text(
            //               ' ID ',
            //               style: GoogleFonts.poppins(
            //                   fontSize: size.iScreen(1.5),
            //                   fontWeight: FontWeight.w400,
            //                   color: Colors.black),
            //             ),
            //             Text(
            //               '${value.getUser!['id']}  ',
            //               style: GoogleFonts.poppins(
            //                   fontSize: size.iScreen(1.5),
            //                   fontWeight: FontWeight.w700,
            //                   color: Colors.black),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // FadeInLeftBig(
            //    duration: Duration(milliseconds: 400),
            //   child: ListTile(
            //     tileColor: Colors.white,
            //     leading: Icon(Icons.home),
            //     title: Text('Inicio'),
            //     onTap: () {
            //       // Acción al hacer clic en "Inicio"
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            _ctrl.getUser!['isClient']=='SI'
                                            ?  FadeInLeftBig(
                                               duration: Duration(milliseconds: 400),
                                              child: ListTile(
                                                 tileColor: Colors.white,
                                                        leading: Icon(Icons.list_alt_outlined),
                                                        title: Text('Estado de Cuenta'),
                                                        onTap: () {
                                                            Navigator.pop(context);
                                                        final valueHome = context.read<HomeController>();

                valueHome.buscaEstadoDeCuenta(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const DataTableEstadoCuenta())));
                                                        
                                                        },
                                                      ),
                                            ): Container(),
            FadeInLeftBig(
               duration: Duration(milliseconds: 400),
              child: ListTile(
                
                tileColor: Colors.white,
                 leading: const Icon(Icons.lock_outline_rounded),
                title: const Text('Cambiar Contraseña'),
                onTap: () {
                  // Acción al hacer clic en "Acerca de"
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => ActualizaClave())));
                },
              ),
            ),
            FadeInLeftBig(
               duration: Duration(milliseconds: 400),
              child: ListTile(
                tileColor: Colors.white,
                leading: const Icon(Icons.notifications_active),
                title: Text('Notificaciones'),
                onTap: () {
                  // Acción al hacer clic en "Configuración"
                  Navigator.pop(context);
                  context
                                        .read<HomeController>()
                                        .buscarNotificaciones(context);
            
            //
            
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            const ListaNotificaciones()));
                },
              ),
            ),
            FadeInLeftBig(
               duration: Duration(milliseconds: 400),
              child: ListTile(
                tileColor: Colors.white,
                leading: const Icon(Icons.share),
                title:  const Text('Compartir'),
                onTap: () {
                  // Acción al hacer clic en "Configuración"
                  Navigator.pop(context);
                  _modalShare(context,size);
                },
              ),
            ),
            FadeInLeftBig(
               duration: Duration(milliseconds: 400),
              child: ListTile(
                tileColor: Colors.white,
                leading: const Icon(Icons.info),
                title: const Text('Acerca de'),
                onTap: () {
                  // Acción al hacer clic en "Acerca de"
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => AcercaDePage())));
                },
              ),
            ),
            // FadeInLeftBig(
            //    duration: Duration(milliseconds: 400),
            //   child: ListTile(
            //     tileColor: Colors.white,
            //     leading: const Icon(Icons.playlist_add_check_circle_outlined),
            //     title: const Text('Política de Privacidad'),
            //     onTap: () {
            //       // Acción al hacer clic en "Acerca de"
            //       Navigator.pop(context);
            // _launchURL();
           
            //     },
            //   ),
            // ),
            FadeInLeftBig(
               duration: Duration(milliseconds: 400),
              child: ListTile(
                
                tileColor: Colors.white,
                leading: Icon(Icons.exit_to_app),
                title: Text('Cerrar Sesión'),
                onTap: () async {
                    
                  
                    var ctrlHome = context.read<HomeController>();  
                      var ctrlSocket = context.read<SocketService>();  
                      var ctrlChat = context.read<ChatController>();  
                 
                 ProgressDialog.show(context);
                final response = await ctrlHome.cierreSesionUsuario(context);
                ProgressDialog.dissmiss(context);
                    Navigator.pop(context);
            
            if (response != null ) {
                 
              // //----------------------------------------------------//
              //  final _tokenFCM = await Auth.instance.getTokenFireBase();
              //  ctrlHome.setTokennotificacion(_tokenFCM, 'eliminar');
              //  await FirebaseService.deleteFirebaseInstance();
              //  await Auth.instance.deleteTokenFireBase();
              // //  ctrlSocket.disconnectSocket();
            

              //   SocketService().socket.disconnect();
              //  Navigator.pop(context);
              //  await Auth.instance.deleteSesion(context);
                 
              //     //----------------------------------------------------//
            


             ctrlSocket.closeSocket();
            await Auth.instance.deleteSesion(context);
              ctrlSocket.resetInfoSocket();
              ctrlChat.resetInfoChat();
              ctrlHome.resetInfoHome();
             
            
            
                }else  {
            
                   NotificatiosnService.showSnackBarDanger( response.toString());
                  
                } 
                
                     //----------------------------------------------------//
            
                },
              ),
            ),
            //***********************************************/

            SizedBox(
              height: size.iScreen(3.0),
            ),
            //*****************************************/
            Container(
             color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
              width: size.wScreen(100),
              // height: 19,
              child: Text(
                'Versión 1.0.1',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    fontSize: size.iScreen(1.5),
                    fontWeight: FontWeight.w700,
                    color: secondaryColor,
                    height: 0.21),
              ),
            )
          ],
      ),
        );
   
   
       },)
      
      
     
      
     
   
    );
  }




Future<void> _modalShare(
  BuildContext context,
  Responsive size,
) {
  // final themeValue = context.read<AppTheme>();
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        'Compatir',
        style: GoogleFonts.roboto(
            fontSize: size.iScreen(2.0),
            color: tercearyColor,
            fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _onShare(context, 'https://n9.cl/_ultra_');  //CAMBIAR CON EL URL DE LA TIENDA
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Android',
                  style: GoogleFonts.roboto(
                      fontSize: size.iScreen(2.2),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.iScreen(1.0),
                ),
                Icon(
                  Icons.android_outlined,
                  color: Colors.green,
                  size: size.iScreen(4.0),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // _onShare(context, 'https://acortar.link/SWMt9k'); //CAMBIAR CON EL URL DE LA TIENDA
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'IOS',
                  style: GoogleFonts.roboto(
                      fontSize: size.iScreen(2.2),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.iScreen(1.0),
                ),
                Icon(
                  Icons.apple_outlined,
                  color: Colors.black,
                  size: size.iScreen(4.0),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );

}
void _onShare(BuildContext context, String _urlApp) async {
  final box = context.findRenderObject() as RenderBox?;

  await Share.share(_urlApp,
      subject: 'Ultrared App',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}



_launchURL() async {
  const url = 'https://neitor.com/ur/politicasPrivacidad.html';
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'No se puede abrir $url';
  }
}



  

}

