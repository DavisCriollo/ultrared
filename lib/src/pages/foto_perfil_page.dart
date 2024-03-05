import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/foto_casa_page.dart';
import 'package:ultrared/src/pages/foto_vehiculo.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/modal_permisos.dart';

class FotosPerfilPage extends StatefulWidget {
    final String? action;
  const FotosPerfilPage({Key? key, this.action}) : super(key: key);

  @override
  State<FotosPerfilPage> createState() => _FotosPerfilPageState();
}

class _FotosPerfilPageState extends State<FotosPerfilPage> {
  @override
  Widget build(BuildContext context) {
        final _action = widget.action;
    final Responsive size = Responsive.of(context);
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
          //   title: 
            
            
          //   // Text('FOTO DE PERFIL',
          //   //     style: GoogleFonts.poppins(
          //   //       fontSize: size.iScreen(2.0),
          //   //       fontWeight: FontWeight.w700,
          //   //       color: Colors.black,
          //   //       letterSpacing: -0.40,
          //   //     ) // Color del título en negro
          //   //     ),
          //    Text(_action == 'CREATE' ? 'REGISTRO FOTO PERFIL' : 'EDITAR  FOTO PERFIL',
          //           style: GoogleFonts.poppins(
          //             fontSize: size.iScreen(2.0),
          //             fontWeight: FontWeight.w700,
          //             color: Colors.black,
          //             letterSpacing: -0.40,
          //           ) // Color del título en negro
          //           ),
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
                   CabecerasStandarApp(colorBase: cuaternaryColor,size: size,onTap: (){Navigator.pop(context);},title:_action == 'CREATE' ? 'REGISTRO FOTO PERFIL' : 'EDITAR  FOTO PERFIL',),
                    //***********************************************/
    
                    SizedBox(
                      height: size.iScreen(0.0),
                    ),
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
                          SizedBox(
                            height: size.hScreen(0.0),
                          ),
                          SizedBox(
                            width: size.wScreen(80),
                            // height: size.hScreen(8.0),
                            child: Text(
                              'Es necesaria tu foto de perfil para brindarte mejor asistencia cuando lo necesites. Te agradecemos tu comprensión.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: size.iScreen(1.7),
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor),
                            ),
                          ),
                          //***********************************************/
    
                          //***********************************************/
    
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                          //*****************************************/
    
