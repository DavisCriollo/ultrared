
import 'dart:io';


import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:ultrared/src/api/api_provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/home_controller.dart';
import 'package:ultrared/src/controllers/init_provider.dart';
import 'package:ultrared/src/pages/view_video_page.dart';
import 'package:ultrared/src/service/socket_service.dart';
import 'package:http/http.dart' as _http;
import 'package:ultrared/src/widgets/message.dart';


// import 'package:neitor_vet/src/api/api_provider.dart';

class ChatController extends ChangeNotifier {




  final _api = ApiProvider();
//  final _ctrlSocket= SocketModel();

  
  List _messages = [];
  List get getMessages => _messages;

  void addMessage(message) {
    // _messages.insert(0, {
    //   message
    
    // });
    // print('----> ${message}');
    notifyListeners();
  }

  String _cajaTextoChat = '';
  String get getCajaTextoChat => _cajaTextoChat;

  void setCajaText(String _value) {
    _cajaTextoChat = _value;
    print('LA CAJA DE TEXTO:*****> $_cajaTextoChat');
    notifyListeners();
  }

//================================== CREA NUEVA CONSIGNA  ==============================//
//   Future mensajeSocket(
//     BuildContext context,
//   ) async {
//     // final serviceSocket = context.read<SocketService>();
//     // final serviceSocket = Provider.of<SocketService>(context,listen:false);

//     final infoUser = await Auth.instance.getSession();
//     final _pyloadGrupos = {
//        "chat_id" : 4
//     };



//     // serviceSocket.enviarMensaje('client:lista-usuarios', {
//     //    "chat_id" : 4
//     // });
    


// // print('LOS DATOS PARA SOCKET : ${infoUser['token']}');


//   }

//   Future mensajeSocket(
//     BuildContext context,
//   ) async {
//     final serviceSocket = context.read<InitProvider>();
//     // final serviceSocket = Provider.of<SocketService>(context,listen:false);

//     final infoUser = await Auth.instance.getSession();
//     final _pyloadGrupos = {
//        "chat_id" : 4
//     };



//     // serviceSocket.enviarMensaje('client:lista-usuarios', {
//     //    "chat_id" : 4
//     // });
    


// // print('LOS DATOS PARA SOCKET : ${infoUser['token']}');


//   }






//================================== LISTAR LOS GRUPOS  ==============================//

  List _listaTodosLosGruposChat = [];
  List get getListaTodosLosGruposChat => _listaTodosLosGruposChat;

  void setListaTodosLosGruposChat(List _data) {
    _listaTodosLosGruposChat = [];

    _listaTodosLosGruposChat = _data;

    // print('_listaTodosLosGruposChat: $_listaTodosLosGruposChat');

    notifyListeners();
  }

  bool? _errorGruposChat; // sera nulo la primera vez
  bool? get getErrorGruposChat => _errorGruposChat;

