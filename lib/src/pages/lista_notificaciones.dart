import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/pages/auxilio_page.dart';
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/no_data.dart';

class ListaNotificaciones extends StatefulWidget {
  const ListaNotificaciones({Key? key}) : super(key: key);

  @override
  State<ListaNotificaciones> createState() => _ListaNotificacionesState();
}

class _ListaNotificacionesState extends State<ListaNotificaciones> {
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
          title: Text('NOTIFICACIONES',
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
            child:
            
            Container(
                // alignment: Alignment.center,
                // color: Colors.red,

                width: size.wScreen(100.0),
                height: size.hScreen(100.0),
                child: 
                Consumer<HomeController>(builder: (_, valueNotificaciones,__) {
          
            
             if (valueNotificaciones.getListaTodasLasNotificaciones.isEmpty) {

                  if (valueNotificaciones.getErrorNotificaciones == null) {
                return Center(
                  // child: CircularProgressIndicator(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cargando Datos...',
                        style: GoogleFonts.lexendDeca(
                            fontSize: size.iScreen(1.5),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      //***********************************************/
                      SizedBox(
                        height: size.iScreen(1.0),
                      ),
                      //*****************************************/
                      const CircularProgressIndicator(),
                    ],
                  ),
                );
              } else if (valueNotificaciones.getListaTodasLasNotificaciones.isEmpty) {
                return const NoData(
                  label: 'No existen multas para mostar',
                );
              } else if (valueNotificaciones.getListaTodasLasNotificaciones.isEmpty) {
                return const NoData(
                  label: 'No existen datos para mostar',
                );
                // Text("sin datos");
              } }
            return ListView.builder(
                  shrinkWrap:true ,
            itemCount: valueNotificaciones.getListaTodasLasNotificaciones.length,
            itemBuilder: (context, index) {

              final _notificacion=valueNotificaciones.getListaTodasLasNotificaciones[index];
              String fechaString = "${_notificacion['notFecReg']}";

  // Convertir la cadena a DateTime
  DateTime fecha = DateTime.parse(fechaString);

  // Convertir a la zona horaria local
  DateTime fechaLocal = fecha.toLocal();

  // String horaFormateada = "${fechaLocal.hour}:${fechaLocal.minute}:${fechaLocal.second}";
  String horaFormateada =   "${fechaLocal.hour < 10 ? '0' : ''}${fechaLocal.hour}:${fechaLocal.minute < 10 ? '0' : ''}${fechaLocal.minute}";
              return 
              Column(
                children: [
                  ListTile(
                    dense: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        alignment:  Alignment.center,
                        width: size.iScreen(5.0),
                height: size.iScreen(5.0),
                          // decoration:  BoxDecoration(borderRadius: BorderRadius.circular(100),
                          // color:  Colors.red
                          // ),
                        child: 
                        // Image.asset(
                        //                 'assets/imgs/Avatar.png',
                        //                 // scale: 1.5,
                        //                 fit: BoxFit.contain,
                        //                 width: size.iScreen(5.0),
                        //                 scale: 1.0, // URL de la imagen
                        //               ),
                        // CachedNetworkImage(
                        //                               imageUrl: 'https://www.recetasnestle.com.mx/sites/default/files/inline-images/comidas-fritas-plato-apanado-ensalada.jpg',
                        //                               fit: BoxFit.contain,
                        //                               placeholder: (context,
                        //                                       url) =>
                        //                                   const CupertinoActivityIndicator(),
                        //                               // Image.asset(
                        //                               //     'assets/imgs/loader.gif'),
                    
                        //                               errorWidget: (context, url,
                        //                                       error) =>
                        //                                   const Icon(Icons.error),
                        //             
                        //                ),

                          _notificacion!['perFoto'].isNotEmpty
                    ? Container(
                        width: size.iScreen(9.0),
                        height: size.iScreen(9.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2.0),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                '${_notificacion!['perFoto']}', // Reemplaza con la URL de tu imagen
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ))
                    : ClipOval(
                        child: Image.asset(
                          'assets/imgs/no-image.png', // Reemplaza con la ruta de tu imagen en los activos
                          width: size.iScreen(7.5),
                          height: size.iScreen(7.5),
                          fit: BoxFit.cover,
                        ),
                      ),
                      ),
                    ),
                    title: Text('${_notificacion['perNombre']}',
                    style: GoogleFonts.poppins(
                    fontSize: size.iScreen(1.8),
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    letterSpacing: -0.40,
                  ) ),
                    subtitle:
                    Text('${_notificacion['notTipo']}',
                    style: GoogleFonts.poppins(
                    fontSize: size.iScreen(1.3),
                    fontWeight: FontWeight.normal,
                    // color: _notificacion['notTipo']=='NO'? Colors.green:  Colors.black,
                    color: _notificacion['notTipo']=='NO'?Colors.black: Colors.green,
                    letterSpacing: -0.40,
                  ) ),
                    //
                  
                    onTap: () {




 final _data= {
  "tabla": "notificacion-leido", // default
  "rucempresa": "ULTRA2022", // login
  "notId":_notificacion['notId'],
  "notTipo":_notificacion['notTipo'],
  "notIdPersona":_notificacion['notIdPersona'],
  "notVisto":_notificacion['notVisto'],
  "notTitulo":_notificacion['notTitulo'],
  "notContenido":_notificacion['notContenido'],
  "notUser":_notificacion['notUser'],
  "notEmpresa":_notificacion['notEmpresa'],
  "id_registro":_notificacion['id_registro'],
  "url_web":_notificacion['url_web'],
  "notFecReg": _notificacion['notFecReg'],
  "notFecUpd": _notificacion['notFecUpd'],
  "perDocNumero":_notificacion['perDocNumero'],
  "perNombre":_notificacion['perNombre'],
  "perFoto": _notificacion['perFoto'],
  "perPerfil":_notificacion['perPerfil'],
  "notInformacionAdicional": {
    "idPer":_notificacion['notIdPersona'],
    "perNombre":_notificacion['perNombre'],
    "perDocNumero":_notificacion['perDocNumero'],
    "perFoto": _notificacion['perFoto'],
    "perFotoCasa":_notificacion['perFotoCasa'],
    "perFotoVehiculo": _notificacion['perFotoVehiculo'],
    "tipoServicio":_notificacion ['notInformacionAdicional'] ['tipoServicio'],
    "coordenadas":_notificacion['notInformacionAdicional']['coordenadas'],
  }
};

                      final ctrlSocket =context.read<SocketModel>();

// print('LA DATA PARA SOCKET : $_data');


                ctrlSocket.emitEvent('client:actualizarData', _data);

                      final ctrlHome =context.read<HomeController>();



                                   ctrlHome .buscarNotificaciones(context);


                      ctrlHome.setInfoNotificacion(_notificacion);
                         Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                               const AuxilioPage(
                                               
                                               ))));
                    },
                    trailing:  Text('$horaFormateada',style: GoogleFonts.poppins(
                    fontSize: size.iScreen(1.6),
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    // letterSpacing: -0.40,
                  )),
                  ),
                Divider()
                ],
              );
       
            },
      );
          },
        ),
   
               ),
      
      
      
      
      
      ),
    ));
  }











}
