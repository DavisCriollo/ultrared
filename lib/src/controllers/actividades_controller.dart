


import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ultrared/bdd/data_base_helper.dart';
import 'package:ultrared/src/api/api_provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';

class ActividadesController extends ChangeNotifier {
  GlobalKey<FormState> actividadesFormKey = GlobalKey<FormState>();

final _api = ApiProvider();




bool validateFormActividade() {
    if (actividadesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }




//====== LISTA LAS ACTIVIDADES ==========//
List _listaActividades=[];
List get listaActividades=>_listaActividades;

void setListaActividades(List _list){
  _listaActividades=[];
  for (var item in _list) {
    _listaActividades.add(item);
  }
      print('LA DATA ON LINE: $_listaActividades');  

notifyListeners();
}

Future buscaActividades(BuildContext context) async {
  final dataUser = await Auth.instance.getSession();
  final response = await _api.getAllActividades(
    context: context,
    token: dataUser!['token'],
  );

  if (response != null) {

    final actividadesFiltradas = response.where((actividad) {
      return actividad['actaEstado'] == _tipoPeticion; // Ajusta la clave según tu estructura
    }).toList();
      setListaActividades(actividadesFiltradas);
            setListFilter(actividadesFiltradas); 

  
    notifyListeners(); // Notifica después de llenar las listas
    return response;
  }

  if (response == null) {
    return null;
  }
}
//=================BUSCADOR LOCAL==================//

 List<dynamic> _allItemsFilters=[];
   List<dynamic> get allItemsFilters => _allItemsFilters;
   void setListFilter( List<dynamic> _list){
  _allItemsFilters = [];

_allItemsFilters.addAll(_list);

   }
   
void search(String query) {
  List<Map<String, dynamic>> originalList = List.from(_listaActividades);

  if (query.isEmpty) {
    _allItemsFilters = originalList;
  } else {
    _allItemsFilters = originalList.where((item) {
      String actFecReg = item['actaFecReg'];
      DateTime parsedDate = DateTime.parse(actFecReg);
      String fechaFormateada = "${parsedDate.year.toString().padLeft(4, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')} ${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}";

      return 
        fechaFormateada.toLowerCase().contains(query.toLowerCase()) ||
        item['actaNombreCliente'].toLowerCase().contains(query.toLowerCase()) ||
         item['actaDocCliente'].toLowerCase().contains(query.toLowerCase()) ||
         item['actaTipo'].toLowerCase().contains(query.toLowerCase()) ||
            item['actaServiciosVisita'].toLowerCase().contains(query.toLowerCase()) ||
             item['actaCiudad'].toLowerCase().contains(query.toLowerCase()) ||
        item['actaCiudad'].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  notifyListeners(); // Notifica cambios
}

//==================TIPO DE PETICION A LAS ACTIVIDADES PENDIENTES - PROCESADOS==========================//

 String?  _tipoPeticion ='';

   String? get tipoPeticion => _tipoPeticion;
  void setTipoPeticion(String text) {
    _tipoPeticion = text;
    //  print('USUARIO: $_usuario');
    notifyListeners();
  }

//==================== BDD  OFFLINE=========================//



//====== LISTA LAS ACTIVIDADES ==========//
List _listaActividadesOffLine=[];
List get listaActividadesOffLine=>_listaActividadesOffLine;

void setListaActividadesOffLine(List _list){
  _listaActividadesOffLine=[];
  for (var item in _list) {
    _listaActividadesOffLine.add(item);
  }
      
  print('LA DATA OFFLINE: $_listaActividadesOffLine');
notifyListeners();
}

Future buscaActividadesOffLine(BuildContext context) async {
  final dataUser = await Auth.instance.getSession();
  final response = await _api.getAllActividades(
    context: context,
    token: dataUser!['token'],
  );

  if (response != null) {

//  final List<dynamic> actasList = response;

        // Guardar cada acta en SQLite
        // for (var acta in actasList) {
        //   await DatabaseHelper().insertActa(acta);
        // }

        // Refrescar la lista después de guardar
        // await fetchActas();


    // final actividadesFiltradasOffLine = response.where((actividad) {
    //   return actividad['actaEstado'] == _tipoPeticion; // Ajusta la clave según tu estructura
    // }).toList();

      // setListaActividadesOffLine(actividadesFiltradasOffLine);
      //       setListFilterOffLine(actividadesFiltradasOffLine); 

  
        for (var acta in response) {
          await insertActa({
            'actaId': acta['actaId'],
            'actaIdCliente': acta['actaIdCliente'],
            'actaIdPersonaEntrega': acta['actaIdPersonaEntrega'],
            'actaIdVendedor': acta['actaIdVendedor'],
            'actaFecha': acta['actaFecha'],
            'actaFechaInstalacion': acta['actaFechaInstalacion'],
            'actaOpcion': acta['actaOpcion'],
            'actaEstado': acta['actaEstado'],
            'actaDetalleEstado': acta['actaDetalleEstado'],
            'actaTipo': acta['actaTipo'],
            'actaSeEncuentraCliente': acta['actaSeEncuentraCliente'],
            'actaServiciosVisita': acta['actaServiciosVisita'],
            'actaRedWifi': acta['actaRedWifi'],
            'actaClave': acta['actaClave'],
            'actaClienteRegulador': acta['actaClienteRegulador'],
            'actaConfigRouter': acta['actaConfigRouter'],
            'actaValorRouter': acta['actaValorRouter'],
            'actaCambioPatch': acta['actaCambioPatch'],
            'actaValorPatch': acta['actaValorPatch'],
            'actaCalidadIns': acta['actaCalidadIns'],
            'actaSolucionReq': acta['actaSolucionReq'],
            'actaRecNombre': acta['actaRecNombre'],
            'actaRecFirma': acta['actaRecFirma'],
            'actaEntFirma': acta['actaEntFirma'],
            'actaUser': acta['actaUser'],
            'correo_nuevo_registro': acta['correo_nuevo_registro'],
            'actaEmpresa': acta['actaEmpresa'],
            'actaIdPlanInternet': acta['actaIdPlanInternet'],
            'actaCiudad': acta['actaCiudad'],
            'actaFecReg': acta['actaFecReg'],
            'actaFecUpd': acta['actaFecUpd'],
            'actaDocCliente': acta['actaDocCliente'],
            'actaNombreCliente': acta['actaNombreCliente'],
            'actaDireccionCliente': acta['actaDireccionCliente'],
            'actaEntDoc': acta['actaEntDoc'],
            'actaEntNombre': acta['actaEntNombre'],
            'actaDocVendedor': acta['actaDocVendedor'],
            'actaNombreVendedor': acta['actaNombreVendedor'],
            'planNombreInternet': acta['planNombreInternet'],
            'planValorInternet': acta['planValorInternet'],
            'planMegasInternet': acta['planMegasInternet'],
            'actaFotos': jsonEncode(acta['actaFotos']),
            'actaUbicacion': jsonEncode(acta['actaUbicacion']),
            'actaEquiposInstalados': jsonEncode(acta['actaEquiposInstalados']),
            'actaCargosAdicionales': jsonEncode(acta['actaCargosAdicionales']),
            'actaTelCliente': jsonEncode(acta['actaTelCliente']),
            'actaEmailCliente': jsonEncode(acta['actaEmailCliente']),
            'actaSector': jsonEncode(acta['actaSector']),
          });
        }

    notifyListeners(); // Notifica después de llenar las listas
    return response;
  }

  if (response == null) {
    return null;
  }
}
//=================BUSCADOR LOCAL==================//

 List<dynamic> _allItemsFiltersOffLine=[];
   List<dynamic> get allItemsFiltersOffLine => _allItemsFiltersOffLine;
   void setListFilterOffLine( List<dynamic> _list){
  _allItemsFiltersOffLine = [];

_allItemsFiltersOffLine.addAll(_list);

   }
   
void searchOffLine(String query) {
  List<Map<String, dynamic>> originalListOffLine = List.from(_listaActividadesOffLine);

  if (query.isEmpty) {
    _allItemsFiltersOffLine = originalListOffLine;
  } else {
    _allItemsFiltersOffLine = originalListOffLine.where((item) {
      String actFecReg = item['actaFecReg'];
      DateTime parsedDate = DateTime.parse(actFecReg);
      String fechaFormateada = "${parsedDate.year.toString().padLeft(4, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')} ${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}";

      return 
        fechaFormateada.toLowerCase().contains(query.toLowerCase()) ||
        item['actaNombreCliente'].toLowerCase().contains(query.toLowerCase()) ||
         item['actaDocCliente'].toLowerCase().contains(query.toLowerCase()) ||
         item['actaTipo'].toLowerCase().contains(query.toLowerCase()) ||
            item['actaServiciosVisita'].toLowerCase().contains(query.toLowerCase()) ||
             item['actaCiudad'].toLowerCase().contains(query.toLowerCase()) ||
        item['actaCiudad'].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  notifyListeners(); // Notifica cambios
}

//***********************  BASE DE DATOS LOCAL ******************************///

final dbHelper = DatabaseHelper();


  Future<void> insertActa(Map<String, dynamic> acta) async {
    final db = await dbHelper.database;

    await db.insert(
      'actas',
      acta,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
     print('GUARDADO EN LA BASE');

    notifyListeners();
  }

 List<Map<String, dynamic>> _actas = [];

  List<Map<String, dynamic>> get actas => _actas;

  // Obtener todos los registros de la base de datos
  Future<void> fetchActas() async {
    _actas = await DatabaseHelper().getAllActas();


 final actividadesFiltradasOffLine = _actas.where((actividad) {
      return actividad['actaEstado'] == _tipoPeticion; // Ajusta la clave según tu estructura
    }).toList();
      setListaActividadesOffLine(actividadesFiltradasOffLine);
            setListFilterOffLine(actividadesFiltradasOffLine);  
    notifyListeners();
  }

  // Actualizar el estado de un acta
  Future<void> updateActa(int actaId, String nuevoEstado) async {
    await DatabaseHelper().updateActa(actaId, nuevoEstado);
    fetchActas();  // Refrescar la lista después de actualizar
  }

  // Eliminar un acta
  Future<void> deleteActa(int actaId) async {
    await DatabaseHelper().deleteActa(actaId);
    fetchActas();  // Refrescar la lista después de eliminar
  }



//================ OBTENEMOS LA DATA DE LA ACTIVIDAD  ======================//

dynamic _infoActividad={};
dynamic get getInfoActividad=> _infoActividad;
void setInfoActividad(dynamic _info){

_infoActividad={};
_infoActividad=_info;

_labelEstado=_infoActividad['actaEstado'];
 _selectedRegulador = _infoActividad['actaClienteRegulador']??'' ;

_selectedConfigRouter=_infoActividad['actaConfigRouter']??'';
_selectedCambioPatch= _infoActividad['actaCambioPatch']??'';

_inputDetalle=_infoActividad['actaDetalleEstado']??'';
_inputWifi=_infoActividad['actaRedWifi']??'';
_inputClave=_infoActividad['actaClave']??'';
_obsInstalacion=_infoActividad['actaCalidadIns']??'';




  notifyListeners();
}



//================ ITEMS ACTIVIDAD  ======================//
 String? _inputDetalle;
  String? get getInputDetalle => _inputDetalle;
  void onDetalleChange(String? text) {
    _inputDetalle = text;
    // print(_inputDetalle);
    notifyListeners();
  }
 String? _inputWifi;
  String? get getInputWifi => _inputWifi;
  void onWifiChange(String? text) {
    _inputWifi = text;
    // print(_inputDetalle);
    notifyListeners();
  }
String? _inputClave;
  String? get getInputClave => _inputClave;
  void onClaveChange(String? text) {
    _inputClave = text;
    // print(_inputDetalle);
    notifyListeners();
  }
 // Valor inicial: "No"
  String _selectedRegulador = 'No';

  String get selectedRegulador => _selectedRegulador;

  void setSelectedRegulador(String opt) {
    _selectedRegulador = opt;
    notifyListeners();
  }


 // Valor inicial: "No"
  String _selectedConfigRouter = 'No';

  String get selectedConfigRouter => _selectedConfigRouter;

  void setSelectedConfigRouter(String opt) {
    _selectedConfigRouter = opt;
    notifyListeners();
  }

 // Valor inicial: "No"
  String _selectedCambioPatch = 'No';

  String get selectedCambioPatch => _selectedCambioPatch;

  void setSelectedCambioPatch(String opt) {
    _selectedCambioPatch = opt;
    notifyListeners();
  }

String? _obsInstalacion;
  String? get getObsInstalacion => _obsInstalacion;
  void onObsInstalacionChange(String? text) {
    _obsInstalacion = text;
    // print(_inputDetalle);
    notifyListeners();
  }

//====================   TOMA FOTO ========================//

  List<File> images = [];
  final ImagePicker _picker = ImagePicker();

  // Método para tomar una foto con la cámara
  Future<void> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
        notifyListeners(); // Notificar a los oyentes que se ha añadido una nueva imagen
      }
    } catch (e) {
      print("Error al tomar la foto: $e");
    }
  }

  // Método para seleccionar una imagen de la galería
  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
        notifyListeners(); // Notificar a los oyentes que se ha añadido una nueva imagen
      }
    } catch (e) {
      print("Error al seleccionar la imagen: $e");
    }
  }

  // Método para eliminar una imagen
  void removeImage(File image) {
    images.remove(image);
    notifyListeners(); // Notificar a los oyentes que se ha eliminado una imagen
  }
//==================RESET LISTA IMAGES=======================//

void removeImages() {
    images.clear();
    _urlsImagesActividad = [];
    notifyListeners(); // Notificar a los oyentes que se ha eliminado una imagen
  }



//=========================== GUARDAMOS LISTA DE IMAGENES AL SERVIDOR=====================================//
 List _urlsImagesActividad = [];

  List get getUrlsActividades => _urlsImagesActividad;

  void setUrlActividad(List _data) {
    _urlsImagesActividad = [];
    for (var item in _data) {
       _urlsImagesActividad.addAll(item);
    }
    
    print('ACTIVIDADES URL: $_urlsImagesActividad');
    crearActividad();

    notifyListeners();
  }
 
Future getAllUrlsServerActividad() async {

    final dataUser = await Auth.instance.getSession();
    try {
      final response = await _api.getUrlsServerActividades(images, dataUser!['token']);

      if (response != null) {
      
        setUrlActividad(
          response,
        );
        notifyListeners();
        return response;
      }

      if (response == null) {
         notifyListeners();
       return null;

       
      }
    } catch (e) {
      return false;
    }
  }

//=========================== CREAMOS LA ACTIVIDAD=====================================//

Future crearActividad() async {

    final dataUser = await Auth.instance.getSession();

 Map<String,dynamic> _infoData=
{
  "info_data": [
    {
      "actaId": _infoActividad['actaId'],
      "actaEstado": _labelEstado,
      "actaDetalleEstado": _inputDetalle,
      "actaRedWifi": _inputWifi,
      "actaClave": _inputClave,
      "actaClienteRegulador": _selectedRegulador,
      "actaConfigRouter":_selectedConfigRouter,
      "actaCambioPatch": _selectedCambioPatch,
      "actaCalidadIns": _obsInstalacion,
      "actaFotos": _urlsImagesActividad
    }
  ]


 };

//  print('LA TOKEN Q VA AL SERVER ${dataUser!['token']}');
//  print('LA INFO Q VA AL SERVER $_infoData');






    try {
      final response = await _api.saveActividadedServer(data:_infoData, token:dataUser!['token']);

      if (response != null) {
      
        setUrlActividad(
          response,
        );
        notifyListeners();
        return response;
      }

      if (response == null) {
         notifyListeners();
       return null;

       
      }
    } catch (e) {
      return false;
    }
  }



  String? _labelEstado;

  String? get labelEstado => _labelEstado;

  void setLabelEstado(String value) {
    _labelEstado = value;
    notifyListeners();
  }


}