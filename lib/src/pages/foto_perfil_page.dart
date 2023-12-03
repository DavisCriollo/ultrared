import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/foto_casa_page.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';

class FotosPerfilPage extends StatefulWidget {
  const FotosPerfilPage({Key? key}) : super(key: key);

  @override
  State<FotosPerfilPage> createState() => _FotosPerfilPageState();
}

class _FotosPerfilPageState extends State<FotosPerfilPage> {
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
          title: Text('FOTO DE PERFIL',
              style: GoogleFonts.poppins(
                fontSize: size.iScreen(2.0),
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.40,
              ) // Color del título en negro
              ),
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
                              side: BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: [
                              
                                 SizedBox(
                          // width: size.wScreen(80),
                          // height: size.hScreen(100.0),
                          child: 
                          GestureDetector(
                            onTap: () {
                              final control=context.read<HomeController>();
                              bottomSheet(control,context,size);
                            },
                            child: 
                            
                            Consumer<HomeController>(builder: (_, valueFoto, __) {  
                              return  
                              
                              
                             valueFoto.image != null?  Center(
                              child: Column(
                                children: [

                                
          Image.file(
           File(valueFoto.image!.path
           ),
           fit: BoxFit.cover,
            // width: size.wScreen(100.0),
            // height: size.hScreen(0.0),
          ),
                                
                                 
                                ],
                              ),
                            ): Container(
                              
                                  constraints: BoxConstraints(minHeight: size.hScreen(50.0)),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon( Icons.camera_alt_rounded,color:Colors.grey,size: size.iScreen(4.0),),
                                   Text(
                                      'Tomar Foto',
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontSize: size.iScreen(1.5),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                ],
                              ),
                            );
                              
                            },),
                           
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
                             onTap:(){
                        Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                          FotosCasaPage())));
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
                  onPressed: () {
                    Navigator.pop(context);
                  _getImageFromCamera(context,_controller);
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
                  onPressed: () {
                     Navigator.pop(context);
                  _getImageFromGallery(context,_controller);
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

Future<void> _getImageFromCamera(BuildContext context, HomeController controller ) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
   controller.setImage(image);
  }

  Future<void> _getImageFromGallery(BuildContext context,HomeController controller ) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
   controller.setImage(image);
  }






  

}
