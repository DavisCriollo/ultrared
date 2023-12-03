import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

// import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:ultrared/src/api/api_provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:http/http.dart' as _http;
import 'package:ultrared/src/models/foto_url.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:ultrared/src/utils/valida_cedula.dart';



// import 'package:neitor_vet/src/api/api_provider.dart';
enum ConnectionStatus { unknown, mobile, wifi, none }

class HomeController extends ChangeNotifier {
  GlobalKey<FormState> celularFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> correoFormKey = GlobalKey<FormState>();

  final _api = ApiProvider();
  
   String _locationMessage ='';
  Map<String,dynamic> _locationGPS = {};
   Map<String,dynamic> get getLocationGPS => _locationGPS;
  void setItemGPS( Map<String,dynamic> _item) {
    _locationGPS = _item;
   
    print('es el gps-------------$_locationGPS');
    notifyListeners();
  }

  bool validateFormCelular() {
    if (celularFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateFormCorreo() {
    if (correoFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
 


   String get getLocationMessage => _locationMessage;


  void resetValues(){
       _itemLugarServicio= "";
    _itemCedua= "";
     _itemNombre= "";
     _itemApellido= "";
     _itemCelulares= "";
     _itemCorreos= "";
     _itemDireccion= "";
  
     _ciudadItem= "";
     _sectorItem= "";
     _itemReferencia= "";
    
     _locationGPS= {};
   
     _itemPlaca= "";
  }

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

//--------------- LISTA DE CIUDAD -------------//
  String _ciudadItem = '';
  String get getCiudadItem => _ciudadItem;
  void setCiudadItem(Map<String, dynamic> _item) {
     _listaSectores = [];
    _ciudadItem = _item['ciuNombre'].toString();

    if (_item['ciuSectores'].isNotEmpty) {
      _listaSectores = [];

      for (var item in _item['ciuSectores']) {
        _listaSectores.add(item);
      }
    } else {
      _listaSectores = [];
    }

    notifyListeners();
  }








  List _listaCiudad = [];
  List get getlistaCiudad => _listaCiudad;

  void setListaCiudad(_items) {
    _listaCiudad.add(_items);

    notifyListeners();
  }

//--------------- LISTA DE PLANER -------------//
  String _planItem = '';
  String get getPlanItem => _planItem;
  void setPlanItem(String _item) {
    _planItem = _item;
    notifyListeners();
  }

  List _listaPlanes = [
    'plan A',
    'plan B',
    'plan C',
    'plan D',
    'plan E',
    'plan F',
  ];
  List get getlistaPlanes => _listaPlanes;

  void setListaPlanes(_items) {
    _listaPlanes.add(_items);

    notifyListeners();
  }

  String _sectorItem = '';
  String get getSectorItem => _sectorItem;
  void setSectorItem(String _item) {
    _sectorItem = _item;
    notifyListeners();
  }

  List _listaSectores = [];
  List get getlistaSectores => _listaSectores;

  void setListaSectores(_items) {
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
  bool _gpsPositione = false;
  bool get getGPSPositione => _gpsPositione;
  void setGPSPositione(bool _position) {
    _gpsPositione = true;
    notifyListeners();
  }

  Future getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // _locationGPS = "Latitud: ${position.latitude}, Longitud: ${position.longitude}";
       _locationMessage ='';
      _locationGPS = {
        "latitud": position.latitude,
        "longitud": position.longitude,
    };
    _locationMessage =  "${position.latitude},${position.longitude}";
      setGPSPositione(true);
    } catch (e) {
      _locationGPS = {};
       _locationMessage ='';
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
//-----------------ITEM CELULR-----------------------//

  String? _itemCelulares = '';
  String? get getItemCelulars => _itemCelulares;

  void seItemCelulars(String? valor) {
    _itemCelulares = valor;
    print('item Celulars: $_itemCelulares');
    notifyListeners();
  }

  String? _celulares = '';
  String? get getCelulars => _celulares;

  void seCelulars(String? valor) {
    _celulares = valor;
    // print('item Celulars: $_itemAddCelulares');
    notifyListeners();
  }

//========================== ITEM DE CelularS  =======================//

  String? _itemCodeCelulares = '';
  String? get getItemCodeCelular => _itemCodeCelulares;

  void seItemCodeCelular(String? valor) {
    if (valor == '593') {
      _itemCodeCelulares = '+$valor' + '9';
    } else {
      _itemCodeCelulares = '+$valor';
    }

    print('item _itemCodeCelulares: $_itemCodeCelulares');

    notifyListeners();
  }

//========================== VALIDA INPUT CORREO  =======================//
  bool? _isCorreo;

  bool? get getIsCorreo => _isCorreo;

  void setIsCorreo(bool? value) {
    _isCorreo = value;
    // notifyListeners();
  }
//========================== ITEM DE CORREOS  =======================//

  String? _itemCorreos = '';
  String? get getItemCorreos => _itemCorreos;

  void setItemCorreos(String? valor) {
    _itemCorreos = valor;

    notifyListeners();
  }
//========================== ITEM  formularios =======================//

  String? _itemCedua = '';
  String? get getItemCedua => _itemCedua;

  void setItemCedua(String? valor) {
    _itemCedua = valor;

    notifyListeners();
  }

  String? _itemNombre = '';
  String? get getItemNombre => _itemNombre;

  void setItemNombre(String? valor) {
    _itemNombre = valor;

    notifyListeners();
  }
  bool? _itemIsEdad = false;
  bool? get getItemIsEdad => _itemIsEdad;

  void setItemIsEdad(bool? valor) {
    _itemIsEdad = valor;
 print(' es mayor $_itemIsEdad');
    notifyListeners();
  }

  String? _itemApellido = '';
  String? get getItemApellido => _itemApellido;

  void setItemApellido(String? valor) {
    _itemApellido = valor;

    notifyListeners();
  }

  String? _itemDireccion = '';
  String? get getItemDireccion => _itemDireccion;

  void setItemDireccion(String? valor) {
    _itemDireccion = valor;

    notifyListeners();
  }

  String? _itemReferencia = '';
  String? get getItemReferencia => _itemReferencia;

  void setItemReferencia(String? valor) {
    _itemReferencia = valor;

    notifyListeners();
  }

  String? _itemLugarServicio = '';
  String? get getItemLugarServicio => _itemLugarServicio;

  void setItemLugarServicio(String? valor) {
   _itemPlaca = '';
   _locationGPS = {};
    _locationMessage ='';
    _itemLugarServicio = valor;


    notifyListeners();
  }

  String? _itemTipo = '';
  String? get getItemTipo => _itemTipo;

  void setItemTipo(String? valor) {
    _itemTipo = valor;

    notifyListeners();
  }

  String? _itemPlaca = '';
  String? get getItemPlaca => _itemPlaca;

  void setItemPlaca(String? valor) {
    _itemPlaca = valor;

    notifyListeners();
  }

//================================== LISTAR ALIMENTOS  ==============================//

  List _listaTodasLasCiudades = [];
  List get getListaTodasLasCiudades => _listaTodasLasCiudades;

  void setListaTodasLasCiudades(List _data) {
    _listaTodasLasCiudades = [];

    _listaTodasLasCiudades = _data;

    // print('LA RAZA: ${_listaTodasLasCiudades[0]['espRazas']}');

    notifyListeners();
  }

  bool? _errorCiudades; // sera nulo la primera vez
  bool? get getErrorCiudades => _errorCiudades;

  Future? buscaCiudades() async {
    final response = await _api.getAllCiudades();
    if (response != null) {
      _errorCiudades = true;
      setListaTodasLasCiudades(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorCiudades = false;
      notifyListeners();
      return null;
    }
    return null;
  }



//-------------------- TOMAR FOTO------------------//

  XFile? _image;

  XFile? get image => _image;

  void setImage(XFile? newImage) {
    _image = newImage;

getUrlsServer( );


    notifyListeners();
  }











//---------------------RECUPERA CORREO-----------------------------//

String? _itemCedulaRecupera = '';
  String? get getItemCedulaRecupera => _itemCedulaRecupera;

  void setItemCedulaRecupera(String? valor) {
    _itemCedulaRecupera = valor;
print('LA validaCedula $_itemCedulaRecupera');
    notifyListeners();
  }

//================================== RECUPERA CLAVE ==============================//

 String _empresaRecuperaClave= 'ULTRA2022';

  bool? _errorRecuperaClave; // sera nulo la primera vez
  bool? get getErrorRecuperaClave => _errorRecuperaClave;

  Future? buscaRecuperaClave() async {
    final response = await _api.recuperaClave(
      usuario: _itemCedulaRecupera,
      empresa: _empresaRecuperaClave
    );
    if (response != null) {
      _errorRecuperaClave = true;
      // setListaTodasLasRecuperaClave(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorRecuperaClave = false;
      notifyListeners();
      return null;
    }
    return null;
  }





//================================== LISTAR ALIMENTOS  ==============================//

  List _listaTodosLosPlanes = [];
  List get getListaTodosLosPlanes => _listaTodosLosPlanes;

  void setListaTodosLosPlanes(List _data) {
    _listaTodosLosPlanes = [];

    _listaTodosLosPlanes = _data;

    // print('LA RAZA: ${_listaTodosLosPlanes[0]['espRazas']}');

    notifyListeners();
  }

  bool? _errorPlanes; // sera nulo la primera vez
  bool? get getErrorPlanes => _errorPlanes;

  Future? buscaPlanesSinToken() async {
    final response = await _api.getAllPlanesSinToken();
    if (response != null) {
      _errorPlanes = true;
      setListaTodosLosPlanes(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorPlanes = false;
      notifyListeners();
      return null;
    }
    return null;
  }




//================================== CREAR NUEVO  ==============================//

bool? _errorCrearUsuario; // sera nulo la primera vez
  bool? get getErrorCrearUsuario => _errorCrearUsuario;

  Future? crearUsuario(BuildContext context) async {

   final response = await _api.createUserSinToken(context: context,data: 
   {
    "tabla": "usuario",
    "rucempresa": "ULTRA2022",
    "tipoServicio": _itemLugarServicio,
    "cedula": _itemCedua,
    "nombres": _itemNombre,
    "apellidos": _itemApellido,
    "celular": _itemCelulares,
    "email": _itemCorreos,
    "direccion":_itemDireccion,
    "plan": _planItem,
    "ciudad": _ciudadItem,
    "sector": _sectorItem,
    "referencia": _itemReferencia,
    "fotoPerfil": "https://documentos.neitor.com/contable/fotoperfil/ULTRA2022/96eee234-93e9-4a4c-9fb7-7d12ba3b3c5a.png",
    "fotoCasa": "https://documentos.neitor.com/contable/fotocasa/ULTRA2022/b2ed4c5b-e7db-4e34-8ba3-c32a9480f6c0.png",
    "gps": {
        "laitud": -7,
        "longitud": -90
    },
    "fotoVehiculo": "",
    "placa": _itemPlaca,
}
   );
    if (response != null) {
      _errorCrearUsuario = true;
      

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorCrearUsuario = false;
      notifyListeners();
      return null;
    }
    return null;
  }



//========================== PROCESO DE TOMAR FOTO DE CAMARA =======================//
  String  _urlImage = "";
  String  get getUrlImage =>_urlImage;

  void setUrlImge(String data) {
    _urlImage = "";
    _urlImage = data;
    print('IMAGEN URL: $_urlImage');

    // agregarContenido();

    notifyListeners();
  }
  bool  _errorUrl =true;
  bool  get getErrorUrl =>_errorUrl;
  void setErrorUrl(bool _data) {
    _errorUrl = _data;
    notifyListeners();
  }


// Future getUrlsServer( ) async {

//     // final dataUser = await Auth.instance.getSession();
//        File? _imageFile;

// ;

//     final response = await _api.saveUrlAlServidor(

//         urlFile: File(image!.path),
//       // token: '${dataUser!['token']}',
//     );

//     if (response != null) {
//       _errorUrl = true;
//       // setListaUrlse(response['data']);
//       // print('ES LOS URLS: ${response['urls'][0]}');
//       setUrlImge(response.toString());
//       notifyListeners();
//       // return response;
//     }
//     if (response == null) {
//       _errorUrl = false;
//       notifyListeners();

//     }
//    return response;
//   }
Future getUrlsServer( ) async {

    // final dataUser = await Auth.instance.getSession();
      //  File? _imageFile;

;

    final response = await _api.uploadImage(
      image:File(image!.path),
     imageType:'fotoperfil',
enterprices:'ULTRA2022',
    );

    if (response != null) {
      _errorUrl = true;
      // setListaUrlse(response['data']);
      // print('ES LOS URLS: ${response['urls'][0]}');
      setUrlImge(response.toString());
      notifyListeners();
      // return response;
    }
    if (response == null) {
      _errorUrl = false;
      notifyListeners();

    }
   return response;
  }



Future eliminaUrlServer( String _url) async {


final _urlImageDelete=
[
		{
			"nombre": "foto",
			"url": _url,
		}
	];
// print('ES LOS URLSTEMP: ${_urlImageDelete}');

    final dataUser = await Auth.instance.getSession();

    final response = await _api.deleteUrlDelServidor(
         datos:_urlImageDelete,
      token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorUrl = true;
      // setListaUrlse(response['data']);
      // print('ES LOS URLS: ${response['urls'][0]}');
      // setUrlImge(response.toString());
      notifyListeners();
      return 'true';
      // return response;
    }
    if (response == null) {
      _errorUrl = false;
      notifyListeners();
      return 'false';

    }
 
  }




}
