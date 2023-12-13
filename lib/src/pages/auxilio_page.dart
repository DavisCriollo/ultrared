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
import 'package:ultrared/src/pages/chat_page.dart';
import 'package:ultrared/src/pages/lista_usuarios_chat.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/responsive.dart';
import 'package:ultrared/src/utils/theme.dart';
import 'package:ultrared/src/widgets/botonBase.dart';
import 'package:ultrared/src/widgets/no_data.dart';
import 'package:latlong2/latlong.dart'
    as latlng; // Nota: latlong2 es la versión más reciente del paquete

class AuxilioPage extends StatefulWidget {
  const AuxilioPage({Key? key}) : super(key: key);

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
    final loadInfo = context.read<HomeController>();

  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final ctrHome = context.read<HomeController>();

     double?  _latitud=  double.tryParse('${ctrHome.getInfoNotificacion['notInformacionAdicional']['coordenadas']['latitud']}');
     double?  _longitud=  double.tryParse('${ctrHome.getInfoNotificacion['notInformacionAdicional']['coordenadas']['longitud']}');
   
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: cuaternaryColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true, // Centra el título en el AppBar
          elevation: 0,
          backgroundColor: cuaternaryColor, // Fondo blanco
          title: Text('AUXILIO',
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
            child: Consumer<SocketModel>(
              builder: (_, valueChat, __) {
                return Column(
                  children: [
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
                            glowRadiusFactor: 0.2,
                glowColor: Colors.red,
                duration: const Duration(milliseconds: 1000),
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
                                        '${ctrHome.getInfoNotificacion['perFoto']}', // Reemplaza con la URL de tu imagen
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
                                      ' ${ctrHome.getInfoNotificacion['perNombre']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: size.iScreen(2.2),
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        letterSpacing: -0.20,
                                      )),
                                ),
                                InkWell(
                                  onLongPress: () {
                                     _callNumber('${ctrHome.getInfoNotificacion['perDocNumero']}');
                                  },
                                  child: Text(
                                      '${ctrHome.getInfoNotificacion['perDocNumero']}',
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
                                      builder: (ctx) => Container(
                                        child: Icon(
                                          Icons.location_on,
                                          color: tercearyColor,
                                          size: size.iScreen(5.0),
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
                              Wrap(
                                spacing : 50.0,
                                alignment :WrapAlignment.center,
                                children: [
                                    ctrHome.getInfoNotificacion['perFotoCasa'].isNotEmpty
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
                                        Container(
                                          width: size.iScreen(13),
                                          height: size.iScreen(15),
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                '${ctrHome.getInfoNotificacion['perFotoCasa']}',
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                 ctrHome.getInfoNotificacion['perFotoVehiculo'].isNotEmpty
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
                                        Container(
                                          width: size.iScreen(13),
                                          height: size.iScreen(15),
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                '${ctrHome.getInfoNotificacion['perFotoVehiculo']}',
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                );

              },
            )),
      ),
    );
  }


_callNumber(String numero) async {
  await FlutterPhoneDirectCaller.callNumber(numero);
}








}
