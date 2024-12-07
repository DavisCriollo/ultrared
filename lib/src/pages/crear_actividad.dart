

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/actividades_controller.dart';
import 'package:ultrared/src/service/notifications_service.dart';
import 'package:ultrared/src/utils/dialogs.dart';
import 'package:ultrared/src/utils/letras_mayusculas_minusculas.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';


class CrearActividadPage extends StatelessWidget {
  final String? action;
  const CrearActividadPage({Key? key, this.action}) : super(key: key);


  @override
  Widget build(BuildContext context) {
final crtl =context.read<ActividadesController>();




print('EL REGULADOR ${crtl.selectedRegulador}');


     final Responsive size = Responsive.of(context);
     final ctrl=context.read<ActividadesController>();
    return SafeArea(
      child: Scaffold(
       
        body: Container(
          width: size.wScreen(100.0),
          height: size.hScreen(100.0),
          // color: Colors.green,
          child: Column(
            children: [
               Stack(
                 children: [
                   CabecerasStandarSinUserApp(
                    colorBase: cuaternaryColor,
                    size: size,
                    onTap: () {
                      Navigator.pop(context);
                    },
                   
                    title: 'Realizar Actividad',
              ),
             Positioned(
      right: 20.0,
      bottom: 25.0,
      child: Material(
        color: Colors.transparent, // Fondo transparente para que no se vea el Material
        child: IconButton(
          splashColor: Colors.black, // Color del splash
          splashRadius: 30.0, // Ajusta el radio del splash si lo deseas
          onPressed: () {
            _onSubmit(ctrl,context);
          },
          icon: Icon(
            Icons.save,
            color: Colors.white,
            size: size.iScreen(3),
          ),
        ),
      ),)
                 ],
               ),
              Expanded(
                child: SingleChildScrollView(
              
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: size.iScreen(1.0)),
                    child: Form(
                      key: ctrl.actividadesFormKey,
                      child: Column(
                        children: [
                            //*****************************************/
                            //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/
                      SizedBox(
                        // width: size.wScreen(100.0),
                    
                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Text('Estado de actividad',
                                style: GoogleFonts.lexendDeca(
                                    fontSize: size.iScreen(2.0),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
                                      SizedBox(width: size.iScreen(1.0),),
                                 GestureDetector(
                                  onTap: () => _modalSeleccionaEstado(
                                          size, ctrl,context),
                                   child: Container(
                                 
                                    width: size.iScreen(3.5),
                                    height: size.iScreen(3.5),
                                   decoration: BoxDecoration(
                                      gradient: LinearGradient(
                      colors: [
                        Color(0XFFB12521), // Primer color con 70% de transparencia
                        Color(0xFFF7931E), // Segundo color con 70% de transparencia
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        2.0
                      ], // 70% del primer color, 30% del segundo color
                      // spreadMethod: SpreadMethod.pad, // Agregar difuminación
                                      ),
                                    // Color de fondo del contenedor
                                     borderRadius: BorderRadius.circular(8), // Bordes redondeados con radio de 8
                                   ),
                                   
                                   child: Icon(
                                       Icons.add,
                                       color: Colors.white, // Color del ícono (blanco para contrastar con el verde)
                                     ),
                                 ),
                                 )
                          ],
                        ),
                      ),
                          Row(
                          children: [
                            Expanded(
                              child: Container(
                                // color: Colors.red,
                                padding: EdgeInsets.only(
                                  top: size.iScreen(1.0),
                                  right: size.iScreen(0.5),
                                ),
                                child: Consumer<ActividadesController>(
                                  builder: (_, value, __) {
                                    return (value.labelEstado ==
                                                '' ||
                                            value.labelEstado ==
                                                null)
                                        ? Text(
                                            'No hay estado seleccionado',
                                            style: GoogleFonts.lexendDeca(
                                                fontSize: size.iScreen(1.8),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            '${value.labelEstado} ',
                                            style: GoogleFonts.lexendDeca(
                                              fontSize: size.iScreen(1.8),
                                              fontWeight: FontWeight.normal,
                                              // color: Colors.grey
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),
                           
                                     
                          ],
                        ),


        //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/

                      SizedBox(
                        width: size.wScreen(100.0),
                    
                        // color: Colors.blue,
                        child: Text('Detalle del estado:',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      TextFormField(
                       initialValue: ctrl.getInputDetalle!.isNotEmpty
                       ?ctrl.getInputDetalle:'',
                        decoration: const InputDecoration(
                            // suffixIcon: Icon(Icons.beenhere_outlined)
                            ),
                        textAlign: TextAlign.start,
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                              UpperCaseText(),
                        ],
                        onChanged: (text) {
                          ctrl.onDetalleChange(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese detalle del estado';
                          }
                        },
                      ),
                      //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/
                      SizedBox(
                        width: size.wScreen(100.0),
                    
                        // color: Colors.blue,
                        child: Text('Nombre Red Wifi:',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      TextFormField(
                       initialValue: ctrl.getInputWifi!.isNotEmpty
                       ?ctrl.getInputWifi:'',
                        decoration: const InputDecoration(
                            // suffixIcon: Icon(Icons.beenhere_outlined)
                            ),
                        textAlign: TextAlign.start,
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                        ],
                        onChanged: (text) {
                          ctrl.onWifiChange(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese nombre de Red';
                          }
                        },
                      ),
                      //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/
                      SizedBox(
                        width: size.wScreen(100.0),
                    
                        // color: Colors.blue,
                        child: Text('Clave de Wifi:',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      TextFormField(
                         initialValue: ctrl.getInputClave!.isNotEmpty
                       ?ctrl.getInputClave:'',
                        decoration: const InputDecoration(
                            // suffixIcon: Icon(Icons.beenhere_outlined)
                            ),
                        textAlign: TextAlign.start,
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                        ],
                        onChanged: (text) {
                          ctrl.onClaveChange(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese Clave de wifi';
                          }
                        },
                      ),
                                      
                      Consumer<ActividadesController>(
                      builder: (context, radioProvider, child) {
                        return Row(
                          children: [
                             //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/
                      SizedBox(
                        // width: size.wScreen(100.0),
                    
                        // color: Colors.blue,
                        child: Text('Tiene Regulador',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                       //*****************************************/
                      SizedBox(width: size.iScreen(2.0),),
                      //*****************************************/
Consumer<ActividadesController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            PopupMenuButton<String>(
              onSelected: (String value) {
                controller.setSelectedRegulador(value); // Establece la opción seleccionada
              },
              itemBuilder: (BuildContext context) {
                return ['Sí', 'No'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice,style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.normal,
                                color:controller.selectedRegulador.isEmpty? Colors.grey:Colors.black)),
                  );
                }).toList();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.selectedRegulador.isEmpty
                      ? 'Seleccione'
                      : controller.selectedRegulador,style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.normal,
                                color:controller.selectedRegulador.isEmpty? Colors.grey:Colors.black)), // Muestra el valor seleccionado
                  Icon(Icons.arrow_drop_down,size: size.iScreen(5.0),),
                ],
              ),
            ),
          ],
        );
      },
    ),

    
    
                          ],
                        );
                      },
                    ),
                          Consumer<ActividadesController>(
                      builder: (context, radioProvider, child) {
                        return Row(
                          children: [
                             //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/
                      SizedBox(
                        // width: size.wScreen(100.0),
                    
                        // color: Colors.blue,
                        child: Text('Configuración de Router',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                       //*****************************************/
                      SizedBox(width: size.iScreen(2.0),),
                      //*****************************************/
Consumer<ActividadesController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            PopupMenuButton<String>(
              onSelected: (String value) {
                controller.setSelectedConfigRouter(value); // Establece la opción seleccionada
              },
              itemBuilder: (BuildContext context) {
                return ['Sí', 'No'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice,style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.normal,
                                color:controller.selectedConfigRouter.isEmpty? Colors.grey:Colors.black)),
                  );
                }).toList();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.selectedConfigRouter.isEmpty
                      ? 'Seleccione'
                      : controller.selectedConfigRouter,style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.normal,
                                color:controller.selectedConfigRouter.isEmpty? Colors.grey:Colors.black)), // Muestra el valor seleccionado
                  Icon(Icons.arrow_drop_down,size: size.iScreen(5.0),),
                ],
              ),
            ),
          ],
        );
      },
    ),

    
    
                          ],
                        );
                      },
                    ),
                          Consumer<ActividadesController>(
                      builder: (context, radioProvider, child) {
                        return Row(
                          children: [
                             //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/
                      SizedBox(
                        // width: size.wScreen(100.0),
                    
                        // color: Colors.blue,
                        child: Text('Cambio de Patch',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                       //*****************************************/
                      SizedBox(width: size.iScreen(2.0),),
                      //*****************************************/
Consumer<ActividadesController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            PopupMenuButton<String>(
              onSelected: (String value) {
                controller.setSelectedCambioPatch(value); // Establece la opción seleccionada
              },
              itemBuilder: (BuildContext context) {
                return ['Sí', 'No'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice,style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.normal,
                                color:controller.selectedCambioPatch.isEmpty? Colors.grey:Colors.black) ,),
                  );
                }).toList();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.selectedCambioPatch.isEmpty
                      ? 'Seleccione'
                      : controller.selectedCambioPatch,style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.normal,
                                color:controller.selectedCambioPatch.isEmpty? Colors.grey:Colors.black)), // Muestra el valor seleccionado
                  Icon(Icons.arrow_drop_down,size: size.iScreen(5.0),),
                ],
              ),
            ),
          ],
        );
      },
    ),

    
    
                          ],
                        );
                      },
                    ),
                    
                        //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/
                      SizedBox(
                        width: size.wScreen(100.0),
                    
                        // color: Colors.blue,
                        child: Text('Observación de Instalación:',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ),
                      TextFormField(
                         initialValue: ctrl.getObsInstalacion!.isNotEmpty
                       ?ctrl.getObsInstalacion:'',
                        decoration: const InputDecoration(
                            // suffixIcon: Icon(Icons.beenhere_outlined)
                            ),
                        textAlign: TextAlign.start,
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9@#-+.,{" "}\\s]")),
                                UpperCaseText(),
                        ],
                        onChanged: (text) {
                          ctrl.onObsInstalacionChange(text);
                        },
                        validator: (text) {
                          if (text!.trim().isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese Observación instalación';
                          }
                        },
                      ),
                      //*****************************************/
                      SizedBox(height: size.iScreen(2.0),),
                      //*****************************************/
                              Row(
                            children: [
                             Text('Fotos:',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        SizedBox(width: size.iScreen(1.0),),
                        Consumer<ActividadesController>(builder: (_, value, __) {  
                          return value.images.isNotEmpty?    Text(' ${value.images.length} ',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.5),
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)):Container();
                        },),
                         
                        SizedBox(width: size.iScreen(1.0),),
                                 GestureDetector(
                                  onTap: () => _showImagePicker(context, ctrl),
                                   child: Container(
                                 
                                    width: size.iScreen(3.5),
                                    height: size.iScreen(3.5),
                                   decoration: BoxDecoration(
                                      gradient: LinearGradient(
                      colors: [
                        Color(0XFFB12521), // Primer color con 70% de transparencia
                        Color(0xFFF7931E), // Segundo color con 70% de transparencia
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        2.0
                      ], // 70% del primer color, 30% del segundo color
                      // spreadMethod: SpreadMethod.pad, // Agregar difuminación
                                      ),
                                    // Color de fondo del contenedor
                                     borderRadius: BorderRadius.circular(8), // Bordes redondeados con radio de 8
                                   ),
                                   
                                   child: Icon(
                                       Icons.add,
                                       color: Colors.white, // Color del ícono (blanco para contrastar con el verde)
                                     ),
                                 ),
                                 )
                    
                            ],
                          ),
                    
                         Consumer<ActividadesController>(
                          builder: (context, imageProvider, child) {
                            return Column(
                              children: [
                                if (imageProvider.images.isNotEmpty)
                                  Wrap(
                                    children: imageProvider.images.map((file) {
                                      return Stack(
                                        children: [
                                          Card(
                                            margin: const EdgeInsets.symmetric(vertical: 8),
                                            child: 
                                            Image.file(
                                                file,
                                                width: size.wScreen(90.0),
                                                height: size.hScreen(40),
                                                fit: BoxFit.cover,
                                              )),
                                              Positioned(child: IconButton(onPressed: () {
                                               imageProvider.removeImage(file); 
                                              }, icon: Icon(Icons.delete_forever,color: Colors.red,)))
                                        ],
                                      );
                                      //   ListTile(
                                      //     leading: Image.file(
                                      //       file,
                                      //       width: 50,
                                      //       height: 50,
                                      //       fit: BoxFit.cover,
                                      //     ),
                                      //     title: const Text('Imagen'),
                                      //     trailing: IconButton(
                                      //       icon: const Icon(Icons.delete),
                                      //       onPressed: () {
                                      //         imageProvider.removeImage(file);
                                      //       },
                                      //     ),
                                      //   ),
                                      // );
                                    }).toList(),
                                  ),
                               
                              ],
                            );
                          })
                    
                        // Consumer<ActividadesController>(
                        //   builder: (context, imageProvider, child) {
                        //     return Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         // Si la lista de imágenes no está vacía, se muestra la lista de imágenes
                        //         imageProvider.images.isNotEmpty
                        //             ? Wrap( children:(imageProvider.images as List).map((e) => Card(
                        //                       margin: const EdgeInsets.symmetric(vertical: 8),
                        //                       child: ListTile(
                        //                         leading: Image.file(
                        //                           e,
                        //                           width: 50,
                        //                           height: 50,
                        //                           fit: BoxFit.cover,
                        //                         ),
                        //                         title: Text('Imagen '),
                        //                         trailing: IconButton(
                        //                           icon: const Icon(Icons.delete),
                        //                           onPressed: () {
                        //                             // Eliminar imagen de la lista
                        //                             imageProvider.images.removeAt(e);
                        //                             imageProvider.notifyListeners();
                        //                           },
                        //                         ),
                        //                       ),
                        //                     ) ).toList() )
                        //             // Expanded(
                        //             //     child: ListView.builder(
                        //             //       itemCount: imageProvider.images.length,
                        //             //       itemBuilder: (context, index) {
                        //             //         return Card(
                        //             //           margin: const EdgeInsets.symmetric(vertical: 8),
                        //             //           child: ListTile(
                        //             //             leading: Image.file(
                        //             //               imageProvider.images[index],
                        //             //               width: 50,
                        //             //               height: 50,
                        //             //               fit: BoxFit.cover,
                        //             //             ),
                        //             //             title: Text('Imagen ${index + 1}'),
                        //             //             trailing: IconButton(
                        //             //               icon: const Icon(Icons.delete),
                        //             //               onPressed: () {
                        //             //                 // Eliminar imagen de la lista
                        //             //                 imageProvider.images.removeAt(index);
                        //             //                 imageProvider.notifyListeners();
                        //             //               },
                        //             //             ),
                        //             //           ),
                        //             //         );
                        //             //       },
                        //             //     ),
                        //             //   )
                        //             : const Text('No hay imágenes seleccionadas'),
                        //         const SizedBox(height: 20),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             ElevatedButton(
                        //               onPressed: () => _takePhoto(context),
                        //               child: const Text('Tomar Foto'),
                        //             ),
                        //             const SizedBox(width: 20),
                        //             ElevatedButton(
                        //               onPressed: () => _pickImage(context),
                        //               child: const Text('Seleccionar de Galería'),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(height: 20),
                        //         ElevatedButton(
                        //           onPressed: () => imageProvider.clearImages(),
                        //           child: const Text('Limpiar Imágenes'),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // ),
                        
                    
                    
                    
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
       ),
    );
  }
