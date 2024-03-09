// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:ultrared/src/controllers/chat_controller.dart';
import 'package:ultrared/src/controllers/home_controller.dart';

import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/pages/vista_imagen.dart';
import 'package:ultrared/src/service/socket.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/cabeceraApp.dart';
import 'package:ultrared/src/widgets/no_data.dart';
import 'package:latlong2/latlong.dart'
    as latlng;
import 'package:url_launcher/url_launcher.dart'; // Nota: latlong2 es la versión más reciente del paquete


class AuxilioPage extends StatefulWidget {
  final String idNotificacion;
  const AuxilioPage({Key? key, required this.idNotificacion}) : super(key: key);

  @override
  State<AuxilioPage> createState() => _AuxilioPageState();
}

class _AuxilioPageState extends State<AuxilioPage> {


 
  @override
  void initState() {
    initil();
     
    super.initState();
  }

  void initil() async {
    AudioCache player = AudioCache();

    player = AudioCache();

    await player.play('imgs/evacuacion_alarma.mp3');
  }
@override
  void dispose() {
   
AudioCache player = AudioCache();

    player = AudioCache();

    
   player.clearAll();
    super.dispose();
  }


  void initData() async {
    // final loadInfo = context.read<HomeController>();

  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrlHome = context.read<HomeController>();

   final ctrlSocket =context.read<SocketService>();
   
   
    
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
          //   title: Text('AUXILIO',
          //       style: GoogleFonts.poppins(
          //         fontSize: size.iScreen(2.0),
          //         fontWeight: FontWeight.w700,
          //         color: Colors.black,
          //         letterSpacing: -0.40,
          //       ) // Color del título en negro
          //       ),
          // ),
          body: FutureBuilder(
            future: ctrlHome.buscaNotificacionPorId(context, widget.idNotificacion),
         
            builder: (BuildContext context, AsyncSnapshot snapshot) {



  
 if (snapshot.connectionState == ConnectionState.waiting) {
            // Si estamos esperando los datos, mostramos un indicador de carga
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Si ocurrió un error, mostramos un mensaje de error
            return const Center(child: Text('Error al obtener datos del servidor'));
          } else {
            // Si los datos fueron obtenidos correctamente, mostramos los datos
            final datos = snapshot.data;
            return 
           SizedBox(
              // alignment: Alignment.center,
              // color: Colors.red,
    
              width: size.wScreen(100.0),
              height: size.hScreen(100.0),
              child: Consumer<HomeController>(
                builder: (_, ctrHome, __) {
    
    
                
    
                    if (ctrHome.getInfoNotificacion.isEmpty) {
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
                } else if (ctrHome.getInfoNotificacion.isEmpty) {
                  return const NoData(
                    label: 'No existen datos para mostar',
                  );
                  // Text("sin datos");
                } else {
                   final _data= {
      "tabla": "notificacion-leido", // default
      "rucempresa": "ULTRA2022", // login
      "notId":datos['notId'],
      "notTipo":datos['notTipo'],
      "notIdPersona":datos['notIdPersona'],
      "notVisto":datos['notVisto'],
      "notTitulo":datos['notTitulo'],
      "notContenido":datos['notContenido'],
      "notUser":datos['notUser'],
      "notEmpresa":datos['notEmpresa'],
      "id_registro":datos['id_registro'],
      "url_web":datos['url_web'],
      "notFecReg": datos['notFecReg'],
      "notFecUpd": datos['notFecUpd'],
      "perDocNumero":datos['perDocNumero'],
      "perNombre":datos['perNombre'],
      "perFoto": datos['perFoto'],
      "perPerfil":datos['perPerfil'],
      "notInformacionAdicional": {
      "idPer":datos['notIdPersona'],
      "perNombre":datos['perNombre'],
      "perDocNumero":datos['perDocNumero'],
      "perFoto": datos['perFoto'],
      "perFotoCasa":datos['perFotoCasa'],
      "perFotoVehiculo": datos['perFotoVehiculo'],
      "tipoServicio":datos ['notInformacionAdicional'] ['tipoServicio'],
      "coordenadas":datos['notInformacionAdicional']['coordenadas'],
      }
    };
    
                            // final ctrlSocket =context.read<SocketService>();
    
    // print('LA DATA PARA SOCKET : $_data');
    
    
                      ctrlSocket.emitEvent('client:actualizarData', _data);
                       
      double?  _latitud=  double.tryParse('${datos['notInformacionAdicional']['coordenadas']['latitud']}');
       double?  _longitud=  double.tryParse('${datos['notInformacionAdicional']['coordenadas']['longitud']}');
    
                  return Column(
                    children: [
                      CabecerasStandarApp(colorBase: cuaternaryColor,size: size,onTap: (){
                        Navigator.pop(context);
                        ctrlHome.buscarNotificaciones(context);
                        
                        
                        },title:'AUXILIO' ,),
                      
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.iScreen(1.0),
                            vertical: size.iScreen(1.0)),
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        )),
                        // color:Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AvatarGlow(
                              // endRadius: 80,
                  //             glowRadiusFactor: 0.2,
                  // glowColor: Colors.red,
                  // duration: const Duration(milliseconds: 1000),
                              child: Container(
                                  width: size.iScreen(9.0),
                                  height: size.iScreen(9.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.grey, width: 2.0),
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${datos['perFoto']}', // Reemplaza con la URL de tu imagen
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                            Container(
                              // color: Colors.green,
                              width: size.wScreen(60.0),
                              child: Column(
                                // mainAxisAlignment:MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // _playSoundOnPageLoad();
                                    },
                                    child: Text(
                                        ' ${datos['perNombre']}',
                                        style: GoogleFonts.poppins(
                                          fontSize: size.iScreen(2.2),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          letterSpacing: -0.20,
                                        )),
                                  ),
                                  InkWell(
                                    onLongPress: () {
                                       _callNumber('${datos['perDocNumero']}');
                                    },
                                    child: Text(
                                        '${datos['perDocNumero']}',
                                        style: GoogleFonts.poppins(
                                          fontSize: size.iScreen(1.8),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          letterSpacing: -0.20,
                                        )),
                                  ),
                                  Text('Se encuentra en peligro',
                                      style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(1.8),
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                        letterSpacing: -0.40,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: size.wScreen(100),
                              child: FlutterMap(
                         
                                options: MapOptions(
                                  center: latlng.LatLng(_latitud!,
                                            _longitud!), // Coordenadas de San Francisco
                                  zoom: 15.0,
                                ),
                                layers: [
                                  TileLayerOptions(
                                    urlTemplate:
                                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    subdomains: ['a', 'b', 'c'],
                                  ),
                                  MarkerLayerOptions(
                                    markers: [
                                      Marker(
                                        width: 40.0,
                                        height: 40.0,
                                        point: latlng.LatLng(_latitud,
                                            _longitud),
                                        builder: (ctx) => InkWell(
                                          onTap: () {
                                             openMapsApp(_latitud, _longitud);
                                          },
                                          child: Container(
                                            child: AvatarGlow(
                                              glowRadiusFactor: 0.5,
                  glowColor: Colors.red,
                  duration: const Duration(milliseconds: 1000),
                                              child: Icon(
                                                Icons.location_on,
                                                color: tercearyColor,
                                                size: size.iScreen(5.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.iScreen(2.0),
                                    vertical: size.iScreen(2.0)),
                                // color:  Colors.red,
                                width: size.wScreen(100),
                                alignment: Alignment.center,
                                child: 
                                Column(
                                  children: [
                                    Wrap(
                                      spacing : 50.0,
                                      alignment :WrapAlignment.center,
                                      children: [
                                          datos['perFotoCasa'].isNotEmpty
                              ?    Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.iScreen(0.9),
                                              vertical: size.iScreen(1.2)),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  final _infoImage={"id":1,"lugar":'CASA', "url":'${datos['perFotoCasa']}'};
                                                     Navigator.push(context,
          MaterialPageRoute(builder: ((context) => PreviewPhoto(infoImage:_infoImage))));
                                                  
                                                },
                                                child: Hero(
                                                   tag:1,
                                                  child: Container(
                                                    width: size.iScreen(13),
                                                    height: size.iScreen(15),
                                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          '${datos['perFotoCasa']}',
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text('Foto de Vivienda',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: size.iScreen(1.5),
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    letterSpacing: -0.40,
                                                  ))
                                            ],
                                          ),
                                        ):Container(),
                                       datos['perFotoVehiculo'].isNotEmpty
                              ?   Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.iScreen(0.9),
                                              vertical: size.iScreen(1.2)),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                 onTap: () {
                                                  final _infoImage={"id":2,"lugar":'VEHÍCULO', "url":'${datos['perFotoVehiculo']}'};
                                                     Navigator.push(context,
          MaterialPageRoute(builder: ((context) => PreviewPhoto(infoImage:_infoImage))));
                                                  
                                                },
                                                child: Hero(
                                                  tag:2,
                                                  child: Container(
                                                    width: size.iScreen(13),
                                                    height: size.iScreen(15),
                                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          '${datos['perFotoVehiculo']}',
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text('Foto del Transporte',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: size.iScreen(1.5),
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    letterSpacing: -0.40,
                                                  ))
                                            ],
                                          ),
                                        ):Container(),
                                        
                                      ],
                                    ),
                                    
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.0), vertical: size.iScreen(2.0)),
                                      padding:  EdgeInsets.symmetric(horizontal: size.iScreen(0.5), vertical: size.iScreen(2.0)),
                                      width: size.wScreen(100),
                                      decoration:  BoxDecoration(color:  Colors.white,borderRadius: BorderRadius.circular(8) ),
                                      
                                      child: Column(
                                        children: [
                                          Container(
                                            width: size.wScreen(100),
                                             margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.5), vertical: size.iScreen(0.5)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(Icons.location_on,color:  tercearyColor,),
                                                
                                                Expanded(
                                                  child: Text("Localiza a : ${datos['perNombre']}",style: GoogleFonts.poppins(
                                                              fontSize: size.iScreen(1.7),
                                                              fontWeight: FontWeight.w500,
                                                              
                                                              // color: Colors.white
                                                              ), textAlign:TextAlign.center ,),
                                                ),
                                              ],
                                            )),
                                          InkWell(
                                            onTap: () {
    
                                                   openMapsApp(_latitud, _longitud);
    
                //                               showModalBottomSheet(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: <Widget>[
                //         ListTile(
                //           leading: Icon(Icons.map_outlined,color: tercearyColor,size: size.iScreen(4.0),),
                //           title: Text('Abrir aplicación de mapas',style: GoogleFonts.poppins(
                //                                               fontSize: size.iScreen(1.7),
                //                                               fontWeight: FontWeight.w500,
                                                              
                //                                               // color: Colors.white
                //                                               )),
                //           onTap: () {
                //             Navigator.pop(context);
                //             openMapsApp(_latitud, _longitud);
                //           },
                //         ),
                //       ],
                //     );
                //   },
                // );
                                            },
                                            child: Container(
                                                width: size.wScreen(50),
                                                height: size.hScreen(4.0),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color: tercearyColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8)),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'IR A',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: size.iScreen(1.7),
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white),
                                                   
                                                  ),
                                                ),
                                              ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
    
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceAround,
                                //   children: [
                              
                                //   ],
                                // ),
                              ),
                            ),
                          
                                            
                          ],
                        ),
                      ),
                    ],
                  );}
    
                },
              ));}
            },
          ),
          
        
        ),
      ),
    );
  }


_callNumber(String numero) async {
  await FlutterPhoneDirectCaller.callNumber(numero);
}

 // Función para abrir la aplicación de mapas
   void openMapsApp(double? _latitud,double? _longitud) async {
 
Uri url =
      Uri.parse('geo:${_latitud},${_longitud}?q=${_latitud},${_longitud}');
  launchUrl(url);



  }












}
