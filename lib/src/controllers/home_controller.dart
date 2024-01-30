import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cross_file/cross_file.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

// import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:image_picker/image_picker.dart';
import 'package:ultrared/src/api/api_provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/service/socket_service.dart';
// import 'package:ultrared/src/api/authentication_client.dart';
// import 'package:http/http.dart' as _http;
// import 'package:ultrared/src/models/foto_url.dart';
// import 'package:ultrared/src/service/socket_service.dart';
// import 'package:ultrared/src/utils/valida_cedula.dart';

// import 'package:neitor_vet/src/api/api_provider.dart';
enum ConnectionStatus { unknown, mobile, wifi, none }

class HomeController extends ChangeNotifier {
  GlobalKey<FormState> celularFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> correoFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> transporteFormKey = GlobalKey<FormState>();

  final _api = ApiProvider();

  Map<String, dynamic>? _user = {};
  Map<String, dynamic>? get getUser => _user;
  void setUserApp(Map<String, dynamic>? _data) {
    _user = _data;
    //  print('LA SESION ------------- >>>   $_user');
    notifyListeners();
  }

  String _locationMessage = '';
  Map<String, dynamic> _locationGPS = {};
  Map<String, dynamic> get getLocationGPS => _locationGPS;
  void setItemGPS(Map<String, dynamic> _item) {
    _locationGPS = _item;

    // print('es el gps-------------$_locationGPS');
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

  bool validateFormTransporte() {
    if (transporteFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String get getLocationMessage => _locationMessage;

  void resetValues() {
    _itemLugarServicio = "";
    _itemCedua = "";
    _itemNombre = "";
    _itemApellido = "";
    _itemCelulares = "";
    _itemCorreos = "";
    _itemDireccion = "";

    _ciudadItem = "";
    _sectorItem = "";
    _itemReferencia = "";

    _locationGPS = {};

    _itemPlaca = "";
    _itemMarca = "";
    _itemModelo = "";
    _itemColor = "";
  }

  void resetAllValues() {
    _itemLugarServicio = "";
    _itemCedua = "";
    _itemNombre = "";
    _itemApellido = "";
    _itemCelulares = "";
    _itemCorreos = "";
    _itemDireccion = "";

    _ciudadItem = "";
    _sectorItem = "";
    _itemReferencia = "";

    _locationGPS = {};
    _gpsPositione = false;

    _itemPlaca = "";
    _itemMarca = "";
    _itemModelo = "";
    _itemColor = "";

    _fotoTipo = "";
    _urlImage = "";
    _urlImageCasa = "";
    _urlImagePerfil = "";
    _urlImageVehiculo = "";
    _planItem = 'NINGUNO';
  }

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
  String _planItem = 'NINGUNO';
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
//   bool _gpsState = false;
//   bool  get getGPSState => _gpsState;
//    void setGPSState(bool _state) {
//     _gpsState = _state;
//        print('ESTA ACTIVADO   $_gpsState');
//     notifyListeners();
//   }
//   Future checkGPSStatus() async {
//     final isEnable = await Geolocator.isLocationServiceEnabled();
//     // Geolocator.getServiceStatusStream().listen((event) {
//     //   final isEnable = (event.index == 1) ? true : false;

//       //  print('ESTA ACTIVADO   $isEnable');
//       setGPSState(isEnable);
      
// notifyListeners();
//     // });
//     // return isEnable;
//   }



// GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
//   bool _gpsStatus = false;

//   bool get gpsStatus => _gpsStatus;

//   Future<void> checkGpsStatus() async {
//     bool isLocationServiceEnabled = await geolocator.isLocationServiceEnabled();
//     _gpsStatus = isLocationServiceEnabled;
//     notifyListeners();
//     print('estado del GPS ====> {$_gpsStatus}');
//   }






  // String _locationMessage = "";

  String get locationMessage => _locationMessage;
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
      _locationMessage = '';
      _locationGPS = {
        "latitud": position.latitude,
        "longitud": position.longitude,
      };
      _locationMessage = "${position.latitude},${position.longitude}";
      setGPSPositione(true);
    } catch (e) {
      _locationGPS = {};
      _locationMessage = '';
      setGPSPositione(false);
      // Geolocator.openAppSettings();
    }

    // print('_locationGPS   $_locationGPS');
    notifyListeners();
  }


  late Position _currentPosition;

  Position get currentPosition => _currentPosition;

  Future<void> getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
        _locationMessage = '';
      _locationGPS = {
        "latitud": _currentPosition.latitude,
        "longitud": _currentPosition.longitude,
      };
      _locationMessage = "${_currentPosition.latitude},${_currentPosition.longitude}";
      setGPSPositione(true);
       print(' obtener la posición: $_currentPosition');
      notifyListeners();
    } catch (e) {
      print('Error al obtener la posición: $e');
    }
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
    // print('item Celulars: $_itemCelulares');
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
    // if (valor == '593') {
    //   // _itemCodeCelulares = '+$valor' + '9';
    //   _itemCodeCelulares = '+$valor' ;
    //   // _itemCodeCelulares = '0';
    // } else {
    _itemCodeCelulares = '+$valor';
    // }

