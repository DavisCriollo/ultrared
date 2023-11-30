



import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

// import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:ultrared/src/pages/acceso_gps_page.dart';
import 'package:ultrared/src/pages/foto_casa_page.dart';
import 'package:ultrared/src/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';


// import 'package:neitor_vet/src/api/api_provider.dart';
enum ConnectionStatus { unknown, mobile, wifi, none }

class HomeController extends ChangeNotifier {

 String _locationGPS = "";
 String get getLocationGPS =>_locationGPS;
 void  setItemGPS( String _item){
_locationGPS = _item;print('es el gps-------------$_locationGPS');
notifyListeners();
 }

  String get getLocationMessage => _locationGPS;

  // Future<void> getLocation( BuildContext context) async {
  //   try {
  //     var status = await Permission.location.status;
  //     if (status == PermissionStatus.denied) {
  //       await Permission.location.request();
  //       status = await Permission.location.status;
  //     }

  //     if (status == PermissionStatus.granted) {
  //       Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);

  //       // _locationGPS = "Latitud: ${position.latitude}, Longitud: ${position.longitude}";
  //       _locationGPS = "${position.latitude},${position.longitude}";

  //     } else if (status == PermissionStatus.denied) {
  //     //  setItemGPS('');
  //     //   Position position;
  //       _showSettingsDialog(context);
  //     }

  //     // Notificar a los oyentes (widgets que están escuchando cambios en este provider)
  //     notifyListeners();
  //   } catch (e) {
  //     if (e is LocationServiceDisabledException) {
  //       _showLocationServiceDisabledDialog( context );
  //     } else {
  //       print("Error: $e");
  //     }
  //   }
  // }
  // Future<void> getLocation(BuildContext context) async {


  // // void _showSettingsDialog( BuildContext context) {
  // //   showDialog(
  // //     context: context,
  // //     builder: (BuildContext context) {
  // //       return AlertDialog(
  // //         title: Text("Permisos de ubicación"),
  // //         content: Text(
  // //             "La ubicación está desactivada. Por favor, active los permisos de ubicación en la configuración del dispositivo."),
  // //         actions: <Widget>[
  // //           TextButton(
  // //             onPressed: () {
  // //               Navigator.pop(context);
  // //             },
  // //             child: Text("Cancelar"),
  // //           ),
  // //           TextButton(
  // //             onPressed: () {
  // //               Navigator.pop(context);
  // //               // _openLocationSettings();
  // //                openAppSettings();
  // //             },
  // //             child: Text("Configuración"),
  // //           ),
  // //         ],
  // //       );
  // //     },
  // //   );
  // // }
  // // void _openLocationSettings() async {
  // //   if (await canLaunch('package:com.android.settings')) {
  // //     await launch('package:com.android.settings');
  // //     openAppSettings();
  // //   } else {
  // //     print("No se pudo abrir la configuración de ubicación");
  // //   }
  // // }

  // // void _showLocationServiceDisabledDialog(  BuildContext context) {
  // //   showDialog(
  // //     context: context,
  // //     builder: (BuildContext context) {
  // //       return AlertDialog(
  // //         title: Text("Servicio de ubicación desactivado"),
  // //         content: Text("Por favor, active el servicio de ubicación en su dispositivo."),
  // //         actions: <Widget>[
  // //           TextButton(
  // //             onPressed: () {
  // //               Navigator.pop(context);
  // //             },
  // //             child: Text("Cerrar"),
  // //           ),
  // //         ],
  // //       );
  // //     },
  // //   );

  // }

 
//--------------- LISTA DE PLANER -------------//
String _planItem ='';
String get getPlanItem =>_planItem;
void  setPlanItem ( String _item){
_planItem =_item;
notifyListeners();
}


List _listaPlanes =['plan A','plan B', 'plan C','plan D','plan E','plan F',];
List get getlistaPlanes =>_listaPlanes;

void setListaPlanes(_items){
_listaPlanes.add(_items);

  notifyListeners();
}

String _sectorItem ='';
String get getSectorItem =>_sectorItem;
void  setSectorItem ( String _item){
_sectorItem =_item;
notifyListeners();
}
List _listaSectores =['Sector  A','Sector  B', 'Sector  C','Sector  D','Sector  E','Sector  F',];
List get getlistaSectores =>_listaSectores;

void setListaSectores(_items){
_listaSectores.add(_items);

  notifyListeners();
}



//========================== GEOLOCATOR =======================//
  // String? _coordenadas = "";
  // Geolocator.Position? _position;
  // Geolocator.Position? get position => _position;
  // String? _selectCoords = "";
  // String? get getCoords => _selectCoords;
  // set setCoords(String? value) {
  //   _selectCoords = value;
  //   notifyListeners();
  // }

  // Future<bool?> checkGPSStatus() async {
  //   final isEnable = await Geolocator.Geolocator.isLocationServiceEnabled();
  //   Geolocator.Geolocator.getServiceStatusStream().listen((event) {
  //     final isEnable = (event.index == 1) ? true : false;
  //   });
  //   return isEnable;
  // }

  // String _locationMessage = "";

  // String get locationMessage => _locationMessage;
  bool _gpsPositione=false;
  bool get getGPSPositione=>_gpsPositione;
  void setGPSPositione(bool _position){
    _gpsPositione =true;
    notifyListeners();
  }

  Future getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // _locationGPS = "Latitud: ${position.latitude}, Longitud: ${position.longitude}";
      _locationGPS = "${position.latitude},${position.longitude}";
         setGPSPositione(true);
    } catch (e) {
      _locationGPS = "";
      setGPSPositione(false);
      Geolocator.openAppSettings();
    }



    // print('_locationMessage   $_locationGPS');
    notifyListeners();
  
  }


//-----------------VERIFICA INTERNET-----------------------//

//  bool _conectionInternet=false;
//   bool get getconectionInternet=>_conectionInternet;
//   void setconectionInternet(bool _position){
//     _conectionInternet =true;
//       // print('CONEXION DE INTERNET    $_conectionInternet');
//     notifyListeners();
//   }

 ConnectionStatus _connectionStatus = ConnectionStatus.unknown;

  ConnectionStatus get connectionStatus => _connectionStatus;

  Future checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      _connectionStatus = ConnectionStatus.mobile;
      //  print('CONEXION DE INTERNET    $_connectionStatus');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      _connectionStatus = ConnectionStatus.wifi;
      // print('CONEXION DE INTERNET    $_connectionStatus');
    } else {
      _connectionStatus = ConnectionStatus.none;
      // print('CONEXION DE INTERNET    $_connectionStatus');
    //  setconectionInternet(false);
    }
  // setconectionInternet(true);

    notifyListeners();
  }







  }