//  Mostrar el BottomSheet con las opciones de la cámara o galería
  void _showImagePicker(BuildContext context, ActividadesController imageProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar Foto'),
                onTap: () {
                  Navigator.pop(context);
                  imageProvider.pickImageFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar de la Galería'),
                onTap: () {
                  Navigator.pop(context);
                  imageProvider.pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

//   Future<void> _takePhoto(BuildContext context) async {
//     // Verificar permisos para acceder a la cámara
//     PermissionStatus status = await Permission.camera.request();

//     if (status.isGranted) {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.camera);

//       if (pickedFile != null) {
//         final image = File(pickedFile.path);
//         Provider.of<ActividadesController>(context, listen: false).addImage(image);
//       }
//     } else {
//       // Si no se tiene permiso, mostrar un mensaje
//       _showPermissionDeniedDialog(context);
//     }
//   }

// Future<void> _pickImage(BuildContext context) async {
//   // Verificar permisos para acceder al almacenamiento
//   PermissionStatus status = await Permission.storage.request();

//   if (status.isGranted) {
//     // Si los permisos están concedidos, abrir el selector de archivos
//     final result = await FilePicker.platform.pickFiles(type: FileType.image);

//     if (result != null && result.files.isNotEmpty) {
//       final image = File(result.files.single.path!);
      
//       // Agregar la imagen al provider
//       Provider.of<ActividadesController>(context, listen: false).addImage(image);
//     }
//   } else {
//     // Si los permisos no están concedidos, mostrar un mensaje
//     _showPermissionDeniedDialog(context);
//   }
// }

void _showPermissionDeniedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Permisos Denegados'),
      content: const Text('Necesitas conceder permisos para acceder al almacenamiento.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
        TextButton(
          onPressed: () async {
            // Intentar abrir la configuración de la aplicación para que el usuario otorgue permisos
            await openAppSettings();
            Navigator.of(context).pop();
          },
          child: const Text('Ir a la configuración'),
        ),
      ],
    ),
  );
}