    // print('item _itemCodeCelulares: $_itemCodeCelulares');

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
//  print(' es mayor $_itemIsEdad');
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

  String? _itemMarca = '';
  String? get getItemMarca => _itemMarca;

  void setItemMarca(String? valor) {
    _itemMarca = valor;

    notifyListeners();
  }

  String? _itemModelo = '';
  String? get getItemModelo => _itemModelo;

  void setItemModelo(String? valor) {
    _itemModelo = valor;

    notifyListeners();
  }

  String? _itemColor = '';
  String? get getItemColor => _itemColor;

  void setItemColor(String? valor) {
    _itemColor = valor;

    notifyListeners();
  }

  String? _itemReferencia = '';
  String? get getItemReferencia => _itemReferencia;

  void setItemReferencia(String? valor) {
    _itemReferencia = valor;

    print('LA REFERENCIA $_itemReferencia');

    notifyListeners();
  }

  String? _itemLugarServicio = '';
  String? get getItemLugarServicio => _itemLugarServicio;

  void setItemLugarServicio(String? valor) {
    _itemPlaca = '';
    _locationGPS = {};
    _locationMessage = '';
    _itemMarca = '';
    _itemModelo = '';
    _itemColor = '';
    _itemLugarServicio = '';

    _itemLugarServicio = valor;

// setFotoTipo( valor);

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

  String? _fotoTipo = '';
  String? get getFotoTipo => _fotoTipo;

  void setFotoTipo(String? _valor) {
    _fotoTipo = '';

    if (_valor == 'HOGAR') {
      _fotoTipo = 'fotocasa';
    } else if (_valor == 'TRANSPORTE') {
      _fotoTipo = 'fotovehiculo';
    } else {
      _fotoTipo = _valor;
    }

    print('LA _fotoTipo $_fotoTipo');
    notifyListeners();
  }

//   File? _image;

//   File? get image => _image;

//   void setImage(File? newImage) {
//     _image = newImage;

// guarImagenServer();

//     notifyListeners();
//   }

//---------------------RECUPERA CORREO-----------------------------//

  String? _itemCedulaRecupera = '';
  String? get getItemCedulaRecupera => _itemCedulaRecupera;

  void setItemCedulaRecupera(String? valor) {
    _itemCedulaRecupera = valor;
// print('LA validaCedula $_itemCedulaRecupera');
    notifyListeners();
  }

//================================== RECUPERA CLAVE ==============================//

  String _empresaRecuperaClave = 'ULTRA2022';

  bool? _errorRecuperaClave; // sera nulo la primera vez
  bool? get getErrorRecuperaClave => _errorRecuperaClave;

  Future? buscaRecuperaClave() async {
    final response = await _api.recuperaClave(
        usuario: _itemCedulaRecupera, empresa: _empresaRecuperaClave);
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

//================================== LISTAR PLANES  ==============================//

  List _listaTodosLosPlanes = [];
  List get getListaTodosLosPlanes => _listaTodosLosPlanes;

  void setListaTodosLosPlanes(List _data) {
    _listaTodosLosPlanes = [];

    _listaTodosLosPlanes = _data;

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

//================================== LISTAR TODAS LA NOTICIAS  ==============================//
  List _listaTodasLasNoticias = [];
  List get getListaTodasLasNoticias => _listaTodasLasNoticias;

  void setListaTodasLasNoticias(List _data) {
    _listaTodasLasNoticias = [];

    _listaTodasLasNoticias = _data;

    print('_listaTodasLasNoticias: $_listaTodasLasNoticias');

    notifyListeners();
  }

  bool? _errorNoticias; // sera nulo la primera vez
  bool? get getErrorNoticias => _errorNoticias;

  Future? buscarNoticias(BuildContext context) async {
    final dataUser = await Auth.instance.getSession();

    final response =
        await _api.getAllNoticias(context: context, token: dataUser['token']);
    if (response != null) {
      _errorNoticias = true;
      setListaTodasLasNoticias(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorNoticias = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== LISTAR TODAS LA NOTIFICACIONES  ==============================//
  List _listaTodasLasNotificaciones = [];
    List get getListaTodasLasNotificaciones => _listaTodasLasNotificaciones;

  void setListaTodasLasNotificaciones(_data) {
    _listaTodasLasNotificaciones = [];

    _listaTodasLasNotificaciones.addAll(_data);

    // print('_listaTodasLasNotificaciones: $_listaTodasLasNotificaciones');       

    notifyListeners();
  }

  bool? _errorNotificaciones; // sera nulo la primera vez
  bool? get getErrorNotificaciones => _errorNotificaciones;

  Future? buscarNotificaciones(BuildContext context) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllNotificaciones(
        context: context, token: dataUser['token']);
    if (response != null) {
      _errorNotificaciones = true;
      setListaTodasLasNotificaciones(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorNotificaciones = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== CREAR NUEVO  ==============================//

  bool? _errorCrearUsuario; // sera nulo la primera vez
  bool? get getErrorCrearUsuario => _errorCrearUsuario;

  Future? crearUsuario(BuildContext context) async {
    final response = await _api.createUserSinToken(context: context, data: {
      "tabla": "usuario",
      "rucempresa": "ULTRA2022",
      "tipoServicio": _itemLugarServicio,
      "cedula": _itemCedua,
      "nombres": _itemNombre,
      "apellidos": _itemApellido,
      "celular": _itemCelulares,
      "email": _itemCorreos,
      "direccion": _itemDireccion,
      "plan": 'NINGUNO',
      "ciudad": _ciudadItem,
      "sector": _sectorItem,
      "referencia": _itemReferencia,
      "fotoPerfil": _urlImagePerfil,
      "fotoCasa": _urlImageCasa,
      "gps": _locationGPS,
      "fotoVehiculo": _urlImageVehiculo,
      "placa": _itemPlaca,
      "marca": _itemMarca,
      "modelo": _itemModelo,
      "color": _itemColor
    });
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

//================================== CREAR NUEVO  ==============================//

  bool? _errorEditarUsuario; // sera nulo la primera vez
  bool? get getErrorEditarUsuario => _errorEditarUsuario;

  Future? editarUsuario(BuildContext context) async {
    // "rucempresa": "ULTRA2022",

    // "tabla": "usuario",
    final dataUser = await Auth.instance.getSession();

    final response = await _api.putUsuarioById(
        context: context,
        token: dataUser['token'],
        idUser: _idUsuario,
        data: {
          "tipoServicio": _itemLugarServicio,
          "cedula": _itemCedua,
          "nombres": _itemNombre,
          "apellidos": _itemApellido,
          "celular": _itemCelulares,
          "email": _itemCorreos,
          "direccion": _itemDireccion,
          "plan": _planItem,
          "ciudad": _ciudadItem,
          "sector": _sectorItem,
          "referencia": _itemReferencia,
          "fotoPerfil": _urlImagePerfil,
          "fotoCasa": _urlImageCasa,
          "gps": _locationGPS,
          "fotoVehiculo": _urlImageVehiculo,
          "placa": _itemPlaca,
          "marca": _itemMarca,
          "modelo": _itemModelo,
          "color": _itemColor
        });

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
  String _urlImage = "";
  String get getUrlImage => _urlImage;
  void setUrlImge(String data, String _tipo) {
    _urlImage = "";
    _urlImage = data;
    // print('IMAGEN URL: $_urlImage');

    notifyListeners();
  }

  String _urlImagePerfil = "";
  String get getUrlPerfil => _urlImagePerfil;

  void setUrlPerfil(String _data) {
    _urlImagePerfil = "";
    _urlImagePerfil = _data;
    // print('PERFIL URL: $_urlImagePerfil');

    notifyListeners();
  }

  String _urlImageCasa = "";
  String get getUrlCasa => _urlImageCasa;

  void setUrlCasa(String _data) {
    _urlImageCasa = "";
    _urlImageCasa = _data;
    print('CASA URL: $_urlImageCasa');

    notifyListeners();
  }

  String _urlImageVehiculo = "";

  String get getUrlVehiculo => _urlImageVehiculo;

  void setUrlVehiculo(String _data) {
    _urlImageVehiculo = "";
    _urlImageVehiculo = _data;
    print('VEHICULO URL: $_urlImageVehiculo');

    notifyListeners();
  }

  bool _errorUrl = true;
  bool get getErrorUrl => _errorUrl;
  void setErrorUrl(bool _data) {
    _errorUrl = _data;
    notifyListeners();
  }

  Future eliminaUrlServerPerfil(String _url) async {
    final Map<String, dynamic> _urlImageDelete = {
      "urls": [
        {"url": _url}
      ],
      "rucempresa": "ULTRA2022"
    };

    final response = await _api.deleteUrlDelServidor(
      datos: _urlImageDelete,
      // token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorUrl = true;
      // setListaUrlse(response['data']);
      // print('ES LOS URLS: ${response}');
      setUrlPerfil('');
      // image== null;

      // print('las variables : image - $_urlImage');
      notifyListeners();
      return 'true';
      // return response;
    }

    if (response == null) {
      _errorUrl = false;
      print('ES LOS URLS: ${response}');
      notifyListeners();
      return 'false';
    }
  }

  Future eliminaUrlServerCasa(String _url) async {
    final Map<String, dynamic> _urlImageDelete = {
      "urls": [
        {"url": _url}
      ],
      "rucempresa": "ULTRA2022"
    };

    final response = await _api.deleteUrlDelServidor(
      datos: _urlImageDelete,
      // token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorUrl = true;
      // setListaUrlse(response['data']);
      // print('ES LOS URLS: ${response}');
      setUrlCasa('');
      // image== null;

      // print('las variables : image - $_urlImage');
      notifyListeners();
      return 'true';
      // return response;
    }

    if (response == null) {
      _errorUrl = false;
      print('ES LOS URLS: ${response}');
      notifyListeners();
      return 'false';
    }
  }

  Future eliminaUrlServerVehiculo(String _url) async {
    final Map<String, dynamic> _urlImageDelete = {
      "urls": [
        {"url": _url}
      ],
      "rucempresa": "ULTRA2022"
    };

    final response = await _api.deleteUrlDelServidor(
      datos: _urlImageDelete,
      // token: '${dataUser!.token}',
    );

    if (response != null) {
      _errorUrl = true;
      // setListaUrlse(response['data']);
      // print('ES LOS URLS: ${response}');
      setUrlCasa('');
      // image== null;

      // print('las variables : image - $_urlImage');
      notifyListeners();
      return 'true';
      // return response;
    }

    if (response == null) {
      _errorUrl = false;
      print('ES LOS URLS: ${response}');
      notifyListeners();
      return 'false';
    }
  }

//-------------------------------------//
  ///AGREGAMOS LA IMAGEN EN PANTALLA ////
  String _url = '';
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setImage(File image, String _tipo) {
    _selectedImage = image;
    _url = _selectedImage!.path;
    if (_tipo == 'fotoperfil') {
      getUrlsServerPerfil();
    } else if (_tipo == 'fotocasa') {
      getUrlsServerCasa();
    } else if (_tipo == 'fotovehiculo') {
      getUrlsServerVehiculo();
    }

    // getUrlsServer( )

    notifyListeners();
  }

  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  void deleteImage() {
    if (_selectedImage != null) {
      _selectedImage!.delete();
      clearImage();
    }
  }

// Future getUrlsServer( ) async {

//     final response = await _api.getUrlsServer(
//         _selectedImage,
//          _fotoTipo!

//     );

//     if (response != null && _fotoTipo=='fotoperfil' ) {
//       _errorUrl = true;
//        setUrlPerfil(response.toString(),);
//        notifyListeners();
//       return response;
//     }
//     else if (response != null && _fotoTipo=='fotocasa' ) {
//         _errorUrl = true;
//         setUrlCasa(response.toString(),);
//        notifyListeners();
//       return response;
//   }
//     else if (response != null && _fotoTipo=='fotovehiculo' ) {
//         _errorUrl = true;
//         setUrlVehiculo(response.toString(),);
//        notifyListeners();
//       return response;
//   }
//     if (response == null) {
//       _errorUrl = false;

//       notifyListeners();

//     }
//   //  return response;

//   }
  Future getUrlsServerPerfil() async {
    try {
      final response = await _api.getUrlsServer(_selectedImage, 'fotoperfil');

      if (response != null) {
        _errorUrl = true;
        setUrlPerfil(
          response.toString(),
        );
        notifyListeners();
        return response;
      }

      if (response == null) {
        _errorUrl = false;

        notifyListeners();
      }
    } catch (e) {
      return false;
    }
  }

  Future getUrlsServerCasa() async {
    try {
      final response = await _api.getUrlsServer(_selectedImage, 'fotocasa');

      if (response != null) {
        _errorUrl = true;
        setUrlCasa(
          response.toString(),
        );
        notifyListeners();
        return response;
      }

      if (response == null) {
        _errorUrl = false;

        notifyListeners();
      }
    } catch (e) {
      return false;
    }
  }

  Future getUrlsServerVehiculo() async {
    try {
      final response = await _api.getUrlsServer(_selectedImage, 'fotovehiculo');

      if (response != null) {
        _errorUrl = true;
        setUrlVehiculo(
          response.toString(),
        );
        notifyListeners();
        return response;
      }

      if (response == null) {
        _errorUrl = false;

        notifyListeners();
      }
    } catch (e) {
      return false;
    }
  }

//========================== GUARDA TOKEN DDE LA NOTIFICACION =======================//
  String? _tokennotificacion;

  String? get getTokennotificacion => _tokennotificacion;
  Future? setTokennotificacion(String? _tokenFM, String _option) async {
    _tokennotificacion = _tokenFM;

// print('el token es :$_tokenFM');

    sentToken(_option);
    notifyListeners();
  }

  bool? _errorGuardatoken; // sera nulo la primera vez
  bool? get getErrorGuardatoken => _errorGuardatoken;
  set setErrorGuardatoken(bool? value) {
    _errorGuardatoken = value;
    notifyListeners();
  }

  Future sentToken(String _option) async {
    final _infoUser = await Auth.instance.getSession();
    final response = await _api.sentTokenFCM(
      option: _option,
      tokennotificacion: _tokennotificacion,
      token: _infoUser['token'],
    );

    if (response != null) {
      _errorGuardatoken = true;

// print('el token se guardo $response');

      return response;
    }
    if (response == null) {
      _errorGuardatoken = false;
      notifyListeners();
      return null;
    }
  }

//-------------obtiene informacion dde la NOTIFICACIONES -----------------------//

  Map<String, dynamic> _infoNotificaacion = {};
  Map<String, dynamic> get getInfoNotificacion => _infoNotificaacion;

  void setInfoNotificacion(Map<String, dynamic> _data) {
    _infoNotificaacion = _data;

//  print('ESTA ES LA INFO DE NOTIFICACION  : $_infoNotificaacion');
    notifyListeners();
  }

//---------------MUESTRA ESTADO DE LA ALARMA PRESIONADA--------------------//
  bool _alarmActivated = false;

  bool get alarmActivated => _alarmActivated;

  void activateAlarm() {
    _alarmActivated = true;
    notifyListeners();

    // Esperar 5 segundos antes de desactivar la alarma
    Timer(Duration(seconds: 40), () {
      _alarmActivated = false;
      notifyListeners();
    });
  }
//----------------GET INFO PERFIL------------------//

  Map<String, dynamic> _infoUsuarioById = {};
  Map<String, dynamic> get getInfoUsuarioById => _infoUsuarioById;
  String? _idUsuario = "";

  void setIngoUsuario(Map<String, dynamic> _info) {
    _infoUsuarioById = {};
    _idUsuario = "";
    _infoUsuarioById = _info;

    _itemCedua = getUser!['usuario'];
    _idUsuario = _infoUsuarioById['perId'].toString();
    _itemNombre = _infoUsuarioById['nombres'];
    _itemApellido = _infoUsuarioById['nombres'];
    _itemDireccion = _infoUsuarioById['direccion'];
    _itemCorreos = _infoUsuarioById['email'];
    _itemCelulares = _infoUsuarioById['celular'];
    _itemIsEdad = true;
    _ciudadItem = _infoUsuarioById['ciudad'];
    _sectorItem = _infoUsuarioById['sector'];
    setItemReferencia(_infoUsuarioById['referencia']??"");
      _urlImagePerfil = _infoUsuarioById['fotoPerfil'];
    _urlImageCasa = _infoUsuarioById['fotoCasa']??"";
    _urlImageVehiculo = _infoUsuarioById['fotoVehiculo']??"";

    _locationGPS = {
      "latitud": _infoUsuarioById['gps']['latitud'],
      "longitud": _infoUsuarioById['gps']['longitud'],
    };
    _locationMessage='${_infoUsuarioById['gps']['latitud']},${_infoUsuarioById['gps']['latitud']}';

    _infoUsuarioById['gps'] ?? '';

    _itemLugarServicio = _infoUsuarioById['tipoServicio'] ?? '';

    _itemPlaca = _infoUsuarioById['placa'] ?? '';
    _itemColor = _infoUsuarioById['color'] ?? '';
    _itemMarca = _infoUsuarioById['marca'] ?? '';
    _itemModelo = _infoUsuarioById['modelo'] ?? '';

    // "data": {
    // 	"perId": 14049,
    // 	"nombres": "Gomez Pedro",
    // 	"celular": "+593958766850",
    // 	"email": "pgomez@gmail.com",
    // 	"direccion": "Calle 1",
    // 	"ciudad": "BORBONES",
    // 	"sector": "sector 1",
    // 	"referencia": "Casa numero 1",
    // 	"fotoPerfil": "https://documentos.neitor.com/contable/fotoperfil/ULTRA2022/96eee234-93e9-4a4c-9fb7-7d12ba3b3c5a.png",
    // 	"fotoCasa": "https://documentos.neitor.com/contable/fotocasa/ULTRA2022/b2ed4c5b-e7db-4e34-8ba3-c32a9480f6c0.png",
    // 	"fotoVehiculo": "",
    // 	"gps": {
    // 		"latitud": "-0.253396",
    // 		"longitud": "-79.176296"
    // 	},
    // 	"tipoServicio": "HOGAR",
    // 	"placa": "ZZZ9999"
    // }

//  print('_infoUsuarioById  : $_infoUsuarioById');

    notifyListeners();
  }

  bool? _errorUserById; // sera nulo la primera vez
  bool? get getErrorUserById => _errorUserById;

  Future? buscaUsuarioById(BuildContext context) async {
    final dataUser = await Auth.instance.getSession();

    final response = await _api.getUsuarioById(
        context: context,
        token: dataUser['token'],
        idUser: dataUser['id'].toString());
    if (response != null) {
      _errorUserById = true;
      setIngoUsuario(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorUserById = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//====== VALIDA LA SESION DEL USUARIO ==========//


 bool? _validaSession=false; // sera nulo la primera vez
  bool? get getValidaSession => _validaSession;
  void setValidaSession(bool? value) {
    _validaSession = value;
     print('_validaSession: $_validaSession');
    notifyListeners();
  }







  Future validaInicioDeSesion() async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.validaTokenUsuarios(
      token: dataUser!['token'],
    );

    if (response != null) {
      // print('EL TOQUEN NUEVO: $response');
        setValidaSession(true);
      await Auth.instance.saveSession(response);
    
      return response;
    }
    if (response == null) {
      // await Auth.instance.deleteSesion(context);
    setValidaSession(false);
      return null;
    }
  }
//---------------------------------//
//====== CIERRA LA SESION DEL USUARIO ==========//

  Future cierreSesionUsuario(BuildContext context) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.putSessionUser(
      context: context,
      token: dataUser!['token'],
    );

    if (response != null) {
      return response;
    }
    if (response == null) {
      return null;
    }
  }
//---------------------------------//

  String? _claveActual = "";
    String? _claveNueva = "";
    String?  _verificaClaveNueva = "";


     String? get getClaveActual => _claveActual;
  void onChangeClaveActual(String text) {
    _claveActual = text;
    //  print('USUARIO: $_usuario');
    notifyListeners();
  }
     String? get getClaveNueva => _claveNueva;
  void onChangeClaveNueva(String text) {
    _claveNueva = text;
    //  print('USUARIO: $_usuario');
    notifyListeners();
  }
 String? get getVerificaClaveNueva => _verificaClaveNueva;
  void onChangeVerificaClaveNueva(String text) {
    _verificaClaveNueva = text;
    //  print('USUARIO: $_usuario');
    notifyListeners();
  }

//====== ACTUALIZA CLAVE DEL USUARIO ==========//

  Future actualizaClaveUsuario(BuildContext context) async {
    final dataUser = await Auth.instance.getSession();
    final response = await _api.putActualizaClave(
        context: context,
        token: dataUser!['token'],
        idUser: dataUser!['id'].toString(),
        nuevaClave: {"newpassword": _claveNueva});

    if (response != null) {
      return response;
    }
    if (response == null) {
      return null;
    }
  }
//---------------------------------//
//====== ACTUALIZA CLAVE DEL USUARIO ==========//

  Future verificaCedulaNuevoCliente(BuildContext context) async {
  
    final response = await _api.getVerificaCedulaNuevoCliente(
          cedula: _itemCedua);

    if (response != null) {
      return response;
    }
    if (response == null) {
      return null;
    }
  }
//---------------------------------//



//====== BUSCA NOTIFICACION POR ID FIREBASE==========//

  Future buscaNotificacionPorId(BuildContext context, String _idFirebase) async {
  

    final dataUser = await Auth.instance.getSession();
    final response = await _api.getNotificacionId(
        context: context,
        token: dataUser!['token'],
        idUsuario: _idFirebase.toString());
       

    if (response != null) {
     setInfoNotificacion(response);
      return response;
    }
    if (response == null) {
      return null;
    }
  }
//--------------- PERMISOS DE LA APLICACION ------------------//
  // PermissionStatus? _locationPermissionStatus;

  // PermissionStatus? get locationPermissionStatus => _locationPermissionStatus;

  // Future<void> checkLocationPermission() async {
  //   _locationPermissionStatus = await Permission.location.status;
  //   notifyListeners();
  // }

  // Future<void> requestLocationPermission() async {
  //   var result = await Permission.location.request();
  //   _locationPermissionStatus = result;
  //   notifyListeners();
  // }

  // bool _hasLocationPermission = false;

  // bool get hasLocationPermission => _hasLocationPermission;

  // Future<void> checkAndRequestLocationPermission() async {
  //   PermissionStatus status = await Permission.location.status;

  //   if (status.isGranted) {
  //     _hasLocationPermission = true;
  //   } else {
  //     status = await Permission.location.request();
  //     _hasLocationPermission = status.isGranted;
  //   }

  //   // Notifica a los oyentes (widgets) sobre el cambio en el estado
  //   notifyListeners();
  // }

  
// bool _hasLocationPermission = false;

//   bool get hasLocationPermission => _hasLocationPermission;

//   Future<void> checkAndRequestLocationPermission() async {
//     PermissionStatus status = await Permission.location.status;

//     if (status.isGranted) {
//       _hasLocationPermission = true;
//     } else {
//       status = await Permission.location.request();
//       _hasLocationPermission = status.isGranted;
//     }

//     // Notifica a los oyentes (widgets) sobre el cambio en el estado
//     notifyListeners();
//   }

//   Future<bool> checkGpsStatus() async {
//     bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
//     return isGpsEnabled;
//   }


 bool _hasLocationPermission = false;
  bool _hasCameraPermission = false;

  bool get hasLocationPermission => _hasLocationPermission;
  bool get hasCameraPermission => _hasCameraPermission;

  Future<void> checkAndRequestPermissions() async {
    // Verificación y solicitud de permisos de ubicación
    PermissionStatus locationStatus = await Permission.location.status;
    if (locationStatus.isGranted) {
      _hasLocationPermission = true;
    } else {
      locationStatus = await Permission.location.request();
      _hasLocationPermission = locationStatus.isGranted;
    }

    // Verificación y solicitud de permisos de la cámara
    PermissionStatus cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      _hasCameraPermission = true;
    } else {
      cameraStatus = await Permission.camera.request();
      _hasCameraPermission = cameraStatus.isGranted;
    }

    // Notifica a los oyentes (widgets) sobre el cambio en el estado
    notifyListeners();
  }

  Future<bool> checkGpsStatus() async {
    if (_hasLocationPermission) {
      bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
      return isGpsEnabled;
    } else {
      return false;
    }
  }






}
