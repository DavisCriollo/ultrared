
import 'package:flutter/material.dart';

import 'package:ultrared/src/api/api_provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';


class LoginController extends ChangeNotifier {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
 final _api = ApiProvider();
  // AuthResponse? _dataLogin;

   Map< String,dynamic> ? infoUser;

  bool? _recuerdaCredenciales = true;

  String? _usuario = "", _clave = "";
  void onChangeUser(String text) {
    _usuario = text;
  }

  void onChangeClave(String text) {
    _clave = text;
  }

  bool? get getRecuerdaCredenciales => _recuerdaCredenciales;
  String? get getUsuario => _usuario;
  String? get getClave => _clave;

  bool validateForm() {
    if (loginFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

//========================== DROPDOWN MOTIVO AUSENCIA =======================//

  String? _textNombreEmpresa = "ULTRA2022";
  String? get getlNombreEmpresa => _textNombreEmpresa;

  void setLabelNombreEmpresa(String value) {
    _textNombreEmpresa = value;
    notifyListeners();
  }

  //========================== DATA PARA SOCKET =======================//
  String _token = "";
  String _cedula = "";

  String get token => _token;
  String get cedula => _cedula;

  void login(String token, String cedula) {
    _token = token;
    _cedula = cedula;
    notifyListeners();
  }
  //========================== LOGIN =======================//
  Future loginApp(BuildContext context) async {
    // List _creddenciales = [];
    final response = await _api.login(
        empresa: _textNombreEmpresa!.trim(),
        usuario: _usuario!.trim(),
        password: _clave!.trim());

    if (response != null) {
     
      await Auth.instance.saveSession(response);
      infoUser = await Auth.instance.getSession();
      // if (_recuerdaCredenciales == true) {
      //   await Auth.instance.saveDataRecordarme(_creddenciales);
      // }
      // _dataLogin = response;
      
      return response;
    }
    if (response == null) {
      return null;
    }
  }

  //====================================== RECORDAR CLAVE ======================================//
  void onRecuerdaCredenciales(bool value) {
    _recuerdaCredenciales = value;
    notifyListeners();
    }





    
    }
  