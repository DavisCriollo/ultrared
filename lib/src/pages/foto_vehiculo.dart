import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/controllers/init_provider.dart';
import 'package:ultrared/src/pages/login_page.dart';
import 'package:ultrared/src/pages/ser_cliente_page.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class FotosVehiculoPage extends StatefulWidget {
  const FotosVehiculoPage({Key? key}) : super(key: key);

  @override
  State<FotosVehiculoPage> createState() => _FotosVehiculoPageState();
}

class _FotosVehiculoPageState extends State<FotosVehiculoPage> {
  @override
  void initState() {
  initData();
    super.initState();
  }
   void initData() async {
  
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData( color: Colors.black),
           centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: 
          Consumer<HomeController>(builder: (_, value, __) { 
                return Text( value.getItemLugarServicio== 'HOGAR'? 'FOTO DE TU CASA':'FOTO DE TU VEHICULO',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              );
           },)
          
        ),
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
                  //***********************************************/

                  SizedBox(
                    height: size.iScreen(2.0),
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
                          height: size.hScreen(2.0),
                        ),
                        SizedBox(
                          width: size.wScreen(80),
                          // height: size.hScreen(8.0),
                          child: 
                          
                           Consumer<HomeController>(builder: (_, value, __) { 
                return Text( value.getItemLugarServicio== 'HOGAR'?
                 'Es necesaria la foto de tu casa para brindarte mejor asistencia cuando lo necesites. Te agradecemos tu comprensión.':
                 'Es necesaria la foto de tu vehículo para brindarte mejor asistencia cuando lo necesites. Te agradecemos tu comprensión.'
                 ,
               textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: size.iScreen(1.7),
                                fontWeight: FontWeight.w500,
                                color: secondaryColor),
                                //  Color del título en negro
              );
           },)
                          
                          // Text(
                            
                          //    'Es necesaria la foto de tu casa para brindarte mejor asistencia cuando lo necesites. Te agradecemos tu comprensión.', 
                          //    textAlign: TextAlign.center,
                          //   style: GoogleFonts.poppins(
                          //       fontSize: size.iScreen(1.7),
                          //       fontWeight: FontWeight.w500,
                          //       color: secondaryColor),
                          // ),
                        ),
                        //***********************************************/

                        //***********************************************/

                        SizedBox(
                          height: size.iScreen(2.0),
                        ),
                        //*****************************************/
                   
                       

                        // Container(
                        //   width: size.wScreen(80.0),
                        //   height: size.hScreen(40.0),
                        //   clipBehavior: Clip.antiAlias,
                        //   decoration: ShapeDecoration(
                        //     shape: RoundedRectangleBorder(
                        //       side: BorderSide(
                        //           width: 1, color: Colors.grey),
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //   ),
                        //   child: Container(
                        //     child: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment:
                        //           CrossAxisAlignment.center,
                        //       children: [
                              
                        //          SizedBox(
                        //   width: size.wScreen(80),
                        //   // height: size.hScreen(8.0),
                        //   child: Center(
                        //     child: Column(
                        //       children: [
                        //        Icon( Icons.camera_alt_rounded,color:Colors.grey,size: size.iScreen(4.0),),
                        //         Text(
                        //           'Tomar Foto',
                        //           // textAlign: TextAlign.center,
                        //           style: GoogleFonts.poppins(
                        //               fontSize: size.iScreen(1.5),
                        //               fontWeight: FontWeight.w500,
                        //               color: Colors.black54),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        //***********************************************/

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
                                        return valueFoto.getUrlVehiculo != ""
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
                                                            '${valueFoto.getUrlVehiculo}',
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
                                                                valueFoto.eliminaUrlServerVehiculo(
                                                                    valueFoto
                                                                        .getUrlVehiculo);
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
                          onTap: () {
                            final _crtl =context.read <HomeController>();
                            // final _crtlSocket =context.read <SocketService>();
                            _onSubmit(context,_crtl,size ) ;
                            // _crtl.resetValues();
                            
                          },
                          child: BotonBase(
                            size: size,
                            label: 'GUARDAR',
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
                    final image = await _getImage(context, ImageSource.camera);
                    if (image != null) {
                      _controller.setImage(image,'fotovehiculo');
                    }
                    Navigator.pop(context);
                    // _getImageFromCamera(context,_controller);
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
                    final image = await _getImage(context, ImageSource.gallery);
                    if (image != null) {
                      _controller.setImage(image,'fotovehiculo');
                    }
                    Navigator.pop(context);
                    // _getImageFromGallery(context,_controller);
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
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }
}


       void _onSubmit(BuildContext context, HomeController controller, size) async {


        final control=context.read<HomeController>();

                              if (control.getUrlVehiculo.isNotEmpty) {
                                  ProgressDialog.show(context);
                                    final response = await controller.crearUsuario(context);
                                    ProgressDialog.dissmiss(context);
                                    if (response != null) {
                                      _modalMessageResponse(context, response['msg'], size);
                                  
                                    } 
                              }
                              else {
                                  NotificatiosnService.showSnackBarDanger('Agregar foto de Vehículo');
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
            // color: Colors.red,
            child: TextButton(
              onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SerClientePage()),
          (Route<dynamic> route) => false);
              },
              child: const Text('OK'),
            ),
          )
          ]),
    );
  







}