  Future? buscaGruposChat(BuildContext context) async {
       final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllGruposChat(
      context: 
     context,token: dataUser['token'] );
    if (response != null) {
      _errorGruposChat = true;
      setListaTodosLosGruposChat(response['data']);

      // setListaTodasLasRazas(response['data'][0]['espRazas']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorGruposChat = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== LISTAR LOS USUARIOS CHAT ==============================//

  List _listaTodosLosUsuariosChat = [];
  List get getListaTodosLosUsuariosChat => _listaTodosLosUsuariosChat;

  void setListaTodosLosUsuariosChat(List _data) {
    _listaTodosLosUsuariosChat = [];

    _listaTodosLosUsuariosChat = _data;

    // print('_listaTodosLosUsuariosChat: $_listaTodosLosUsuariosChat');

    notifyListeners();
  }

  bool? _errorUsuariosChat; // sera nulo la primera vez
  bool? get getErrorUsuariosChat => _errorUsuariosChat;

  Future? buscaUsuariosChat(BuildContext context, int _idGrupo) async {
       final dataUser = await Auth.instance.getSession();

    final response = await _api.getAllUsuariosChat(
      context: context,
      idChat:_idGrupo,
      token: dataUser['token'] );
    if (response != null) {
      _errorUsuariosChat = true;
      setListaTodosLosUsuariosChat(response['data']);

      notifyListeners();
      return response;
    }
    if (response == null) {
      _errorUsuariosChat = false;
      notifyListeners();
      return null;
    }
    return null;
  }

//================================== LISTAR LOS USUARIOS CHAT ==============================//

  // List _listaTodosLosMesnajesChat = [];
  // List get getListaTodosLosMesnajesChat => _listaTodosLosMesnajesChat;

  // void setListaTodosLosMesnajesChat(List _data) {
  //   _listaTodosLosMesnajesChat = [];

  //   _listaTodosLosMesnajesChat = _data;

  //   print('_listaTodosLosMesnajesChat: $_listaTodosLosMesnajesChat');

  //   notifyListeners();
  // }

  // bool? _errosMesnajesChat; // sera nulo la primera vez
  // bool? get getErrosMesnajesChat => _errosMesnajesChat;

  // Future? buscsMesnajesChat(BuildContext context,String _search) async {
  //      final dataUser = await Auth.instance.getSession();

  //   // final response = await _api.getAllMensajesChat(
  //   //   context: context,
  //   //   idChat:_idGrupo,
  //   //   token: dataUser['token'] );

  //    final response = await _api.getAllMensajesChat(
  //     cantidad: 100,
  //     page: 0,
  //     search: _search,
  //     input: 'comId',
  //     orden: false,
  //     chatId: '',
  //     rucempresa: '${dataUser!.rucempresa}',
  //     token: '${dataUser.token}',
  //   );



  //   if (response != null) {
  //     _errosMesnajesChat = true;
  //     setListaTodosLosMesnajesChat(response['data']);

  //     notifyListeners();
  //     return response;
  //   }
  //   if (response == null) {
  //     _errosMesnajesChat = false;
  //     notifyListeners();
  //     return null;
  //   }
  //   return null;
  // }


 //================= LISTA PROPIETARIOS SIN PAGINACION ===================/

  List _listaTodoLosChatPaginacion = [];

  //  List _tempList = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  List get getListaTodoLosChatPaginacion => _listaTodoLosChatPaginacion;

  void setInfoBusquedaTodoLosChatPaginacion(List data ,SocketModel _crtlSocket) {
 
   List _tempList = []; 
   
   _listaTodoLosChatPaginacion.clear();
   _tempList.addAll(data);
   _tempList.reversed.toList();

   _crtlSocket.setListaDeMensajesChat({});


  _listaTodoLosChatPaginacion.addAll(_tempList);
  
    // print('TodoLosChat####################>:${_listaTodoLosChatPaginacion}');

 for (var item in _listaTodoLosChatPaginacion) {
                    _crtlSocket.setListaDeMensajesChat(item);
                  }

   
             _crtlSocket.emitEvent('client:lista-chats-grupos',{});
    notifyListeners();
  }


void addItemsChatPaginacion(Map<String,dynamic> data) {
     _listaTodoLosChatPaginacion.clear();
    _listaTodoLosChatPaginacion.addAll({data});
    print('ITEM AL CHAT ###>:${_listaTodoLosChatPaginacion}');

    notifyListeners();
  }


  bool? _errorTodoLosChatPaginacion; // sera nulo la primera vez
  bool? get getErrorTodoLosChatPaginacion => _errorTodoLosChatPaginacion;
  void setErrorTodoLosChatPaginacion(bool? value) {
    _errorTodoLosChatPaginacion = value;
    notifyListeners();
  }

  bool? _error401TodoLosChatPaginacion = false; // sera nulo la primera vez
  bool? get getError401TodoLosChatPaginacion => _error401TodoLosChatPaginacion;
  void setError401TodoLosChatPaginacion(bool? value) {
    _error401TodoLosChatPaginacion = value;
    notifyListeners();
  }

  bool _isNext = false;
  bool get getIsNext => _isNext;
  void setIsNext(bool _next) {
    _isNext = _next;
    // print('_isNext: $_isNext');

    notifyListeners();
  }

  int? _page = 0;
  int? get getpage => _page;
  void setPage(int? _pag) {
    _page = _pag;
    print('_page: $_page');

    notifyListeners();
  }

  int? _cantidad = 25;
  int? get getCantidad => _cantidad;
  void setCantidad(int? _cant) {
    _cantidad = _cant;
       print('_page: $_cantidad');
    notifyListeners();
  }

  String? _next = '';
  String? get getNext => _next;
  void setNext(String? _nex) {
    _next = _nex;
    notifyListeners();
  }

//   Future buscaAllTodoLosChatPaginacion(String? _search, bool _isSearch, int _idChat ,SocketModel _crtlSocket) async {
//     final dataUser = await Auth.instance.getSession();
// // print('usuario : ${dataUser!.rucempresa}');
//     final response = await _api.getAllTodoLosChatPaginacion(
//       cantidad: _cantidad,//_cantidad,
//       page: _page,
//       search: '',
//       input: 'message_id',
//       orden: false,
//       chatId:_idChat,
//       rucempresa:'${dataUser!['rucempresa']}',
//       token: '${dataUser!['token']}',
//     );

//     if (response != null) {
//       if (response == 401) {
//         setInfoBusquedaTodoLosChatPaginacion([],_crtlSocket);
//         _error401TodoLosChatPaginacion = true;
//         notifyListeners();
//         return response;
//       } else {
//         _errorTodoLosChatPaginacion = true;
//         if (_isSearch == true) {
//           // _listaTodoLosChatPaginacion = [];
//             notifyListeners();
//         }
//         // List<dynamic> dataSort = response['data']['results'];
//         // dataSort.sort((a, b) => b['perFecReg']!.compareTo(a['perFecReg']!));

//         setPage(response['data']['pagination']['next']);

//           List dataSort = [];
//       dataSort = response['data']['results'];
//        dataSort.sort((a, b) => a["msg_FecReg"].compareTo(b["msg_FecReg"]));
//       // dataSort.sort((a, b) => b['msg_FecReg']!.compareTo(a['msg_FecReg']!));

//         setInfoBusquedaTodoLosChatPaginacion(dataSort,_crtlSocket);
//         notifyListeners();
//         return response;
//       }
  
//       //===========================================//

//     }
//     if (response == null) {
//       _errorTodoLosChatPaginacion = false;
//       notifyListeners();
//       return null;
//     }
//   }

    
//   Future buscaAllTodoLosChatPaginacion(BuildContext context, _search, bool _isSearch, int _idChat ,SocketModel _crtlSocket) async {
//     final dataUser = await Auth.instance.getSession();
// // print('usuario : ${dataUser!.rucempresa}');
//     final response = await _api.getAllTodoLosChatPaginacion(
//       cantidad: _cantidad,//_cantidad,
//       page: _page,
//       search: '',
//       input: 'message_id',
//       orden: false,
//       chatId:_idChat,
//       rucempresa:'${dataUser!['rucempresa']}',
//       token: '${dataUser!['token']}',
//     );

//     if (response != null) {
//       if (response == 401) {
//         setInfoBusquedaTodoLosChatPaginacion([],_crtlSocket);
//         _error401TodoLosChatPaginacion = true;
//         notifyListeners();
//         return response;
//       } else {
//         _errorTodoLosChatPaginacion = true;
//         if (_isSearch == true) {
//           // _listaTodoLosChatPaginacion = [];
//             notifyListeners();
//         }
//         // List<dynamic> dataSort = response['data']['results'];
//         // dataSort.sort((a, b) => b['perFecReg']!.compareTo(a['perFecReg']!));
      

       

       
       



//           List dataSort = [];
//       dataSort = response['data']['results'];
//        dataSort.sort((a, b) => a["msg_FecReg"].compareTo(b["msg_FecReg"]));
//       //  setInfoBusquedaTodoLosChatPaginacion(dataSort,_crtlSocket);

//        setInfoBusquedaTodoLosChatPaginacion(response['data']['results'],_crtlSocket);

//    if ( _page==0 && _cantidad==5) {

//         //******/
//  _listaTodoLosChatPaginacion.clear();
//           final _ctrlHome = context.read<HomeController>();
//             final _crtlSocket = context.read<SocketModel>();
//                                   _crtlSocket.emitEvent('client:read-mensaje',
//                                   {
                                                                  
//                                       "rucempresa": "ULTRA2022", // login
//                                       "rol": _ctrlHome.getUser!['rol'], // login
//                                       "chat_id": response['data']['results'].first['chat_id'].toString(), // propiedad chat_id del mensaje
//                                       "person_id": _ctrlHome.getUser!['id'], // login
//                                       "last_read_message_id": response['data']['results'].last['message_id'].toString() // propiedad message_id del mensaje

//                                   });


// //  //******/


//         //  setUltimoMensaje( response['data']['results'].first['message_id'].toString() );
          
         
//         }

//  setPage(response['data']['pagination']['next']);

//         notifyListeners();
//         return response;
//       }
  
//       //===========================================//

//     }
//     if (response == null) {
//       _errorTodoLosChatPaginacion = false;
//       notifyListeners();
//       return null;
//     }
//   }






//---- VERIFICA EL FINAL DEL LISTVIEWPARA MOSTAR EL BOTON
//  ScrollController _scrollControllChats = ScrollController();
//   bool _showButton = false;

//   ScrollController get scrollController => _scrollController;

//   bool get showButton => _showButton;

//   ScrollProvider() {
//     _scrollController.addListener(_scrollListener);
//   }

//   void _scrollListener() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       _updateShowButton(false);
//     } else {
//       _updateShowButton(true);
//     }
//   }

//   void _updateShowButton(bool value) {
//     if (_showButton != value) {
//       _showButton = value;
//       notifyListeners();
//     }
//   }

//   void scrollToBottom() {
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
     
//     super.dispose();
//   }


  //----------BOTON MUESTRA BOTONES---------------//

 bool? _addFileChat = false;
  bool? get getFileChat => _addFileChat;
  void setFileChat(bool? _state) {
    _addFileChat = _state;


    print('ESTADO FILE CHAT :$getFileChat') ;
    notifyListeners();
  }



//*********************LOGICA PARA GRABAR AUDIO ***********************/
    AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  double _position = 0.0;
  double _duration = 1.0; // Inicializado en 1.0 para evitar la división por cero

  bool get isPlaying => _isPlaying;
  double get position => _position;
  double get duration => _duration;

  void play(String url) async {
    if (_isPlaying) {
      _audioPlayer.stop();
    } else {
      await _audioPlayer.play(url);
      _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
        _position = duration.inMilliseconds.toDouble();
        notifyListeners();
      });

      _audioPlayer.onDurationChanged.listen((Duration duration) {
        _duration = duration.inMilliseconds.toDouble();
        notifyListeners();
      });
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void seek(double value) {
    if (_isPlaying) {
      _audioPlayer.seek(Duration(milliseconds: value.toInt()));
    }
  }

  void stop() {
    _audioPlayer.stop();
    _isPlaying = false;
    _position = 0.0;
    notifyListeners();
  }
//*************  TIPO DE MENSAJE  ******************/

String? _tipoMensajeChat = '';
  String? get getTipoMensajeChat => _tipoMensajeChat;
  void setTipoMensajeChat(String? _tipo) {
    _tipoMensajeChat = _tipo;


print('EL TIPO ES ************ >>> $_tipoMensajeChat');

    notifyListeners();
  }


//-------------------------------------//
  ///AGREGAMOS LA IMAGEN EN PANTALLA ////
  String _urlImage = '';
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void setImage(File image) {
    _selectedImage = image;
    _urlImage = _selectedImage!.path;
    // getUrlServerChats( );

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
  //-------------------------------------//
  ///AGREGAMOS LA IMAGEN EN PANTALLA ////
  // String _urlVideo = '';
  // File? _selectedVideo;

  // File? get selectedVideo => _selectedVideo;

  // void setVideo(File Video) {
  //   _selectedVideo = Video;
  //   _urlVideo = _selectedVideo!.path;
  //    // getUrlServerChats( );

  //   notifyListeners();
  // }

  // void clearVideo() {
  //   _selectedVideo = null;
  //   notifyListeners();
  // }

  // void deleteVideo() {
  //   if (_selectedVideo != null) {
  //     _selectedVideo!.delete();
  //     clearImage();
  //   }
  // }

  Future getUrlServerChats() async {
      final dataUser = await Auth.instance.getSession();
    try {
      final response = await _api.getUrlServerChat(_selectedImage, '${dataUser!['token']}',);

      if (response != null) {
    
        setUrlImagenVideo(
          response.toString(),
        );
        notifyListeners();
        return response;
      }

      if (response == null) {
     
         setUrlImagenVideo("");
         notifyListeners();
         return null;
     
      }
    } catch (e) {
      return false;
    }
  }

  String _urlImageImagenVideo = "";
  String get getUrlImagenVideo => _urlImageImagenVideo;

  void setUrlImagenVideo(String _data) {
    _urlImageImagenVideo = "";
    _urlImageImagenVideo = _data;
    print('ImagenVideo URL: $_urlImageImagenVideo');


    notifyListeners();
  }

  // Future eliminaUrlServerImagenVideo(String _url) async {
  //   final Map<String, dynamic> _urlImageDelete = {
  //     "urls": [
  //       {"url": _url}
  //     ],
  //     "rucempresa": "ULTRA2022"
  //   };

  //   final response = await _api.deleteUrlDelServidor(
  //     datos: _urlImageDelete,
  //     // token: '${dataUser!.token}',
  //   );

  //   if (response != null) {
     
  //     // setListaUrlse(response['data']);
  //     // print('ES LOS URLS: ${response}');
  //     setUrlImagenVideo('');
  //     // image== null;

  //     // print('las variables : image - $_urlImage');
  //     notifyListeners();
  //     return 'true';
  //     // return response;
  //   }

  //   if (response == null) {
     
  //     print('ES LOS URLS: ${response}');
  //       setUrlImagenVideo('');
  //     notifyListeners();
  //     return null;
  //   }
  // }
//************************************************************NUEVA FORMA DEL CHAT**********************************************/

Map<String, dynamic> _infoChat={};

Map<String, dynamic> get getInfoChat=> _infoChat;

void setInfoChat(Map<String, dynamic> _inf){
_infoChat=_inf;
  print('ES _infoChat: $_infoChat');
notifyListeners();
}



// //------------------LISTA DE LOS MENSAJES ----------//
 
  Future buscaAllTodoLosChats(BuildContext context, _search, bool _isSearch, int _idChat ,SocketModel _crtlSocket) async {
    final dataUser = await Auth.instance.getSession();
// print('usuario : ${dataUser!.rucempresa}');
    final response = await _api.getAllTodoLosChatPaginacion(
      cantidad: _cantidad,//_cantidad,
      page: _page,
      search: '',
      input: 'message_id',
      orden: false,
      chatId:_idChat,
      rucempresa:'${dataUser!['rucempresa']}',
      token: '${dataUser!['token']}',
    );

    if (response != null && response['data']['results'].isNotEmpty) {
     
        List<dynamic> dataSort = response['data']['results'];
        dataSort.sort((a, b) => b['message_id']!.compareTo(a['message_id']!));



      if (_page==0) {
            //******/
 _listaTodoLosChatPaginacion.clear();
          final _ctrlHome = context.read<HomeController>();
            // final _crtlSocket = context.read<SocketModel>();
                                  _crtlSocket.emitEvent('client:read-mensaje',
                                  {
                                                                  
                                      "rucempresa": "ULTRA2022", // login
                                      "rol": _ctrlHome.getUser!['rol'], // login
                                      "chat_id": response['data']['results'].first['chat_id'].toString(), // propiedad chat_id del mensaje
                                      "person_id": _ctrlHome.getUser!['id'], // login
                                      "last_read_message_id": response['data']['results'].last['message_id'].toString() // propiedad message_id del mensaje

                                  });


// // //  //******/
           setInfoBusquedaTodoLosChats(dataSort,_crtlSocket);

     
      } else {
 setInfoBusquedaTodoLosChats(dataSort,_crtlSocket);
     
      }


       
       
setPage(response['data']['pagination']['next']);

        notifyListeners();
        return response;
      }
  
      //===========================================//

    
    if (response == null) {
      _errorTodoLosChatPaginacion = false;
      notifyListeners();
      return null;
    }
  }
    List _listaTodoLosChats = [];

  //  List _tempList = [];
  // List<TipoMulta> get getListaTodosLosTiposDeMultas => _listaTodosLosTiposDeMultas;
  void setChatSocket(Map<String,dynamic>  data ) {
_listaTodoLosChats.insert(0,{data});

 notifyListeners();
  }
  
  
  List get getListaTodoLosChats => _listaTodoLosChats;





  void setInfoBusquedaTodoLosChats(List data ,SocketModel _crtlSocket) {
 
   List _tempList = []; 
    // if (_cantidad==5 && _page==0) {
  //  _listaTodoLosChats.clear();
//  } else {
  _listaTodoLosChats.addAll(data);
  // _listaTodoLosChats.reversed;
     
//       }

  


  
    // print('NUEVO Chat####################>:${_listaTodoLosChats}');

//  _crtlSocket.setListaDeMensajesChat({});
 for (var item in data) {
                    _crtlSocket.setListaDeMensajesChat(item);
                  }

    // _ctrlSocket.setListaDeMensajesChat(data);

    notifyListeners();
  }



//***********************DESCARGAR VIDEO ************************/


bool _descargaOK=false;
bool get getDescargaOK=>_descargaOK;
void setDescargaOk(bool _inf){
_descargaOK=_inf;
  print('Boton presionado');
  notifyListeners();
}
bool _pressed=false;
bool get getPressed=>_pressed;
void setPressed(bool _pr){
_pressed=_pr;
  notifyListeners();
}
Future<void> descargarYGuardarVideo(String url,BuildContext context) async {
  // Comprueba y solicita permiso de escritura en el almacenamiento externo
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  if (status.isGranted) {
    // Configura el cliente Dio
    Dio dio = Dio();
    // Obtén el nombre del archivo desde la URL
    String fileName = url.split("/").last;
    // Define la ruta de destino en la carpeta de fotos
    String savePath = '/storage/emulated/0/DCIM/Camera/$fileName';

    try {
      // Descarga el video
      await dio.download(url, savePath);
      print('Video descargado en $savePath');
      // setDescargaOk(true);
      setPressed(false);


         Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => VideoPlayerScreen(videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4" ),
                    builder: (context) => VideoPlayerScreen(videoUrl: savePath),
                ),
              );




      // Muestra un toast indicando que la descarga se ha completado
      Fluttertoast.showToast(
        msg: 'Descarga completada ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error al descargar el video: $e');
      // setDescargaOk(false);
      setPressed(false);
      // Muestra un toast indicando que hubo un error en la descarga
      Fluttertoast.showToast(
        msg: 'Error en la descarga',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } else {
    print('Permiso de almacenamiento denegado');
  }
}

//****************************************************/
  //***************************** */

}