Future<void> _onSubmit(ActividadesController ctrl, BuildContext context) async {
  // Validar el formulario
  final isValid = ctrl.validateFormActividade();
  ctrl.actividadesFormKey.currentState?.save();
  if (!isValid) return;

  // Mostrar el diálogo de progreso
  ProgressDialog.show(context);

  try {
    // Enviar imágenes si hay alguna
    if (ctrl.images.isNotEmpty) {
      await ctrl.getAllUrlsServerActividad();
    }

    // Crear la actividad
    final response = await ctrl.crearActividad();

    if (response != null) {
      // Mostrar notificación de éxito
      NotificatiosnService.showSnackBarDanger('Actividad creada correctamente.');
      ctrl.setTipoPeticion(ctrl.tipoPeticion!);
      ctrl.buscaActividades(context);
      Navigator.pop(context);
    } else {
      // Mostrar notificación de error
      NotificatiosnService.showSnackBarError('Error al crear la actividad.');
    }
  } catch (e) {
    // Manejo de errores inesperados
    NotificatiosnService.showSnackBarError('Ocurrió un error: ${e.toString()}');
  } finally {
    // Ocultar el diálogo de progreso
    ProgressDialog.dissmiss(context);
  }
}



  //====== MUESTRA MODAL DE TIPO DE DOCUMENTO =======//
  void _modalSeleccionaEstado(
      Responsive size, ActividadesController ctrl,BuildContext context) {
    final data = [
      'PENDIENTE',
      'EN PROCESO',
      'SUSPENDIDO',
      'PROCESADO',
      'ANULADO',
    ];

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: size.wScreen(5.0), vertical: size.wScreen(3.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELECCIONAR ESTADO',
                          style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(2.0),
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          )),
                      IconButton(
                          splashRadius: size.iScreen(3.0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: size.iScreen(3.5),
                          )),
                    ],
                  ),
                  SizedBox(
                    width: size.wScreen(100),
                    height: size.hScreen(26),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            ctrl.setLabelEstado(data[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.grey[100],
                            margin: EdgeInsets.symmetric(
                                vertical: size.iScreen(0.3)),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.iScreen(1.0),
                                vertical: size.iScreen(1.0)),
                            child: Text(
                              data[index],
                              style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(1.8),
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


  


}
