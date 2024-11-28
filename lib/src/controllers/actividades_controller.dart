


import 'package:flutter/material.dart';
import 'package:ultrared/src/api/api_provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';

class ActividadesController extends ChangeNotifier {
  GlobalKey<FormState> actividadesFormKey = GlobalKey<FormState>();

final _api = ApiProvider();




bool validateFormCelular() {
    if (actividadesFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }




//====== ALISTA LAS ACTIVIDADES ==========//
List _listaActividades=[];
List get listaActividades=>_listaActividades;

void setListaActividades(List _list){
  _listaActividades=[];
  for (var item in _list) {
    _listaActividades.add(item);
  }
      

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











}