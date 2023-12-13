// import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
// import 'dart:io';
// import 'dart:io';
// import 'dart:js';

import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'package:path_provider/path_provider.dart';
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
      print('la data $respo');

  snaks.NotificatiosnService.showSnackBarDanger("${respo["msg"]}");
      if (dataResp.statusCode == 404) {
        snaks.NotificatiosnService.showSnackBarDanger("${respo["msg"]}");
        return respo["msg"];
      }
      if (dataResp.statusCode == 200) {
        // final responsData = AuthResponse.fromMap(respo);
        // return responsData;
        return respo;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return respo["msg"];
      }
    } catch (e) {
      print('-ERROR -> $e');
    }
  }

//================================= TOKEN ID ==============================//
  Future sentTokenFCM({
    BuildContext? context,
    String? option,
    String? tokennotificacion,
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$_dirURL/notificaciones/token');
      final headers = {
        'Content-Type': 'application/json',
        "x-auth-token": "$token"
      };
      Map<String, dynamic> body = {
        "option": option,
        "tokennotificacion": tokennotificacion,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      final dataResp = await _http.post(
        uri,
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );

      if (dataResp.statusCode == 404) {
        return null;
      }
      if (dataResp.statusCode == 200) {
        final responseData = jsonDecode(dataResp.body);

        return responseData;
      }
      if (dataResp.statusCode == 401) {
        Auth.instance.deleteSesion(context!);

        return null;
      }
    } catch (e) {
      return null;
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
//     var request = _http.MultipartRequest('POST', Uri.parse('$_dirURL/upload_delete_multiple_files/uploadNotToken'));
//  request.headers.addAll({
//         'Content-Type': 'multipart/form-data'
//       });

//       // Convierte el array de objetos a una cadena JSON

// // Añade el array de objetos al request
// request.fields['archivo'] = urlFile!.path;
// request.fields['tipo'] = "fotoperfil";
// request.fields['rucempresa'] = 'ULTRA2022';


var response = await request.send();

    //for token
    // request.headers.addAll({"x-auth-token": '$token'});

    // request.files
    //     .add(await _http.MultipartFile.fromPath('foto', urlFile!.path));

    //for completeing the request
    // var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await _http.Response.fromStream(response);
    // final responseData = json.decode(responsed.body);
print('LISTA SERVER ***** : ${responsed.statusCode}');
print('LISTA SERVER ***** : ${responsed}');
print('LISTA SERVER ***** : ${responsed.body}');
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


 //=========================ELIMINA FOTO DEL SERVIDOS=====================================//

//   Future deleteUrlDelServidor({Map<String, dynamic>? datos}) async {
//     try {

// var request = _http.MultipartRequest('POST', Uri.parse('$_dirURL/upload_delete_multiple_files/deleteNotToken'));
//  request.headers.addAll({
//         'Content-Type': 'application/json',
//         // "x-auth-token": '$token'
//       });

// // Convierte el array de objetos a una cadena JSON
// // String arrayDeObjetosJson = jsonEncode(datos);

// // Añade el array de objetos al request
// // request.fields['tipo'] = arrayDeObjetosJson;
// // request.fields['rucempresa'] = arrayDeObjetosJson;


// var response = await request.send();
//       // print('=== 200 ===> ${response.reasonPhrase}');
//  if (response.statusCode == 200) {
//       print('=== 200 ===> ${response.reasonPhrase}');
//       print('=== response.statusCode ===> ${response.statusCode}');
//       return true;
//     }
//     if (response.statusCode == 404) {
//         print('=== response.statusCode ===> ${response.statusCode}');
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "=== 404 ===>  No se puede agregar foto");
//         return false;
//        }
//       if (response.statusCode == 401) {
//           print('=== response.statusCode ===> ${response.statusCode}');
//         snaks.NotificatiosnService.showSnackBarDanger(
//             "=== 401 ===>  Debe inciar sesión nuevamente");

//         return false;

//       }

//     } catch (err) {
//             print('=== response.statusCode ===> ${err}');
//       return false;
//     }
//   }

  Future deleteUrlDelServidor({Map<String, dynamic>? datos}) async {
  final String serverUrl = '$_dirURL/upload_delete_multiple_files/deleteNotToken'; // Reemplaza con la URL correcta
  final Map<String, dynamic> requestData = datos!;

  try {
    final response = await _http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Imagen eliminada exitosamente');
      return true;
    } else {
      print('Error al eliminar la imagen. Código de estado: ${response.statusCode}');
      print('Respuesta del servidor: ${response.body}');
    }
  } catch (error) {
    print('Error al enviar la solicitud: $error');
  }
}





//-------------IMAGEN AL SERVIDOR----------------//
 Future getUrlsServer( File? _file ,String _tipo) async {
  var url = Uri.parse('$_dirURL/upload_delete_multiple_files/uploadNotToken');


try {
   var request = _http.MultipartRequest('POST', url);


  File imageFile = File(_file!.path);

  // Add parameters to the request
  request.fields['tipo'] = _tipo;
  request.fields['rucempresa'] = 'ULTRA2022';

  // Add the image file to the request
  request.files.add(await _http.MultipartFile.fromPath(
    'archivo',
    imageFile.path,
  ));

  // Send the request
  var response = await request.send();

    var responsed = await _http.Response.fromStream(response);
    

     

  if (response.statusCode == 200) {
    
    // print('Image responsed.body successfully. ${responsed.body}');
     Map<String, dynamic> jsonMap = json.decode(responsed.body);

  // Extraer la URL
return jsonMap['nombre'];

    
  } 
   if (response.statusCode == 404) {
        return null;
      }
      if (response.statusCode == 401) {
        // Auth.instance.deleteSesion(context!);

        return null;
      }
  
  
} catch (e) {
   print('=== response.statusCode ===> ${e}');
      return false;

}

 
  
  // else {
  //   print('Image upload failed.');
  // }
}
  // Future uploadImage({
  //   required File image,
  //    required String imageType,
  //   required String enterprices,
  // }) async {
  //   try {
  //     final url = Uri.parse('$_dirURL/upload_delete_multiple_files/uploadNotToken'); // Reemplaza con la URL correcta
  //     final request = _http.MultipartRequest('POST', url);

  //     // Adjunta la imagen al formulario multipart
  //     request.files.add(await _http.MultipartFile.fromPath(
  //       'foto',
  //       image.path,
  //       ));

  //     // Agrega otros campos al formulario multipart
  //     request.fields['archivo'] =image.path;
  //     request.fields['tipo'] = imageType;
  //     request.fields['rucempresa'] = enterprices;

  //     // Envía la solicitud y obtén la respuesta
  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       // Procesa la respuesta según tus necesidades
  //      return  await response.stream.bytesToString();
  //       // notifyListeners();
  //     } else {
  //       throw Exception('Error al cargar la imagen. Código de estado: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     throw Exception('Error al cargar la imagen: $error');
  //   }
  // }




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
  Future getAllNoticias({
    BuildContext? context,
    String? token,
    
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/noticias/listado');

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
          snaks.NotificatiosnService.showSnackBarDanger("Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }
//=========================GET ALL GRUPOS CHAT =====================================//
  Future getAllNotificaciones({
    BuildContext? context,
    String? token,
    
  }) async {
    try {
      final url = Uri.parse(
          '$_dirURL/notificaciones/listado');

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
         snaks.NotificatiosnService.showSnackBarDanger("Debe inciar sesión nuevamente");

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
         snaks.NotificatiosnService.showSnackBarDanger("Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }
//=========================GET ALL GRUPOS CHAT =====================================//
  Future getAllTodoLosChatPaginacion({
    BuildContext? context,
    int? cantidad,
    int? page,
    String? search,
    String? input,
    bool? orden,
    int? chatId,
    String? rucempresa,
    String? token,
    
  }) async {

// print('page=$page&cantidad=$cantidad&searc=$search&input=$input&orden=$orden&chat_id=$chatId');

    try {
      final url = Uri.parse(
          '$_dirURL/messages/?page=$page&cantidad=$cantidad&search=$search&input=$input&orden=$orden&chat_id=$chatId');
          // '$_dirURL/messages/?page=0&cantidad=3&search&input=message_id&orden=false&chat_id=4');

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
         snaks.NotificatiosnService.showSnackBarDanger("Debe inciar sesión nuevamente");

        return null;
      }
    } catch (e) {
      return null;
    }
  }

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


// void uploadImagenServer() async {
//   var url = Uri.parse('$_dirURL/upload_delete_multiple_files/uploadNotToken');
//   var request = _http.MultipartRequest('POST', url);

//   // Get image file from local directory
//   final directory = await getApplicationDocumentsDirectory();
//   File imageFile = File('${directory.path}/image.jpg');

//   // Add parameters to the request
//   request.fields['tipo'] = 'fotoperfil';
//   request.fields['rucempresa'] = 'ULTRA2022';

//   // Add the image file to the request
//   request.files.add(await _http.MultipartFile.fromPath(
//     'archivo',
//     imageFile.path,
//   ));

//   // Send the request
//   var response = await request.send();
//   if (response.statusCode == 200) {
//     print('Image uploaded successfully.');
//   } else {
//     print('Image upload failed.');
//   }
// }




}