                          Container(
                            width: size.wScreen(80.0),
                            // height: size.hScreen(80.0),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    // width: size.wScreen(80),
                                    // height: size.hScreen(100.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        final control =
                                            context.read<HomeController>();
                                        bottomSheet(control, context, size);
                                      },
                                      child: Consumer<HomeController>(
                                        builder: (_, valueFoto, __) {
                                          return valueFoto.getUrlPerfil != ""
                                              ? Center(
                                                  child: Column(
                                                    children: [
                                                      // Image.file(
                                                      //  File(valueFoto.image!.path
                                                      //  ),
                                                      //  fit: BoxFit.cover,
                                                      //   // width: size.wScreen(100.0),
                                                      //   // height: size.hScreen(0.0),
                                                      // ),
                                                      Stack(
                                                        children: [
                                                          Center(
                                                              child:
                                                                  // Image.network(
                                                                  //   valueFoto.getUrlImage,
                                                                  //   errorBuilder: (context, error, stackTrace) {
                                                                  //     // print('Error al cargar la imagen: $error');
                                                                  //     return
                                                                  //     Icon(
                                                                  //       Icons.error_outline,
                                                                  //       size: size.iScreen(4.0),
                                                                  //       color: Colors.red,
                                                                  //     );
                                                                  //   },
                                                                  // ),
    
                                                                  FadeInImage(
                                                            placeholder:
                                                                const AssetImage(
                                                                    'assets/imgs/loader.gif'),
                                                            image: NetworkImage(
                                                              '${valueFoto.getUrlPerfil}',
                                                            ),
                                                          )),
                                                          Positioned(
                                                              top: size
                                                                  .iScreen(1.0),
                                                              right: size
                                                                  .iScreen(2.0),
                                                              child: InkWell(
                                                                onTap: () {
    // print('sssiii');
                                                                  valueFoto.eliminaUrlServerPerfil(
                                                                      valueFoto
                                                                          .getUrlPerfil);
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .delete_forever,
                                                                  color:
                                                                      Colors.red,
                                                                  size: size
                                                                      .iScreen(4),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  constraints: BoxConstraints(
                                                      minHeight:
                                                          size.hScreen(50.0)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.camera_alt_rounded,
                                                        color: Colors.grey,
                                                        size: size.iScreen(4.0),
                                                      ),
                                                      Text(
                                                        'Tomar Foto',
                                                        // textAlign: TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: size
                                                                    .iScreen(1.5),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black54),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //***********************************************/
    
                          //***********************************************/
    
                          SizedBox(
                            height: size.iScreen(2.0),
                          ),
                          //*****************************************/
                          GestureDetector(
                            onTap: () async{
    
                               final control=context.read<HomeController>();
    
                          // if (_action=='CREATE') {
    
                              if (control.getUrlPerfil.isNotEmpty) {
                                   if ( control.getItemLugarServicio=='HOGAR') {
                                      
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>  FotosCasaPage( action: widget.action))));
                                    }else
                                    {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>  FotosVehiculoPage(action: widget.action))));
    
                                    }
    
                                  
                                } else {
                                  NotificatiosnService.showSnackBarDanger('Agregar foto de Perfil');
                                }
                            
                          // } else {
                          //    NotificatiosnService.showSnackBarDanger('ESTA EDITANDO');
    
                          //      final control = context.read<HomeController>();
    
      // if (control.getUrlCasa.isNotEmpty) {
      //   ProgressDialog.show(context);
      //   final response = await control.crearUsuario(context);
      //   ProgressDialog.dissmiss(context);
      //   if (response != null  && response.containsKey('res') ) {
      //      NotificatiosnService.showSnackBarDanger( response['msg']);
      //   } else if (response != null  && !response.containsKey('res')) {
      //     _modalMessageResponse(context, response['msg'], size);
      //   }
       
      // } else {
      //   NotificatiosnService.showSnackBarDanger('Agregar foto de Casa');
    
    
                          // }
    
    
                              //   if (control.getUrlPerfil.isNotEmpty) {
                              //      if ( control.getItemLugarServicio=='HOGAR') {
                                      
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => FotosCasaPage())));
                              //       }else
                              //       {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => FotosVehiculoPage())));
    
                              //       }
    
                                  
                              //   } else {
                              //     NotificatiosnService.showSnackBarDanger('Agregar foto de Perfil');
                              //   }
    
    
                                   
    
    
    
    
    
    
                              // final _ctrl = context.read<HomeController>();
                              // _ctrl.getUrlsServer( ) ;
                            },
                            child: BotonBase(
                              size: size,
                              label: 'SIGUIENTE',
                            ),
                          ),
    
                          // SizedBox(
                          //   height: size.hScreen(5.0),
                          // ),
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

  void bottomSheet(
    HomeController _controller,
    BuildContext context,
    Responsive size,
  ) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () async {
                  await _controller.checkAndRequestPermissions();
           
                    if (_controller.hasCameraPermission) {
                      //  NotificatiosnService.showSnackBarDanger(' SI TIENE PERMISO DE CAMARA');
                         final image = await _getImage(context, ImageSource.camera);
                    if (image != null) {
                      _controller.setImage(image,'fotoperfil');
                    }
                    // Navigator.pop(context);
                    } else {
                      showPermissionModal(context,size,'Para completar el registro en nuestra aplicación, es necesario otorgar permisos de la cámara.');
                      
                    }

                    // final image = await _getImage(context, ImageSource.camera);
                    // if (image != null) {
                    //   _controller.setImage(image,'fotoperfil');
                    // }
                    // Navigator.pop(context);


                 
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Cámara',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.camera_alt_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                   
                    

 await _controller.checkAndRequestPermissions();
           
                    if (_controller.hasCameraPermission) {
                      //  NotificatiosnService.showSnackBarDanger(' SI TIENE PERMISO DE CAMARA');
                         final image = await _getImage(context, ImageSource.gallery);
                    if (image != null) {
                      _controller.setImage(image,'fotoperfil');
                    }
                    // Navigator.pop(context);
                    } else {
                      showPermissionModal(context,size,'Para completar el registro en nuestra aplicación, es necesario otorgar permisos de la cámara.');
                      
                    }



                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Abrir Galería',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.2),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.iScreen(2.0),
                          ),
                          child: Icon(Icons.image_outlined,
                              size: size.iScreen(3.0))),
                    ],
                  ),
                ),
              ],
            ));
  }

// Future<void> _getImageFromCamera(BuildContext context, HomeController controller ) async {
//     final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
//    controller.setImage(image!);
//   }

//   Future<void> _getImageFromGallery(BuildContext context,HomeController controller ) async {
//     final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
//    controller.setImage(image!);
//   }

  Future<File?> _getImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source,imageQuality: 50);

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }
}
