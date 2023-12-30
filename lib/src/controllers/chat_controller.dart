
import 'dart:io';


import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:ultrared/src/api/api_provider.dart';
import 'package:ultrared/src/api/authentication_client.dart';
import 'package:ultrared/src/controllers/init_provider.dart';
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
    print(_cajaTextoChat);
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

    // _ctrlSocket.setListaDeMensajesChat(data);

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
    notifyListeners();
  }

  String? _next = '';
  String? get getNext => _next;
  void setNext(String? _nex) {
    _next = _nex;
    notifyListeners();
  }

  Future buscaAllTodoLosChatPaginacion(String? _search, bool _isSearch, int _idChat ,SocketModel _crtlSocket) async {
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

    if (response != null) {
      if (response == 401) {
        setInfoBusquedaTodoLosChatPaginacion([],_crtlSocket);
        _error401TodoLosChatPaginacion = true;
        notifyListeners();
        return response;
      } else {
        _errorTodoLosChatPaginacion = true;
        if (_isSearch == true) {
          // _listaTodoLosChatPaginacion = [];
            notifyListeners();
        }
        // List<dynamic> dataSort = response['data']['results'];
        // dataSort.sort((a, b) => b['perFecReg']!.compareTo(a['perFecReg']!));

        setPage(response['data']['pagination']['next']);

          List dataSort = [];
      dataSort = response['data']['results'];
       dataSort.sort((a, b) => a["msg_FecReg"].compareTo(b["msg_FecReg"]));
      // dataSort.sort((a, b) => b['msg_FecReg']!.compareTo(a['msg_FecReg']!));

        setInfoBusquedaTodoLosChatPaginacion(dataSort,_crtlSocket);
        notifyListeners();
        return response;
      }
  
      //===========================================//

    }
    if (response == null) {
      _errorTodoLosChatPaginacion = false;
      notifyListeners();
      return null;
    }
  }

    
  



// //------------------LISTA DE LOS MENSAJES ----------//
//  List<MessageChat> _mensaje = [];

//  void setMensaje(MessageChat _messaje){
//    _mensaje.insert(0, _messaje);


//    print('EL MENSAJE ${_mensaje}');
//    notifyListeners();
//  }


//---- VERIFICA EL FINAL DEL LISTVIEWPARA MOSTAR EL BOTON
 ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  ScrollController get scrollController => _scrollController;

  bool get showButton => _showButton;

  ScrollProvider() {
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _updateShowButton(false);
    } else {
      _updateShowButton(true);
    }
  }

  void _updateShowButton(bool value) {
    if (_showButton != value) {
      _showButton = value;
      notifyListeners();
    }
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
     
    super.dispose();
  }


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


}
