

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


// import 'package:neitor_vet/src/api/api_provider.dart';

class HomeController extends ChangeNotifier {

 String _locationGPS = "";
 void  setItemGPS( String _item){
_locationGPS = _item;
notifyListeners();
 }

  String get getLocationMessage => _locationGPS;

  Future<void> getLocation( BuildContext context) async {
    try {
      var status = await Permission.location.status;
      if (status == PermissionStatus.denied) {
        await Permission.location.request();
        status = await Permission.location.status;
      }

      if (status == PermissionStatus.granted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        // _locationGPS = "Latitud: ${position.latitude}, Longitud: ${position.longitude}";
        _locationGPS = "${position.latitude},${position.longitude}";

      } else if (status == PermissionStatus.denied) {
       setItemGPS('');
        Position position;
        _showSettingsDialog();
      }

      // Notificar a los oyentes (widgets que están escuchando cambios en este provider)
      notifyListeners();
    } catch (e) {
      if (e is LocationServiceDisabledException) {
        _showLocationServiceDisabledDialog( context );
      } else {
        print("Error: $e");
      }
    }
  }

  void _showSettingsDialog() {
    // Implementar el diálogo para la configuración de permisos si es necesario
    // ...
  }
  // void _openLocationSettings() async {
  //   if (await canLaunch('package:com.android.settings')) {
  //     await launch('package:com.android.settings');
  //   } else {
  //     print("No se pudo abrir la configuración de ubicación");
  //   }
  // }

  void _showLocationServiceDisabledDialog(  BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Servicio de ubicación desactivado"),
          content: Text("Por favor, active el servicio de ubicación en su dispositivo."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

 
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










  }