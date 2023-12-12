import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ultrared/src/models/auth_response.dart';


import 'package:ultrared/src/models/sessio_model.dart';

class Auth {
  Auth.internal();
  static final Auth _instance = Auth.internal();
  static Auth get instance => _instance;

  final _storage = const FlutterSecureStorage();
  final keySESION = 'SESSION';

  final keyCREDENCIALES = 'CEDENCIALES';
  final keyTOKENFIREBASE = 'TOKENFIREBASE';
  final keyRONDAS = 'RONDASACTIVIDAD';
  final keyIDREGISTRO = 'IDREGISTRO';

// GUARDO LA INFORMACION EN EL DISPOSITIVO
  Future<void> saveSession(  Map< String,dynamic>  data) async {
    // final Session session = Session(
    //   //============================//
    //   // token: data.token,
    //   // id: data.id,
    //   // nombre: data.nombre,
    //   // usuario: data.usuario,
    //   // rucempresa: data.rucempresa,
    //   // codigo: data.codigo,
    //   // nomEmpresa: data.nomEmpresa,
    //   // nomComercial: data.nomComercial,
    //   // fechaCaducaFirma: data.fechaCaducaFirma,
    //   // rol: data.rol,
    //   // tipografia: data.tipografia,
    //   // logo: data.logo,
    //   // areadepartamento: data.areadepartamento,
    //   // foto: data.foto,
    //   // empCategoria: data.empCategoria,
    //   // colorPrimario: data.colorPrimario,
    //   // colorSecundario: data.colorSecundario,
    //   //============================/
    //    token  : data['token'],
    //    id: data['id'],
    //    nombre  :data['nombre'],
    //    usuario  :data['usuario'],
    //    rucempresa:data['rucempresa'],
    //    codigo:data['codigo'],
    //    nomEmpresa:data['nomEmpresa'],
    //    nomComercial:data['nomComercial'],
    //   //  fechaCaducaFirma :data['fechaCaducaFirma'] ,
    //   //  rol :data['rol'] ,
    //    empCategoria :data['empCategoria'] ,
    //    logo :data['logo'] ,
    //    foto :data['foto'] ,
    //    colorPrimario :data['colorPrimario'] ,
    //    colorSecundario :data['colorSecundario'] ,
    //   //  empRoles :data['empRoles'] ,
    //    permisosUsuario :data['permisosUsuario'] ,
    //   //============================/
    // );

    final String value = jsonEncode(data);
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keySESION, value: value);
// print('LA SESION SE GUARDO $value');

  }

// OBTEMENOS LA INFORMACION DEL DISPOSITIVO
  Future getSession() async {
    final String? value = await _storage.read(key: keySESION);
    if (value != null) {
      final Map<String, dynamic> json = jsonDecode(value);
      // final session = Session.fromJson(jsonDecode(value));
      // return session;
        // print('LA INFO DEL MOVIL; $json ');


      return json;
    }
    return null;
  }

  // CIERRO SESSION
  Future<void> deleteSesion(BuildContext context) async {
    // await _storage.deleteAll();
    await _storage.delete(key: keySESION);
    //  print('SESION ELIMINADA:$keySESION');
    Navigator.pushNamedAndRemoveUntil(context, 'serCliente', (_) => false);
  }
  // CIERRO SESSION
  Future<void> deleteCache(BuildContext context) async {
    // await _storage.deleteAll();
    await _storage.delete(key: keySESION);
 
  }

 

  // ============================================= TOKEN FIREBASE =======================//

  Future<void> saveTokenFireBase(String data) async {
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keyTOKENFIREBASE, value: data);
      print('TOKEN FCM guardad :$data');
  }

  // OBTEMENOS EL TOKENFIREBASE   DEL DISPOSITIVO
  Future getTokenFireBase() async {
    final String? value = await _storage.read(key: keyTOKENFIREBASE);
    if (value != null) {
      return value;
    }
    return null;
  }

  // ELIMINA TOKEN FIREBASE
  Future<void> deleteTokenFireBase() async {
    print('turno FCM eliminado:$keyTOKENFIREBASE');
    await _storage.delete(key: keyTOKENFIREBASE);
  }

  // ============================================= GUARDA ID REGISTRO =======================//

  Future<void> saveIdRegistro(String? data) async {
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keyIDREGISTRO, value: data);

    // print('turno guardado:$data');
   
  }

  // OBTEMENOS EL ID REGISTRO  DEL DISPOSITIVO
  Future getIdRegistro() async {
    final String? value = await _storage.read(key: keyIDREGISTRO);
    if (value != null) {
      return value;
    }
    return null;
  }

  // ELIMINA ID REGISTRO
  Future<void> deleteIdRegistro() async {
    await _storage.delete(key: keyIDREGISTRO);
  }

  
  //=========================================================================//
  // GUARDO RECORDAR CONTRASENA EN EL DISPOSITIVO
  Future<void> saveDataRecordarme(List<dynamic> _recordarme) async {
// CONVERTIMOS  LA INFORMACION  A STRING PARA GUARDAR AL DISPOSITIVO
    final String value = jsonEncode(_recordarme);
// GUARDAMOS LA INFORMACION DEL DISPOSITIVO
    await _storage.write(key: keyCREDENCIALES, value: value);
  }

// OBTEMENOS LA INFORMACION DEL credenciales
  Future getDataRecordarme() async {
    final String? datosCredencial = await _storage.read(key: keyCREDENCIALES);
    if (datosCredencial != null) {
      final getDatosCredencial = jsonDecode(datosCredencial);
      return getDatosCredencial;
    }
    return null;
  }

// CIERRO SESSION
  Future<void> deleteDataRecordarme() async {
    await _storage.delete(key: keyCREDENCIALES);
  }

  //=========================================================================//

}
