// import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
// import 'dart:js';

import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/models/auth_response.dart';
import 'package:ultrared/src/models/foto_url.dart';

import 'package:ultrared/src/service/notifications_service.dart' as snaks;

class ApiProvider {
//================================= URLS ==============================//
  final String _dirURL = "https://testconta.neitor.com/api";
//=================================  ==============================//
//================================= URLS ==============================//
  // final String _dirURL = "https://jback.neitor.com/api";
//=================================  ==============================//

  // Future<AuthResponse?> login({
  Future login({
    BuildContext? context,
    String? usuario,
    String? password,
    String? empresa,
  }) async {
    try {
      final dataResp =
          await _http.post(Uri.parse('$_dirURL/auth/login'), body: {
        "usuario": usuario,
        "password": password,
        "empresa": empresa,
  //   "usuario": "admin",
	// "password": "Admin**+21",
	// "empresa": "ULTRA2022"
      });
      final respo = jsonDecode(dataResp.body);

      // print('LA DATA ---------------------->: $respo');

      if (dataResp.statusCode == 404) {
        snaks.NotificatiosnService.showSnackBarDanger("${respo["msg"]}");
        return null;
      }
      if (dataResp.statusCode == 200) {
        // final responsData = AuthResponse.fromMap(respo);
        // return responsData;
        return respo;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      print('-ERROR -> $e');
    }
  }

//================================= RECUPERA CLAVE ==============================//
  Future recuperaClave({
    BuildContext? context,
    String? usuario,
    String? empresa,
  }) async {
    try {
      final dataResp = await _http.post(Uri.parse('$_dirURL/auth/password'),
          body: {"usuario": usuario, "empresa": empresa});
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        return respo;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      print('-ERROR -> $e');
    }
  }

  //=========================GET ALL CIUDADES =====================================//
  Future getAllCiudades({
    BuildContext? context,
    String? token,
    String? notificacion,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/ciudades/filtroNotToken/0');

      final dataResp = await _http.get(
        url,
        // headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        return respo;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //=========================GET ALL CIUDADES =====================================//
  Future getAllPlanesSinToken({
    BuildContext? context,
    String? token,
    String? notificacion,
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/planes/filtroNotToken/0');

      final dataResp = await _http.get(
        url,
        // headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        return respo;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }
  //=========================CREAR USUARIOS =====================================//
  Future createUserSinToken({
    BuildContext? context,
    Map<String,dynamic>? data,
  }) async {



  try {

 final uri = Uri.parse('$_dirURL/usuarios');
      final headers = {
        'Content-Type': 'application/json',
       
      };
      Map<String, dynamic> body = data!;
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final dataResp = await _http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );


      final respo = jsonDecode(dataResp.body);


      if (dataResp.statusCode == 404) {
        snaks.NotificatiosnService.showSnackBarDanger("${respo["msg"]}");
        return null;
      }
      if (dataResp.statusCode == 200) {
        // final responsData = AuthResponse.fromMap(respo);
        // return responsData;
        return respo;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      print('-ERROR -> $e');
    }
  }
 //=========================ENVIA LOS URLTEMPORALES =====================================//

// Future saveUrlAlServidor(BuildContext? context,String image,  String? token) async {
//   try {
//      var request = _http.MultipartRequest(
//         'POST', Uri.parse('$_dirURL/upload_delete_multiple_files/upload'));

//     //for token
//     request.headers.addAll({"x-auth-token": '$token'});

//     request.files
//         .add(await _http.MultipartFile.fromPath('fotoperfil', image));

//     //for completeing the request
//     var response = await request.send();

//     //for getting and decoding the response into json format
//     var responsed = await _http.Response.fromStream(response);
//     // final responseData = json.decode(responsed.body);
// // print('LISTA SERVER: ${responsed.body}');
// print('LISTA SERVER: ${responsed.body}');
//       if (responsed.statusCode == 404) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "No se puede agregar Contenido");

//         return null;
      
//       }
//       if (responsed.statusCode == 200) {
//       final responseFoto = FotoUrl.fromJson(responsed.body);
//       print('LISTA foto: ${responseFoto.urls[0].url}');
//      return  responseFoto.urls[0].url;
//       }
//       if (responsed.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;

//       }



//   } catch (e) {
//  return null;
//   }
 

// }





Future saveUrlAlServidor({ BuildContext? context,File? urlFile, String? token}) async {
  try {
     var request = _http.MultipartRequest(
        'POST', Uri.parse('$_dirURL/upload_delete_multiple_files/uploadNotToken'));

    //for token
    // request.headers.addAll({"x-auth-token": '$token'});

    request.files
        .add(await _http.MultipartFile.fromPath('foto', urlFile!.path));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await _http.Response.fromStream(response);
    // final responseData = json.decode(responsed.body);
// print('LISTA SERVER: ${responsed.body}');
      if (responsed.statusCode == 404) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "No se puede agregar Contenido");

        return null;
      
      }
      if (responsed.statusCode == 200) {
      final responseFoto = FotoUrl.fromJson(responsed.body);
      // print('LISTA foto: ${responseFoto.urls[0].url}');
     return  responseFoto.urls[0].url;
      }
      if (responsed.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "Debe inciar sesión nuevamente");

        return null;

      }



  } catch (e) {
 return null;
  }

   

}








//-------------IMAGEN AL SERVIDOR----------------//


  Future uploadImage({
    required File image,
     required String imageType,
    required String enterprices,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/upload_delete_multiple_files/uploadNotToken'); // Reemplaza con la URL correcta
      final request = _http.MultipartRequest('POST', url);

      // Adjunta la imagen al formulario multipart
      request.files.add(await _http.MultipartFile.fromPath(
        'foto',
        image.path,
        ));

      // Agrega otros campos al formulario multipart
      request.fields['archivo'] =image.path;
      request.fields['tipo'] = imageType;
      request.fields['rucempresa'] = enterprices;

      // Envía la solicitud y obtén la respuesta
      final response = await request.send();

      if (response.statusCode == 200) {
        // Procesa la respuesta según tus necesidades
       return  await response.stream.bytesToString();
        // notifyListeners();
      } else {
        throw Exception('Error al cargar la imagen. Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error al cargar la imagen: $error');
    }
  }




//=========================GET ALL GRUPOS CHAT =====================================//
  Future getAllGruposChat({
    BuildContext? context,
    String? token,
    
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/messages/byPerId/0');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        return respo;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

//=========================GET ALL GRUPOS CHAT =====================================//
  Future getAllUsuariosChat({
    BuildContext? context,
    int? idChat, 
    String? token,
    
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/messages/participantes?chat_id=$idChat');

      final dataResp = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );


// print('INFO DE LA CONSULTA UUARIOS DEL CHAT ${dataResp.body}');



      final respo = jsonDecode(dataResp.body);
      if (dataResp.statusCode == 200) {
        return respo;
      }

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

//   //=========================GET ALL COMUNICADOS CLIENTES =====================================//
//   Future getAllComunicados({
//     BuildContext? context,
//     String? token,
//     String? search,

//     String? notificacion,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/avisos/filtro/0?&search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL MULTAS=====================================//
//   Future getAllMultasGuardias({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(

//           // 'https://backsigeop.neitor.com/api/nominanovedades/filtro/0?search=$search&notificacion=$notificacion');
//           '$_dirURL/nominanovedades/filtro/0?search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL CLIENTE MULTAS GUALDIAS =====================================//

//   Future getAllClientesMultas({
//     BuildContext? context,
//     String? search,
//     String? estado,
//     String? token,
//   }) async {
//     try {
//       final url =
//           Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$estado');
//           final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL PUESTOS GUALDIAS =====================================//

//   Future getAllPuestosClientes({
//     BuildContext? context,
//     String? search,
//     String? estado,
//     String? token,
//   }) async {
//     try {
//       final url =
//           Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$estado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL CLIENTE MULTAS  =====================================//
//   Future<AllClientes?> getAllClientes({
//     BuildContext? context,
//     String? search,
//     String? estado,
//     String? token,
//   }) async {
//     try {
//       final url =
//           Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$estado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.statusCode == 200) {
//         final responseData = AllClientes.fromJson(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL CLIENTE PEDIDOS-DISTRIBUCION =====================================//
//   Future<AllClientePedido?> getAllClientesPedidos({
//     BuildContext? context,
//     String? search,
//     String? tipo,
//     String? token,
//   }) async {
//     try {
//       final url =
//           Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$tipo');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.statusCode == 200) {
//         final responseData = AllClientePedido.fromJson(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL GUARDIAS PEDIDOS =====================================//
//   Future<AllGuardiasPedido?> getAllGuardiasPedido({
//     BuildContext? context,
//     String? search,
//     String? docnumero,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/personas/listado/0?docnumero=$docnumero&search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.statusCode == 200) {
//         final response = AllGuardiasPedido.fromJson(dataResp.body);

//         return response;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL TIPOS DE MULTAS GUARDIAS =====================================//
//   Future<AllTiposMultasGuardias?> getAllTiposMultasGuardias({
//     BuildContext? context,
//     String? search,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/novedades/filtro/0?search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.statusCode == 200) {
//         final responseData = AllTiposMultasGuardias.fromJson(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL INFO  GUARDIAS =====================================//
//   Future<AllGuardias?> getAllInfoGuardias({
//     BuildContext? context,
//     String? search,
//     String? docnumero,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/personas/listado/0?docnumero=$docnumero&search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = AllGuardias.fromJson(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL INFO GUARDIAS CONSIGNAS =====================================//
//   Future getAllInfoGuardiasConsignas({
//     BuildContext? context,
//     String? search,
//     String? docnumero,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/personas/listado/0?docnumero=$docnumero&search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 401) {
//         Map<String, dynamic> message = jsonDecode(dataResp.body);
//         NotificatiosnService.showSnackBarError(message['msg']);
//         return null;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL INPLEMENTOS PARA GUARDIAS =====================================//
//   // Future<AllImplementoPedido?> getAllImplementoPedido({
//   //   BuildContext? context,
//   //   String? search,
//   //   String? token,
//   // }) async {
//   //   try {
//   //     final url = Uri.parse('$_dirURL/inventario/filtro/0?search=$search');

//   //     final dataResp = await _http.get(
//   //       url,
//   //       headers: {"x-auth-token": '$token'},
//   //     );

//   //     if (dataResp.body.isEmpty) {
//   //       return null;
//   //     }
//   //     if (dataResp.statusCode == 200) {
//   //       // final responseData = AllImplementoPedido.fromJson(dataResp.body);
//   //        final responseData = jsonDecode(dataResp.body);

//   //       return responseData;
//   //     }
//   //     if (dataResp.statusCode == 404) {
//   //       return null;
//   //     }
//   //     if (dataResp.statusCode == 401) {
//   //       Auth.instance.deleteSesion(context!);

//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     return null;
//   //   }
//   // }
//   Future getAllImplementoPedido({
//     BuildContext? context,
//     String? search,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/inventario/filtro/0?search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         // final responseData = AllImplementoPedido.fromJson(dataResp.body);
//          final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //=========================GET ALL INFORMES DE GUARDIAS =====================================//
//   Future getAllInformesGuardia({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/informes/filtro/0?search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 401) {
//         Map<String, dynamic> message = jsonDecode(dataResp.body);
//         NotificatiosnService.showSnackBarError(message['msg']);
//         return null;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL GUARDIAS =====================================//
//   Future getAllGuardias({
//     BuildContext? context,
//     String? search,
//     String? estado,
//     String? token,
//   }) async {
//     try {
//       final url =
//           Uri.parse('$_dirURL/personas/filtro/0?search=$search&estado=$estado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL GUARDIAS POR CLIENTES =====================================//
//   Future getAllGuardiasPorCliente({
//     String? search,
//     // String? estado,
//     String? docnumero,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/personas/listado/0?docnumero=$docnumero');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET INFO GUARDIA QR =====================================//
//   Future getGuardiaQR({
//     BuildContext? context,
//     String? codigoQR,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/personas/$codigoQR?tipo=QR');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET INFO CLIENTES QR =====================================//
//   Future getClienteQR({
//     BuildContext? context,
//     String? codigoQR,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/clientes/$codigoQR?tipo=QR');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL AVISO DE SALIDA DE LOS  GUARDIAS =====================================//
//   Future getAllAvisosSalida({
//     BuildContext? context,
//     String? search,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/avisosalidas/filtro/0?search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALLCAMBIO DE LOS  GUARDIAS =====================================//
//   Future getAllCambioPuesto({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/cambiopuesto/filtro/0?search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL AUSENCIAS DE LOS  GUARDIAS =====================================//
//   Future getAllAusencias({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/ausencias/filtro/0?search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL TURNOS EXTRAS =====================================//
//   Future getAllTurnosExtras({
//     BuildContext? context,
//     String? search,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/turnoextra/filtro/0?search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL CONSIGNAS CLIENTES  =====================================//
//   Future getAllConsignasClientes({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/consignas/filtro/0?search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL PEDIDOS GUARDIAS =====================================//
//   Future getAllPedidos({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? tipo,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           // '$_dirURL/distribucion/filtro/0?search=$search&notificacion=$notificacion&tipo=$tipo');
//           '$_dirURL/distribucion/filtro/0?search=$search&notificacion=$notificacion&tipo=$tipo');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final response = jsonDecode(dataResp.body);

//         return response;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL PEDIDOS ACTIVOS =====================================//
//   Future getAllPedidosActivos({
//     BuildContext? context,
//     String? search,
//     String? tipo,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/pedidos/pedidos_activos/0?search=$search&tipo=$tipo');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final response = jsonDecode(dataResp.body);

//         return response;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL DISTRIBUCION  =====================================//
//   Future getAllDistribucion({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? tipo,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/distribucion/filtro/0?search=$search&notificacion=$notificacion&tipo=$tipo');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final response = jsonDecode(dataResp.body);

//         return response;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL PERSONAL DESIGNADO =====================================//
//   Future<AllPersonasDesignadas?> getAllPersonalDesignado({
//     BuildContext? context,
//     String? docnumero,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/personas/listado/0?docnumero=$docnumero');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.statusCode == 200) {
//         final responseData = AllPersonasDesignadas.fromJson(dataResp.body);

//         return responseData;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL ESTADO CUENTA CLIENTES CLIENTES =====================================//
//   Future<AllEstadosCuentaCliente?> getAllEstadosdeCuentaClientes({
//     BuildContext? context,
//     int? cantidad,
//     int? page,
//     String? search,
//     String? input,
//     bool? orden,
//     String? datos,
//     String? rucempresa,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/estadocuentas?cantidad=$cantidad&page=$page&search=$search&input=$input&orden=$orden&datos=$datos&rucempresa=$rucempresa');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       if (dataResp.statusCode == 200) {
//         final responseData = AllEstadosCuentaCliente.fromJson(dataResp.body);
//         return responseData;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL ACTIVIDADES =====================================//
//   Future getAllActividades({
//     BuildContext? context,
//     String? search,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/actividades/filtro/0?search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         return 401;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL ACTIVIDADES =====================================//
//   Future getAllActividadesAsignadas({
//     BuildContext? context,
//     String? search,
//       String? notificacion,
//     String? token,
//   }) async {

//     try {

//       final url = Uri.parse('$_dirURL/actividades_asignadas/filtro/0?search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         return 401;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//   //=========================GET ALL CLIENTES =====================================//
//   Future getAllClientesVarios({
//     BuildContext? context,
//     String? search,
//     String? estado,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           'https://backsigeop.neitor.com/api/clientes/filtro/0?search=$search&estado=$estado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         // print('RESPONSE CLIENTES MULTAS: ${dataResp.body}');

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //=====================================================================================//
// //================================= TOKEN ID ==============================//
//   Future sentIdToken({
//     BuildContext? context,
//     String? tokennotificacion,
//     String? token,
//   }) async {
//     try {
//       final uri = Uri.parse('$_dirURL/notificaciones/token');
//       final headers = {
//         'Content-Type': 'application/json',
//         "x-auth-token": "$token"
//       };
//       Map<String, dynamic> body = {
//         "tokennotificacion": tokennotificacion,
//       };
//       String jsonBody = json.encode(body);
//       final encoding = Encoding.getByName('utf-8');

//       final dataResp = await _http.post(
//         uri,
//         headers: headers,
//         body: jsonBody,
//         encoding: encoding,
//       );

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL NOTIFICACIONES1 PUSH =====================================//
//   Future getAllNotificacionesPush({
//     BuildContext? context,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/notificaciones/listado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       final responseData = jsonDecode(dataResp.body);

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         // Auth.instance.deleteSesion(context!);
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL NOTIFICACIONES2 PUSH =====================================//
//   Future getAllNotificacionesPush2({
//     BuildContext? context,
//     String? token,
//   }) async {
//     try {
//       final url =
//           Uri.parse('$_dirURL/notificaciones/listado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;

//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //================================= DELETE TOKEN FIREBASE ==============================//
//   Future deleteTokenFirebase({
//     BuildContext? context,
//     String? tokennotificacion,
//     String? token,
//   }) async {
//     try {
//       final uri = Uri.parse(
//           '$_dirURL/notificaciones/token/eliminar');
//       final headers = {
//         'Content-Type': 'application/json',
//         "x-auth-token": "$token"
//       };
//       Map<String, dynamic> body = {
//         "tokennotificacion": tokennotificacion,
//       };
//       String jsonBody = json.encode(body);
//       final encoding = Encoding.getByName('utf-8');

//       final dataResp = await _http.post(
//         uri,
//         headers: headers,
//         body: jsonBody,
//         encoding: encoding,
//       );

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//         return null;
//       }
//     } catch (e) {
//        return null;
//     }
//   }

// //================================= RECOPERA TOKEN DEL SERVIDOR ==============================//
//   Future revisaTokenTurno({
//     BuildContext? context,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse('$_dirURL/session');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//      if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//        return responseData;

//       }
//       if (dataResp.statusCode == 404) {

//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//          snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         Auth.instance.deleteSesion(context!);
//        return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //=========================GET ALL PERSONAS DIRIGIDO A =====================================//
//   Future getAllPersonasDirigidoA({
//     BuildContext? context,
//     String? search,
//     String? estado,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/personas/filtroporareadepartamento/0?search=$search&estado=$estado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//================================= DELETE TOKEN FIREBASE ==============================//
  Future validaTokenUsuarios({
    String? token,
  }) async {
    try {
      final url = Uri.parse('$_dirURL/auth');

      final dataRespToken = await _http.get(
        url,
        headers: {"x-auth-token": '$token'},
      );
 if (dataRespToken.body.isEmpty) {
        return null;
      }
      if (dataRespToken.statusCode == 200) {
        final responseData = jsonDecode(dataRespToken.body);
       return responseData;
      }
      if (dataRespToken.statusCode == 404) {
        return null;
      }
      if (dataRespToken.statusCode == 401) {

        return null;
      }
    } catch (e) {
      return null;
    }
  }

//   //=========================GET ALL PREGUNTAS =====================================//
//   Future getAllPreguntas({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/encuestas_evaluaciones/filtro/0');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//   final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//       return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL BUSCA PREGUNTAS=====================================//
//   Future getSearchPreguntas({
//     BuildContext? context,
//     String? search,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/encuestas_evaluaciones/$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//  final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //========================= GUARDA ENCUESTA-ECALUACION GUARDIA =====================================//
//   Future saveEvaluacion({

//     EvaluacionesController? controller,
//     dynamic data,
//     List<TextEditingController>? controllersText,
//     String? token,
//   }) async {
//     try {
//       var _dio = Dio();
//       final dataResp = await _dio.put(
//           '$_dirURL/encuestas_evaluaciones/0',
//           data: data,
//           options: Options(headers: {'x-auth-token': '$token'}));

//       if (dataResp.data.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.data);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //=========================GET ALL INFORMACION DE JEFE OPERATIVO =====================================//
//   Future getDataJefeOperaciones({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? estado,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/personas/filtroporareadepartamento/0?search=$search&notificacion=$notificacion&estado=$estado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//  final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//        return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //=========================GET ALL CAPACITACIONES =====================================//
//   Future getAllCapacitaciones({
//     BuildContext? context,
//     String? search,
//     String? notificacion,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(
//           '$_dirURL/capacitaciones/filtro/0?search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//  final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);
//        return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //=========================GET ALL SUGERENCIAS=====================================//
//   Future getAllSugerencias({
//     BuildContext? context,
//     String? search,
//     String? tipo,
//     String? notificacion,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(

//           '$_dirURL/mejoracontinua/filtro/0?tipo=$tipo&search=$search&notificacion=$notificacion');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //=========================GET ALL SUGERENCIAS=====================================//
//   Future getGuardiasReemplazoAusencias({
//     BuildContext? context,
//     List<String>? listaIds,

//     String? token,
//   }) async {

// String  _listaTurnos='';

// _listaTurnos =listaIds!
//       .map((val) => val.trim())
//       .join(',');
//   // print(result);
//   // _listaTurnos=result;

// // print('LOS IDS:${_listaTurnos}');

//     try {
//       final url = Uri.parse(

//           '$_dirURL/turnoextra/byid?lista=$_listaTurnos');
//           // '$_dirURL/turnoextra/byid?lista=$_listaTurnos');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

// //  Future guardaInventarioInterno({
// //     BuildContext? context,
// //    dynamic infoInventarioInterno
// //   }) async {
// //     try {
// //       // print(infoInventarioInterno);
// //       final dataResp = await _http.post(

// //           Uri.parse('$_dirURL/procesando_actividades/'),
// //           body: {
// //                   "act_asigId": infoInventarioInterno['act_asigId'], //id registro
// //   "titulo": infoInventarioInterno['titulo'],
// //   "qr": "", // vacio
// //   "fotos": [], //no obligatorio (3max)
// //   "videos": [], // no obligatorio (1max)
// //   "vestimentas": infoInventarioInterno['vestimentas'],
// //   "armas":infoInventarioInterno['armas'], //formar de acuerdo al listado del endpoint (si existe true caso contrario false)
// //   "municiones": infoInventarioInterno['municiones'],
// //             });
// //       final respo = jsonDecode(dataResp.body);
// //       if (dataResp.statusCode == 404) {
// //         return null;
// //       }
// //       if (dataResp.statusCode == 200) {
// //         return respo;
// //       }
// //       if (dataResp.statusCode == 401) {
// //         Auth.instance.deleteSesion(context!);

// //         return null;
// //       }
// //     } catch (e) {
// //       print('-ERROR -> $e');
// //     }
// //   }

//  Future guardaInventarioInterno({
//     BuildContext? context,
//    dynamic infoInventarioInterno,
//     String? token,
//   }) async {
//     try {
//       final uri = Uri.parse('$_dirURL/procesando_actividades/');
//       final headers = {
//         'Content-Type': 'application/json',
//         "x-auth-token": "$token"
//       };
//       Map<String, dynamic> body = {
//                   "act_asigId": infoInventarioInterno['act_asigId'], //id registro
//   "titulo": infoInventarioInterno['titulo'],
//   "qr": "", // vacio
//   "fotos": [], //no obligatorio (3max)
//   "videos": [], // no obligatorio (1max)
//   "vestimentas": infoInventarioInterno['vestimentas'],
//   "armas":infoInventarioInterno['armas'], //formar de acuerdo al listado del endpoint (si existe true caso contrario false)
//   "municiones": infoInventarioInterno['municiones'],
//             };
//       String jsonBody = json.encode(body);
//       final encoding = Encoding.getByName('utf-8');

//       final dataResp = await _http.post(
//         uri,
//         headers: headers,
//         body: jsonBody,
//         encoding: encoding,
//       );

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);

//         return responseData;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }

// }
// //  Future guardaActividadDeRonda({
// //     BuildContext? context,
// //    dynamic infoInventarioInterno,
// //     String? token,
// //   }) async {
// //     try {
// //       // print(' longitud ${infoInventarioInterno['coordenasGps']['longitud'].runtimeType}');
// //       // print(' latitud ${infoInventarioInterno['coordenasGps']['latitud'].runtimeType}');
// //       // print(' ss ${infoInventarioInterno['coordenasGps']}');

// // // final _coordenadas=
// // // {"longitud": infoInventarioInterno['coordenasGps']['longitud'], "latitud": infoInventarioInterno['coordenasGps']['latitud']};

// // //       // print(' ok $_coordenadas}');
// // //       // print(' ==== ${infoInventarioInterno['coordenasGps']['latitud']} == ${infoInventarioInterno['coordenasGps']['longitud']}');

// //       final uri = Uri.parse('$_dirURL/procesando_actividades/');
// //       final headers = {
// //         'Content-Type': 'application/json',
// //         "x-auth-token": "$token"
// //       };
// //       Map<String, dynamic> body =

// //       {
// //     "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
// //   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
// //   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
// //   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
// //   "videos": infoInventarioInterno['videos'],
// //   "coordenasGps": infoInventarioInterno['coordenasGps']
// //       };
// //   // {infoInventarioInterno['coordenasGps'][0],infoInventarioInterno['coordenasGps'][1]}
// //   // {"longitud": infoInventarioInterno['coordenasGps']['longitud'], "latitud": infoInventarioInterno['coordenasGps']['latitud']} // obligatorio, coordenadas del punto del guardia.

// //             // };
// //       String jsonBody = json.encode(body);
// //       final encoding = Encoding.getByName('utf-8');

// //       final dataResp = await _http.post(
// //         uri,
// //         headers: headers,
// //         body: jsonBody,
// //         encoding: encoding,
// //       );
// //         print('LOS DATOS RESPONSE:${dataResp.body}');

// //       if (dataResp.statusCode == 404) {
// //         return null;
// //       }
// //       if (dataResp.statusCode == 200) {
// //         final responseData = jsonDecode(dataResp.body);
// //         print('LOS responseData:${responseData}');

// //         return responseData;
// //       }
// //       if (dataResp.statusCode == 401) {
// //         Auth.instance.deleteSesion(context!);

// //         return null;
// //       }
// //     } catch (e) {
// //       return null;
// //     }

// // }

// // Future guardaActividadDeRonda(
// //  { BuildContext? context,
// //    dynamic infoInventarioInterno,
// //     String? token,}
// // ) async {

// //   Map<String, String> headers = {
// //    'Content-Type': 'application/json',
// //         "x-auth-token": "$token"
// //   };

// //   Map<String, dynamic> body = {
// //        "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
// //   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
// //   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
// //   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
// //   "videos": infoInventarioInterno['videos'],// no obligatorio pero (1max)
// //   "coordenasGps": infoInventarioInterno['coordenasGps']

// //   };

// //   try {
// //     final response = await _http.post(
// //       Uri.parse('$_dirURL/procesando_actividades/'),
// //       headers: headers,
// //       body: jsonEncode(body),
// //     );

// //     if (response.statusCode == 200) {
// //       // Petición exitosa, maneja la respuesta según tus necesidades
// //       print('Respuesta: ${response.body}');
// //     } else {
// //       // Error en la petición, maneja el caso según tus necesidades
// //       print('Error: ${response.statusCode}');
// //     }
// //   } catch (e) {
// //     // Error al realizar la petición, maneja el caso según tus necesidades
// //     print('Error: $e');
// //   }
// // }

// Future guardaActividadDeRonda(

// {
//     BuildContext? context,
//    dynamic infoInventarioInterno,
//     String? token,
//   }

// ) async {

//   String url = '$_dirURL/procesando_actividades/';  // Reemplaza con tu URL de destino

//   // Dio dio = Dio();
// // Map<String, dynamic> data = {
//   //   "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
//   // "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
//   // "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
//   // "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
//   // "videos": infoInventarioInterno['videos'],
//   // "coordenasGps": _coordenadas
//   // //infoInventarioInterno['coordenasGps']
//   //     };
//   Map<String, dynamic> data ={};
// // if (infoInventarioInterno['lugar']=="RONDAS"){
//   final _coordenadas=
// {"longitud": infoInventarioInterno['coordenasGps']['longitud'], "latitud": infoInventarioInterno['coordenasGps']['latitud']};

// data = {
//     "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
//   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
//   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
//   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
//   "videos": infoInventarioInterno['videos'],
//    "coordenasGps":
//    {"longitud": infoInventarioInterno['coordenasGps']['longitud'], "latitud": infoInventarioInterno['coordenasGps']['latitud']}

//       };
// // }
// // else if (infoInventarioInterno['lugar']=="INVENTARIO EXTERNO") {
// //  data = {
// //     "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
// //   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
// //   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
// //   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
// //   "videos": infoInventarioInterno['videos'],
// //   };

//   try {
//     // final response = await dio.post(
//     //   url,
//     //   data: data,
//     //    options: Options(headers: {
//     //      'Content-Type': 'application/json',
//     //     'x-auth-token': '$token'
//     //     }));

//   final Map<String, String> cabeceras = {
//     'Content-Type': 'application/json',
//     'x-auth-token': '$token',
//   };

//           // print('LA DATA: ${data}');

//   final response = await _http.post(
//     Uri.parse(url),
//     headers: cabeceras,
//     body: json.encode(data), // Asegúrate de importar 'dart:convert'
//   );

//   // print('la Respuesta de laa api : ${response.data}');
//      if (response.statusCode == 404) {
//           // print('Respuesta 404: ${response.body}');
//         return null;
//       }
//       if (response.statusCode == 500) {
//           // print('Respuesta: ${response.body}');
//         return response.body;
//       }
//       if (response.statusCode == 200) {
//           // print('Respuesta: ${response.body}');
//         return response.body;
//       }
//       if (response.statusCode == 401) {
//           //  print('Respuesta 200: ${response.body}');
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     else {
//       // Error en la petición, maneja el caso según tus necesidades
//       // print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Error al realizar la petición, maneja el caso según tus necesidades
//     print('Error: $e');
//   }
// }

// Future guardaActividadDeInventario(

// {
//     BuildContext? context,
//    dynamic infoInventarioInterno,
//     String? token,
//   }

// ) async {

//   String url = '$_dirURL/procesando_actividades/';  // Reemplaza con tu URL de destino

//   Dio dio = Dio();
// // Map<String, dynamic> data = {
//   //   "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
//   // "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
//   // "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
//   // "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
//   // "videos": infoInventarioInterno['videos'],
//   // "coordenasGps": _coordenadas
//   // //infoInventarioInterno['coordenasGps']
//   //     };
//   Map<String, dynamic> data ={};

// data = {
//     "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
//   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
//   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
//   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
//   "videos": infoInventarioInterno['videos'],

//       };
// // }
// // else if (infoInventarioInterno['lugar']=="INVENTARIO EXTERNO") {
// //  data = {
// //     "act_asigId": infoInventarioInterno['act_asigId'], //id registro // id registro
// //   "titulo": infoInventarioInterno['titulo'], // input texto obligatorio (validar enter y comillas "")
// //   "qr": infoInventarioInterno['qr'], // escanear el qr (obligatorio)
// //   "fotos": infoInventarioInterno['fotos'], // no obligatorio pero (1max)
// //   "videos": infoInventarioInterno['videos'],
// //   };

//   try {
//     final response = await dio.post(
//       url,
//       data: data,
//        options: Options(headers: {
//          'Content-Type': 'application/json',
//         'x-auth-token': '$token'
//         }));
//   // print('la Respuesta de laa api : ${response.data}');
//      if (response.statusCode == 404) {
//           // print('Respuesta: ${response.data}');
//         return null;
//       }
//       if (response.statusCode == 500) {
//           // print('Respuesta: ${response.data}');
//         return response.data;
//       }
//       if (response.statusCode == 200) {
//           // print('Respuesta: ${response.data}');
//         return response.data;
//       }
//       if (response.statusCode == 401) {
//           //  print('Respuesta: ${response.data}');
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     else {
//       // Error en la petición, maneja el caso según tus necesidades
//       // print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Error al realizar la petición, maneja el caso según tus necesidades
//     print('Error: $e');
//   }
// }
// // }

// //=====================================================//
// // Future  obtenerHoraDesdeInternet() async {
// //   final response = await _http.get(Uri.parse('http://worldclockapi.com/api/json/utc/now'));

// //   if (response.statusCode == 200) {
// //     final data = jsonDecode(response.body);
// //     final hora = data['currentDateTime'];

// //     return hora;
// //   }
// //      if (response.statusCode == 404 ||response.statusCode == 401 ||response.statusCode == 500) {
// //           // print('Respuesta: ${response.data}');
// //         return null;

// //   } else {
// //     throw Exception('Error al obtener la hora desde Internet');
// //   }
// // }

// //=====================================================//

//   //=========================GET ALL COMUNICADOS CLIENTES =====================================//
//   Future getAllBitacoras({
//     BuildContext? context,
//     String? token,
//     String? search,
//     String? tipo,
//     String? idTurno,

//     String? notificacion,
//   }) async {

// String _path='';
// if(tipo=='CLIENTE'||tipo=='RESIDENTE'){
// _path='$_dirURL/bitacora/cliente_residente';

// }else{

// _path='$_dirURL/bitacora/filtro/0?&search=$search&notificacion=$notificacion&regId=$idTurno';

// }

//     try {
//       final url = Uri.parse(
//           // '$_dirURL/bitacora/filtro/0?&search=$search&notificacion=$notificacion&regId=$idTurno');
//           // '$_dirURL/bitacora/filtro/0?search&regId=1073');
//         // '$_dirURL/bitacora/cliente_residente');
//         //  '$_dirURL/$_path!');
//          _path);

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

// // print(' LA RESPUESTA DEL GET; ${dataResp.body}');

//       final respo = jsonDecode(dataResp.body);
//       if (dataResp.statusCode == 200) {
//         return respo['data'];
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL CLIENTE MULTAS GUALDIAS =====================================//

//   Future getAllPersonasBitacora({
//     BuildContext? context,
//     String? search,
//     String? regId,
//     String? cliId,
//     String? cliUbicacion,
//     String? cliPuesto,
//     String? token,
//   }) async {
//     try {
//       final url =
//           // Uri.parse('$_dirURL/clientes/filtro/0?search=$search&estado=$estado');
//           Uri.parse('$_dirURL/residentes/filtro/0?search=$search&regId=$regId&cliId=$cliId&cliUbicacion=$cliUbicacion&cliPuesto=$cliPuesto');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//         // print('Respuesta: ${respo.runtimeType}');

//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL RESIDENTES =====================================//
//   Future getAllResidentes({
//     BuildContext? context,
//     String? token,
//     String? search,
//     String? idCli,
//     String? notificacion,
//   }) async {
//     try {
//       final url = Uri.parse(
//           // '$_dirURL/residentes/byIdCliente/0?&search=$search&notificacion=$notificacion&cliId=$idCli');
//           '$_dirURL/residentes/byCliId/0?&search=$search&notificacion=$notificacion&cliId=$idCli');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//   //=========================GET ALL RESIDENTES GUARDIA=====================================//
//   Future getAllResidentesGuardia({
//     BuildContext? context,
//     String? token,
//     String? search,
//     String? regId,
//     String? cliId,
//     String? cliUbicacion,
//     String? cliPuesto,
//   }) async {
//     try {
//       final url = Uri.parse(
//           // '$_dirURL/residentes/byIdCliente/0?&search=$search&notificacion=$notificacion&cliId=$idCli');
//           // '$_dirURL/residentes/byCliId/0?&search=$search&notificacion=$notificacion&cliId=$idCli');
//           '$_dirURL/residentes/filtro/0?search=$search&regId=$regId&cliId=$cliId&cliUbicacion=$cliUbicacion&cliPuesto=$cliPuesto');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL RESIDENTES =====================================//
//   Future getClientePorId({
//     BuildContext? context,
//     String? token,
//     String? idCli,

//   }) async {
//     try {
//       final url = Uri.parse(
//           // '$_dirURL/clientes/$idCli?tipo=QR');
//           // '$_dirURL/clientes/1470?tipo=QR');
//           'https://backsigeop.neitor.com/api/clientes/1470?tipo=QR');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

// // print('EL RESPONSE : ${dataResp.body}');

//       final respo = jsonDecode(dataResp.body);
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL RESIDENTES =====================================//
//   Future getAllClienteResidentes({
//     BuildContext? context,
//     String? token,
//     String? search,
//     String? idCli,
//     String? notificacion,
//   }) async {
//     try {
//       final url = Uri.parse(
//           // '$_dirURL/residentes/byIdCliente/0?&search=$search&notificacion=$notificacion&cliId=$idCli');
//           '$_dirURL/residentes/midata/0?&search=$search&notificacion=$notificacion&cliId=$idCli');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }

//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL GUARDIAS =====================================//
//   Future getAllPersonasCliente({
//     BuildContext? context,
//     String? search,
//     String? estado,
//     String? token,
//   }) async {

//     try {
//       final url =
//           Uri.parse('$_dirURL/personas/filtro/0?search=$search&estado=$estado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   //=========================GET ALL BODEGAS PEDIDO =====================================//
//   Future getAllBodegas({
//     BuildContext? context,
//     String? search,

//     String? token,
//   }) async {

//     try {
//       final url =
//           Uri.parse('$_dirURL/bodegas/filtro/0?search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//   //=========================GET ALL INVENTARIO=====================================//
//   Future getAllInventario({
//     BuildContext? context,
//     String? search,
//     String? bodega,
//     String? tipo,

//     String? token,
//   }) async {

//     try {
//       final url =
//           Uri.parse('$_dirURL/inventario/filtroserie/0?tipo=$tipo&bodega=$bodega&nombre=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//   //=========================GET ALL INVENTARIO MUNISIONES=====================================//
//   Future getAllInventarioMunisiones({
//     BuildContext? context,
//     String? search,
//     String? bodega,
//     String? tipo,

//     String? token,
//   }) async {

//     try {
//       final url =
//           Uri.parse('$_dirURL/inventario/filtroanidado/0?tipo=$tipo&bodega=$bodega&nombre=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//   //=========================GET ALL GUARDIAS =====================================//
//   Future getAllGuardiasDeCliente({
//     BuildContext? context,
//     String? search,
//     String? documento,
//     String? token,
//   }) async {

//     try {
//       final url =
//           Uri.parse('$_dirURL/personas/listado/0?docnumero=$documento&search=$search');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

//       if (dataResp.body.isEmpty) {
//         return null;
//       }

//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//  //=========================GET ALL CLIENTE MULTAS GUALDIAS =====================================//

//   Future getAllFaltasInjustificadas({
//     BuildContext? context,
//     String? token,
//   }) async {
//     try {
//       final url =
//           Uri.parse('$_dirURL/nominanovedades/byFaltasInjustificadas');

//           final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         Auth.instance.deleteSesion(context!);

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//  //=========================GET ALL MULTAS=====================================//
//   Future getIdTurnoMultas({
//     BuildContext? context,
//     String? idTurno,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(

//           // 'https://backsigeop.neitor.com/api/nominanovedades/filtro/0?search=$search&notificacion=$notificacion');
//           '$_dirURL/nominanovedades/getMultaById?lista=$idTurno');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//   //  print('Respuesta: ${respo}');

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//  //=========================GET PERSONA POR ID=====================================//
//   Future getIdPersona({
//     BuildContext? context,
//     String? idTurno,
//     String? token,
//   }) async {
//     try {
//       final url = Uri.parse(

//           // 'https://backsigeop.neitor.com/api/nominanovedades/filtro/0?search=$search&notificacion=$notificacion');
//           '$_dirURL/personas/perfil/$idTurno');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );
//       final respo = jsonDecode(dataResp.body);

//   //  print('Respuesta: ${respo}');

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         return respo;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }
//       if (dataResp.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//  //=========================GET ALL ROLES =====================================//
//   Future getAllRolesPago({
//     BuildContext? context,
//       String? token,
//   }) async {

//     try {

//       final url = Uri.parse('$_dirURL/rolpagos/byUser');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

// // print('ROLES : ${dataResp.body}');

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }

//       if (dataResp.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;

//       }
//     } catch (e) {
//       return null;
//     }
//   }

//  //=========================GET ALL GESTIODOCUMENTAL =====================================//
//   Future getAllGestionDocumental({
//     BuildContext? context,
//     String? search,
//     String? estado,
//       String? token,
//   }) async {

//     try {

//       final url = Uri.parse('$_dirURL/acta_entrega_recepcion/byUser?search=$search&estado=$estado');

//       final dataResp = await _http.get(
//         url,
//         headers: {"x-auth-token": '$token'},
//       );

// // print('ROLES : ${dataResp.body}');

//       if (dataResp.body.isEmpty) {
//         return null;
//       }
//       if (dataResp.statusCode == 200) {
//         final responseData = jsonDecode(dataResp.body);
//         return responseData;
//       }
//       if (dataResp.statusCode == 404) {
//         return null;
//       }

//       if (dataResp.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;

//       }
//     } catch (e) {
//       return null;
//     }
//   }

//  //=========================ENVIA LOS URLTEMPORALES =====================================//

// Future saveUrlAlServidor({ BuildContext? context,File? urlFile, String? token}) async {
//   try {
//      var request = _http.MultipartRequest(
//         'POST', Uri.parse('https://backsigeop.neitor.com/api/multimedias'));

//     //for token
//     request.headers.addAll({"x-auth-token": '$token'});

//     request.files
//         .add(await _http.MultipartFile.fromPath('foto', urlFile!.path));

//     //for completeing the request
//     var response = await request.send();

//     //for getting and decoding the response into json format
//     var responsed = await _http.Response.fromStream(response);
//     // final responseData = json.decode(responsed.body);
// // print('LISTA SERVER: ${responsed.body}');
//       if (responsed.statusCode == 404) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "No se puede agregar Contenido");

//         return null;

//       }
//       if (responsed.statusCode == 200) {
//       final responseFoto = FotoUrl.fromJson(responsed.body);
//       // print('LISTA foto: ${responseFoto.urls[0].url}');
//      return  responseFoto.urls[0].url;
//       }
//       if (responsed.statusCode == 401) {
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "Debe inciar sesión nuevamente");

//         return null;

//       }

//   } catch (e) {
//  return null;
//   }

// }
 //=========================ELIMINA FOTO DEL SERVIDOS=====================================//

  Future deleteUrlDelServidor({List<Map<String, String>>? datos, String? token}) async {
    try {

var request = _http.MultipartRequest('POST', Uri.parse('$_dirURL/multimedias'));
 request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        "x-auth-token": '$token'
      });

// Convierte el array de objetos a una cadena JSON
String arrayDeObjetosJson = jsonEncode(datos);

// Añade el array de objetos al request
request.fields['eliminar'] = arrayDeObjetosJson;

var response = await request.send();
      // print('=== 200 ===> ${response.reasonPhrase}');
 if (response.statusCode == 200) {
      // print('=== 200 ===> ${response.reasonPhrase}');
      return true;
    }
    if (response.statusCode == 404) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "=== 404 ===>  No se puede agregar foto");
        return false;
       }
      if (response.statusCode == 401) {
        snaks.NotificatiosnService.showSnackBarDanger(
            "=== 401 ===>  Debe inciar sesión nuevamente");

        return false;

      }

    } catch (err) {

      return false;
    }
  }

}
