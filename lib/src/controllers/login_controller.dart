
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
    //  print('USUARIO: $_usuario');
    notifyListeners();
  }

  void onChangeClave(String text) {
    _clave = text;
      print('CLAVE: $_clave');
    notifyListeners();
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
    // print('EMPRESA: $_textNombreEmpresa');
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
    List _creddenciales = [];
    final response = await _api.login(
        empresa: _textNombreEmpresa!.trim(),
        usuario: _usuario!.trim(),
        password: _clave!.trim());


        // print('LA DATA EN CONTROLL : $response');

    if (response != null ) {
      _creddenciales.addAll([
        '$_recuerdaCredenciales',
        '$_textNombreEmpresa',
        '$_usuario',
        '$_clave'
      ]);
     
      await Auth.instance.deleteDataRecordarme();

      await Auth.instance.saveSession(response);
      infoUser = await Auth.instance.getSession();
      if (_recuerdaCredenciales == true) {
        await Auth.instance.saveDataRecordarme(_creddenciales);
      }
      // _dataLogin = response;
      
      return response;
    }
    if (response == null) {
      return response;
    }
  }

  //====================================== RECORDAR CLAVE ======================================//
  void onRecuerdaCredenciales(bool value) {
    _recuerdaCredenciales = value;

        // print('LA DATA EN CONTROLL : $_recuerdaCredenciales');
    notifyListeners();
    }





    
    }
  